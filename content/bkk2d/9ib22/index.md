---
id: "pst_01kvd9vwfdf6fswd6sex77k0yf"
date: "2026-06-18T12:04:04.000Z"
updated: "2026-06-18T14:19:45.000Z"
slug: "9ib22"
type: "post"
build:
  render: "never"
  list: "local"
format: "note"
status: "published"
visibility: "public"
summary_text: "那么好吧直接让我们来把昨天的补上，刚刚又小看了几眼书。 parent机制的进一步理解 其实,uvm真正的顶层不是uvm_test，是uvm_top。什么？你从来没有亲自写过这个uvm_top？那是因为在 启动仿真时 ， UVM自动实例化了这个uvm_root的类，并把它命名为uvm_top，作为全局唯一的树根 。 问题来了，如果我一个手滑，把env在实例化时，parent参数传入了null怎么办？没关系，在设定parent之前UVM会强制进行一番检查，如果发现你的parent=null了，就会强制把你挂到uvm_top底下，这样就能保证只有一个树根了。（ 只有是uvm_component的类在这种情况下有这种性质，你自己定义出来的类没有这个功能 ）。 在代码里使用如get_parent,...child,...children（ 传入一个关联数组，它会把所有的子节点都给你塞进去 ）等函数可以得到 当前示例 的父类，以及某个特定子类（ 需要传入string name这个参数，因为可能有很多子类，所以要通过名字来区分是哪个子类 ）和所有子类 （first，next，即第一个子类，下一个子类） 通过这些函数可以得到想要的类的句柄。同时也进一步完善了整个parent机制。 UVM打印信息的控制 uvm打印信息的方式和信息的种类多种多样，学会对阅读信息的筛选是学习UVM机制的一个重要部分。有一下几个这方面的重点。 1.对uvm_info最后能被显示出来的信息的设置 其实正规的叫法应该是 设置打印信息的冗余度阈值 我们都知道，在当前每次写uvm_info的时候，都需要传入UVM_LOW这个参数，实际上，还有UVM_NONE，UVM_MEDIUM，UVM_HIGH, UVM_DEBUG（按照由低到高的顺序），你可以通过直接在文件里或者在命令行里的方式设定界限，达到只暂时数值低的信息，比如设置为UVM_LOW的话，就只展示UVM_NONE和UVM_LOW。这样就可以根据个人习惯控制信息。 2.uvm_error达到一定数量后停止仿真 同样可以通过命令行和在文件里设置error数量达到特定值之后结束仿真；同样，也可以让warning类型的消息转化为error类型后，一并统计。 3.可设置断点 不同的仿真器设置断点的方式不同，UVM为了统一也增加了一个内联断点的功能，即可通过函数设置断点。 4.可把信息导入特定文件 uvm提供了函数$fopen和set_report_severity_files，建立好文件之后，定义UVM_FILE变量，使用两个函数就可以把uvm_info或者uvm_error的信息从终端导入特定的文件。这些都需要在build_phase阶段完成（ 注意如果时递归调用，要放到build_phase最后，确保子组件全部完成实例化了 ），使用$fopen之后还需要在final_phase阶段调用$fclose关闭（ 很多组件都有UVM_FILE句柄，一般在最顶层的base_test统一关闭一次即可，无需每个组件都关闭 ）。这样信息就不会全部，杂乱无章的显示在终端。 set_report_severity_files函数不具有递归调用的方式，也就是它的组件不受影响 ，如 果想要在一个类调用了函数之后，在它的子类里同样会生效（比如我在env里定义，在agt，mon，drv，sqr中同样生效，他们的信息同样会放到特定文件里），需要使用set_report_severity_file_hier()，action同理 。 uvm不仅支持根据信息类型分类导入（是uvm_error还是uvm_info）文件，还支持根据id名导入（信息名字是来自my_drv还是my_driver亦或者是my_env），它使用到的函数是set_report_id_file。 也可以 根据严重性和id的组合来设置不同的文件 ，函数为set_report_severity_id_file()， action也可以 注意，这个函数被调用之后，只是规定了如果要写入文件，写到哪；而真正决定要不要写到文件的要看下面这点 5.控制打印信息的行为 使用set_severity_action函数可以规定特定信息的行为。比如UVM_DISPLAY—打印到终端上，UVM_LOG—打印到指定的文件里（工作前提是事先设置好日志文件），UVM_COUNT—作为结束仿真的计数目标，UVM_EXIT是直接退出仿真，UVM_STOP是停止仿真，UVM_NO_ACTION是不做任何操作。 行为叠加可以使用 | ，和FILED_AOTUMATION机制的使用是一样的，因为它们的定义也是一样的。 UVM已经对四种类型做了默认action设置，比如（UVM_FATAL, UVM_DISPLAY | UVM_EXIT）。你也可以后续在文件里再设置。 它是老大，可以对冗余阈值进行覆盖，比如如果我把UVM_INFO设置为了UVM_NO_ACTION，那么不管之前的阈值时多少，所有UVM_INFO都不会输出。"
---

    那么好吧直接让我们来把昨天的补上，刚刚又小看了几眼书。

---

# parent机制的进一步理解

    其实,uvm真正的顶层不是uvm_test，是uvm_top。什么？你从来没有亲自写过这个uvm_top？那是因为在**启动仿真时**，**UVM自动实例化了这个uvm_root的类，并把它命名为uvm_top，作为全局唯一的树根**。

    问题来了，如果我一个手滑，把env在实例化时，parent参数传入了null怎么办？没关系，在设定parent之前UVM会强制进行一番检查，如果发现你的parent=null了，就会强制把你挂到uvm_top底下，这样就能保证只有一个树根了。（**只有是uvm_component的类在这种情况下有这种性质，你自己定义出来的类没有这个功能**）。

    在代码里使用如get_parent,...child,...children（**传入一个关联数组，它会把所有的子节点都给你塞进去**）等函数可以得到**当前示例**的父类，以及某个特定子类（**需要传入string name这个参数，因为可能有很多子类，所以要通过名字来区分是哪个子类**）和所有子类**（first，next，即第一个子类，下一个子类）** 通过这些函数可以得到想要的类的句柄。同时也进一步完善了整个parent机制。

---

# UVM打印信息的控制

    uvm打印信息的方式和信息的种类多种多样，学会对阅读信息的筛选是学习UVM机制的一个重要部分。有一下几个这方面的重点。

### 1.对uvm_info最后能被显示出来的信息的设置

    其实正规的叫法应该是**设置打印信息的冗余度阈值**

    我们都知道，在当前每次写uvm_info的时候，都需要传入UVM_LOW这个参数，实际上，还有UVM_NONE，UVM_MEDIUM，UVM_HIGH, UVM_DEBUG（按照由低到高的顺序），你可以通过直接在文件里或者在命令行里的方式设定界限，达到只暂时数值低的信息，比如设置为UVM_LOW的话，就只展示UVM_NONE和UVM_LOW。这样就可以根据个人习惯控制信息。

### 2.uvm_error达到一定数量后停止仿真

    同样可以通过命令行和在文件里设置error数量达到特定值之后结束仿真；同样，也可以让warning类型的消息转化为error类型后，一并统计。

### 3.可设置断点

   不同的仿真器设置断点的方式不同，UVM为了统一也增加了一个内联断点的功能，即可通过函数设置断点。

### 4.可把信息导入特定文件

    uvm提供了函数$fopen和set_report_severity_files，建立好文件之后，定义UVM_FILE变量，使用两个函数就可以把uvm_info或者uvm_error的信息从终端导入特定的文件。这些都需要在build_phase阶段完成（**注意如果时递归调用，要放到build_phase最后，确保子组件全部完成实例化了**），使用$fopen之后还需要在final_phase阶段调用$fclose关闭（**很多组件都有UVM_FILE句柄，一般在最顶层的base_test统一关闭一次即可，无需每个组件都关闭**）。这样信息就不会全部，杂乱无章的显示在终端。

    **set_report_severity_files函数不具有递归调用的方式，也就是它的组件不受影响**，如**果想要在一个类调用了函数之后，在它的子类里同样会生效（比如我在env里定义，在agt，mon，drv，sqr中同样生效，他们的信息同样会放到特定文件里），需要使用set_report_severity_file_hier()，action同理**。

    uvm不仅支持根据信息类型分类导入（是uvm_error还是uvm_info）文件，还支持根据id名导入（信息名字是来自my_drv还是my_driver亦或者是my_env），它使用到的函数是set_report_id_file。

    也可以**根据严重性和id的组合来设置不同的文件**，函数为set_report_severity_id_file()，**action也可以**

    **注意，这个函数被调用之后，只是规定了如果要写入文件，写到哪；而真正决定要不要写到文件的要看下面这点**

### 5.控制打印信息的行为

    使用set_severity_action函数可以规定特定信息的行为。比如UVM_DISPLAY—打印到终端上，UVM_LOG—打印到指定的文件里（工作前提是事先设置好日志文件），UVM_COUNT—作为结束仿真的计数目标，UVM_EXIT是直接退出仿真，UVM_STOP是停止仿真，UVM_NO_ACTION是不做任何操作。

    行为叠加可以使用 | ，和FILED_AOTUMATION机制的使用是一样的，因为它们的定义也是一样的。

    UVM已经对四种类型做了默认action设置，比如（UVM_FATAL, UVM_DISPLAY | UVM_EXIT）。你也可以后续在文件里再设置。

    它是老大，可以对冗余阈值进行覆盖，比如如果我把UVM_INFO设置为了UVM_NO_ACTION，那么不管之前的阈值时多少，所有UVM_INFO都不会输出。

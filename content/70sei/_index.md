---
id: "pst_01kv2q491ee4ab6xp207tr4hch"
date: "2026-06-14T10:40:11.000Z"
slug: "70sei"
type: "post"
format: "note"
status: "published"
visibility: "public"
summary_text: "sequence 和 sequencer学习 今天学习了2.4.1和2.4.2，为我的整个框架增加了sequence和sequencer的部分。 sequence代替了driver中产生激励的部分，产生激励后会把包发送给sequencer，再由sequencer发送给driver。其中蕴含的运行细节如下： 1.sequence如何产生激励 sequence会定义一个名字叫body的task（ body是sequence声明好的虚任务，所有的sequence都应该通过它来产生激励 ），应该是基于UVM里某个定义好的task，你只需要在类里声明一个my_transaction后，作为参数传递给uvm_do宏，就能自动完成实例化（ 如果需要的话，因为包也可以提前实例化好再传进来 ），随机数化，并发给sequencer。 2.sequencer接收到包后怎么发送给driver 这需要i_agt里的connect_phase阶段，写下drv.seq_item_port(sqr.seq_item_export);，再在drv里通过seq_item_port.get_next_item(req) 阻塞等待sequencer把数据传递过来。获得req之后，再把req传给定义好的task one_pkt，再逐一发给接口的vif传入dut中； 这么使用的前提是uvm_sqr有成员变量seq_item_export，uvm_drv有成员变量seq_item_export，而且不需要显示指示通道的参数类型，因为UVM已经做好了 while (1) begin seq_item_port.get_next_item(req); one_pkt(req); seq_item_port.item_done(); end 这里item_done()的写法是一种保护机制。因为在sequencer发送了包之后， 直到done被调用，才会被允许发送下一次 。 get_next_item进行的是阻塞等待，其实还有try_next_item，是非阻塞的， 如果需要driver在没有新事物时候仍驱动空闲总线，try_next_item是合适的，但如果能保证driver持续被、sequencer喂数，get_next_item才是最合适的 3.sequence的启用 启用sequence只需要在任意一个uvm_component组件里启动即可，已my_env为例 virtual function void my_env::main_phase(uvm_phase phase); my_sequence seq; phase.raise_objection(this); seq = my_sequence::type_id::create(\"seq\"); seq.start(i_agt.sqr); phase.drop_objection(this); endfunction 注意，调用seq.start一定要传入它对应的sequencer的指针，不然没法发送。"
collections:
  - slug: "uvm-shi-zhan-xue-xi-guo-cheng"
    title: "《UVM实战》学习过程"
    collected_at: "2026-06-14T10:40:11.000Z"
    position: 0
    pinned_at: null
---

# **sequence 和 sequencer学习**

    今天学习了2.4.1和2.4.2，为我的整个框架增加了sequence和sequencer的部分。

    sequence代替了driver中产生激励的部分，产生激励后会把包发送给sequencer，再由sequencer发送给driver。其中蕴含的运行细节如下：

### 1.sequence如何产生激励

    sequence会定义一个名字叫body的task（**body是sequence声明好的虚任务，所有的sequence都应该通过它来产生激励**），应该是基于UVM里某个定义好的task，你只需要在类里声明一个my_transaction后，作为参数传递给uvm_do宏，就能自动完成实例化（**如果需要的话，因为包也可以提前实例化好再传进来**），随机数化，并发给sequencer。

### 2.sequencer接收到包后怎么发送给driver

    这需要i_agt里的connect_phase阶段，写下drv.seq_item_port(sqr.seq_item_export);，再在drv里通过seq_item_port.get_next_item(req) 阻塞等待sequencer把数据传递过来。获得req之后，再把req传给定义好的task one_pkt，再逐一发给接口的vif传入dut中；

    这么使用的前提是uvm_sqr有成员变量seq_item_export，uvm_drv有成员变量seq_item_export，而且不需要显示指示通道的参数类型，因为UVM已经做好了

```verilog
    while (1) begin
        seq_item_port.get_next_item(req);
        one_pkt(req);
        seq_item_port.item_done();
    end
```

    这里item_done()的写法是一种保护机制。因为在sequencer发送了包之后，**直到done被调用，才会被允许发送下一次**。

    get_next_item进行的是阻塞等待，其实还有try_next_item，是非阻塞的，**如果需要driver在没有新事物时候仍驱动空闲总线，try_next_item是合适的，但如果能保证driver持续被、sequencer喂数，get_next_item才是最合适的**

### 3.sequence的启用

    启用sequence只需要在任意一个uvm_component组件里启动即可，已my_env为例

```verilog
    virtual function void my_env::main_phase(uvm_phase phase);
        my_sequence seq;
        phase.raise_objection(this);
        seq = my_sequence::type_id::create("seq");
        seq.start(i_agt.sqr);
        phase.drop_objection(this);
    endfunction
```

    注意，调用seq.start一定要传入它对应的sequencer的指针，不然没法发送。

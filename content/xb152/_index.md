---
id: "pst_01kv366eqke4ab6xy2k5p7sk8d"
date: "2026-06-14T13:47:32.000Z"
slug: "xb152"
type: "post"
format: "note"
status: "published"
visibility: "public"
summary_text: "default_sequence机制 由前面sequence的学习可知，如果要启动sequence，需要在任意一个 component的main_phase 里raise和drop objection。如果引入了default_sequence机制，就可以自动启动。使用步骤如下 1.要在任意一个 component的build_phase 里面键入： uvm_config_db #(uvm_object_wrapper)::set(this, \"i_agt.sqr.main_phase\", \"default_squence\", \"my_sequence::type_id::get()); 这个config机制之前在vif接口连接的时候出现过，与之相比default这里有以下几个不同点： 1.第一个参数不是null了，因为top_tb不是uvm_component的一种，所以第一个参数为null，第二个参数要写成绝对路径；而这里的this就代表着当前层次，第二个参数接着细化，两个参数整合就是绝对路径； 2.关于第三第四个参数，第二个路径参数出现main_phase以及传入的参数uvm_object_wrapper等结构，书里说都是UVM的规定，就这么记就行了； 3.一般config都是成对出现的，有set也要有get，但这个不需要 2.再在sequence说明 codex说可以直接让UVM自动进行raise和drop_objection，只需要在new函数里调用函数set_automatic_phase_objection(1)，即可实现自动化。"
collections:
  - slug: "uvm-shi-zhan-xue-xi-guo-cheng"
    title: "《UVM实战》学习过程"
    collected_at: "2026-06-14T13:47:32.000Z"
    position: 0
    pinned_at: null
---

# default_sequence机制

    由前面sequence的学习可知，如果要启动sequence，需要在任意一个**component的main_phase**里raise和drop objection。如果引入了default_sequence机制，就可以自动启动。使用步骤如下

### 1.要在任意一个**component的build_phase**里面键入：

```verilog
uvm_config_db #(uvm_object_wrapper)::set(this,
                                  "i_agt.sqr.main_phase",
                                  "default_squence",
                                  "my_sequence::type_id::get());
```

    这个config机制之前在vif接口连接的时候出现过，与之相比default这里有以下几个不同点：

1.第一个参数不是null了，因为top_tb不是uvm_component的一种，所以第一个参数为null，第二个参数要写成绝对路径；而这里的this就代表着当前层次，第二个参数接着细化，两个参数整合就是绝对路径；

2.关于第三第四个参数，第二个路径参数出现main_phase以及传入的参数uvm_object_wrapper等结构，书里说都是UVM的规定，就这么记就行了；

3.一般config都是成对出现的，有set也要有get，但这个不需要

### 2.再在sequence说明

    codex说可以直接让UVM自动进行raise和drop_objection，只需要在new函数里调用函数set_automatic_phase_objection(1)，即可实现自动化。

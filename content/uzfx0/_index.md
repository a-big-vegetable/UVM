---
id: "pst_01kv8bypjte8n92jn4a347wxt1"
date: "2026-06-16T14:04:21.000Z"
slug: "uzfx0"
type: "post"
format: "note"
status: "published"
visibility: "public"
summary_text: "启动测试用例 经2.5.2的学习，我发现了一个一直被我疏忽的语法点......原来一个sv里可以定义两个类！！！（ono，为什么我连这都不知道） 言归正传，书里说到，一个dut可能会发送不同的测试用例（测试用例的文件直接包含好了sequence和base_test），那么该如何启动不同的测试用例呢？ 一种是修改run_test(\"\")里面的参数来选择，但这种方法会使每次你要修改测试用例时要修改文件，重新编译；所以还有一种是直接写下run_test()，然后在 仿真运行 通过传入命令（ 仿真运行是在编译之后，所以不用重新编译了 ） ... +UVM_TESTNAME=my_case0 就可以启动my_case0这个测试用例。 忽然发现在my_case这个类的bulid_phase里写uvm_config_db#(uvm_object_wrapper)::set的好处就是，如果在别的地方写下的话，声明sequence绝对路径的时候无法把握，是my_case0呢还是my_case1呢？但是直接就写在my_case里面的话直接在第一个参数敲下this就好了啦。"
---

# 启动测试用例

    经2.5.2的学习，我发现了一个一直被我疏忽的语法点......原来一个sv里可以定义两个类！！！（ono，为什么我连这都不知道）

    言归正传，书里说到，一个dut可能会发送不同的测试用例（测试用例的文件直接包含好了sequence和base_test），那么该如何启动不同的测试用例呢？

    一种是修改run_test("")里面的参数来选择，但这种方法会使每次你要修改测试用例时要修改文件，重新编译；所以还有一种是直接写下run_test()，然后在**仿真运行**通过传入命令（**仿真运行是在编译之后，所以不用重新编译了**）

```
... +UVM_TESTNAME=my_case0
```

    就可以启动my_case0这个测试用例。



    忽然发现在my_case这个类的bulid_phase里写uvm_config_db#(uvm_object_wrapper)::set的好处就是，如果在别的地方写下的话，声明sequence绝对路径的时候无法把握，是my_case0呢还是my_case1呢？但是直接就写在my_case里面的话直接在第一个参数敲下this就好了啦。

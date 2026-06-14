---
id: "pst_01kv39j9bqe4ab6xyqeckeent5"
date: "2026-06-14T14:46:25.000Z"
updated: "2026-06-14T14:48:03.000Z"
slug: "3rml2"
type: "post"
format: "note"
status: "published"
visibility: "public"
summary_text: "加入base_test 学到这里才知道，uvm树真正的顶层原来是base_test，目前接触到的代码告诉我他的作用是打印出测试用例有没有通过（if (err_num != 0) $display....)； 呃呃，顶层在uvm树里其实是树根哈哈哈。 然后就是，明白了在整个uvm数里，树根(base_test)是通过run_test实例化的，然后在build_phase里一层接着一层的往上实例化（ 树根在最上面，一层一层往下长出树叶 ）； 哦对了，还有: uvm_report_server server; int err_num; server = get_report_server(); err_num = server.get_severity_count(UVM_ERROR); 这里的server是把类似于所有的信息给统计起来了，base_test如果要调用统计值的话，需要通过server = get_report_server()来把句柄传进来，然后再调用函数把error数引出来用于判断这个测试有没有通过。"
collections:
  - slug: "uvm-shi-zhan-xue-xi-guo-cheng"
    title: "《UVM实战》学习过程"
    collected_at: "2026-06-14T14:46:25.000Z"
    position: 0
    pinned_at: null
---

# 加入base_test

       学到这里才知道，uvm树真正的顶层原来是base_test，目前接触到的代码告诉我他的作用是打印出测试用例有没有通过（if (err_num != 0) $display....)；

       呃呃，顶层在uvm树里其实是树根哈哈哈。

       然后就是，明白了在整个uvm数里，树根(base_test)是通过run_test实例化的，然后在build_phase里一层接着一层的往上实例化（**树根在最上面，一层一层往下长出树叶**）；

       哦对了，还有:

```verilog
    uvm_report_server server;
    int err_num;

    server = get_report_server();
    err_num = server.get_severity_count(UVM_ERROR);
```

       这里的server是把类似于所有的信息给统计起来了，base_test如果要调用统计值的话，需要通过server = get_report_server()来把句柄传进来，然后再调用函数把error数引出来用于判断这个测试有没有通过。

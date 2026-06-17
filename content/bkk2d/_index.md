---
id: "pst_01kvazrwj6fzxt57ba59zdf5wt"
date: "2026-06-17T14:29:11.000Z"
slug: "bkk2d"
type: "post"
format: "note"
status: "published"
visibility: "public"
summary_text: "今天学的有点杂... 框架搭完了之后，剩下的似乎都是各式各样的细节，没有要我手动去敲的部分（好吧其实是我有点懒懒的不想去敲），那就离闭馆前的最后半个小时记录一下吧！ crc_error 这是我回忆起来能想到的第一个点。我发送的是帧嘛，crc好像就是判断传过来的帧的有效性；为了测试dut在面对错误数据时能不能正确应对，我们会故意发送一些错误的数据，比如这里，会在transaction.sv增加crc_error的定义： ...... rand bit crc_error; ...... function void post_randomize(); if (crc_error) ; else crc = calc_crc() endfunction 先说原理：在driver.sv调用randomize()函数的时候，会有三步： 1.执行pre_randomize(); 2.把所有的rand类型的变量随机化； 3.执行post_randomize。 如果想让crc是错误的值，还需要在sequence类里写明： `uvm_do_with(tr, {tr.crc_error == 1;}) 这样的话，就可以在第二步保证crc_error的值是1，然后执行post_randomize，crc的值被随机化，没有被正确的赋为cale_crc()，这样这个错误的激励就成功的被发送出去了。 实际上，这里真正的重点是对field_automation机制的扩充，我需要在print的时候看到这个crc_error，但是它又不能参与到打包里，这样就多了一位毫不相干的错误，当遇到这种情况是，他的fied_automation可以这么写： `uvm_field_int(crc_error, UVM_ALL_ON | UVM_UNPACK) 这样crc_error就不会参与打包发送了 还有明确了uvm_component的parent机制 哦no为什么图书馆又到时间了，我每天要多出来十分钟总结！"
---

# 今天学的有点杂...

    框架搭完了之后，剩下的似乎都是各式各样的细节，没有要我手动去敲的部分（好吧其实是我有点懒懒的不想去敲），那就离闭馆前的最后半个小时记录一下吧！

### crc_error

    这是我回忆起来能想到的第一个点。我发送的是帧嘛，crc好像就是判断传过来的帧的有效性；为了测试dut在面对错误数据时能不能正确应对，我们会故意发送一些错误的数据，比如这里，会在transaction.sv增加crc_error的定义：

```verilog
    ......
    rand bit crc_error;
    ......
    function void post_randomize();
        if (crc_error)
            ;
        else
            crc = calc_crc()
    endfunction
```

    先说原理：在driver.sv调用randomize()函数的时候，会有三步：

    1.执行pre_randomize();

    2.把所有的rand类型的变量随机化；

    3.执行post_randomize。

    如果想让crc是错误的值，还需要在sequence类里写明：

```
`uvm_do_with(tr, {tr.crc_error == 1;})
```

    这样的话，就可以在第二步保证crc_error的值是1，然后执行post_randomize，crc的值被随机化，没有被正确的赋为cale_crc()，这样这个错误的激励就成功的被发送出去了。

    实际上，这里真正的重点是对field_automation机制的扩充，我需要在print的时候看到这个crc_error，但是它又不能参与到打包里，这样就多了一位毫不相干的错误，当遇到这种情况是，他的fied_automation可以这么写：

```
`uvm_field_int(crc_error, UVM_ALL_ON | UVM_UNPACK)
```

    这样crc_error就不会参与打包发送了



---

    还有明确了uvm_component的parent机制

    哦no为什么图书馆又到时间了，我每天要多出来十分钟总结！

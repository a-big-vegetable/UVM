`ifndef MY_TRANSACTION_SV
`define MY_TRANSACTION_SV

class my_transaction extends uvm_sequence_item;
    rand bit[47:0] dmac;
    rand bit[47:0] smac;
    rand bit[15:0] ether_type;
    rand bit[31:0] crc;
    rand byte      pload[];//动态数组，引出去记得new()_

    constraint pload_cons{
        pload.size() >= 46;
        pload.size() <= 1500;
    }

   function bit[31:0] calc_crc();
      return 32'h0;
   endfunction

   function void post_randomize();
      crc = calc_crc();
   endfunction

    `uvm_object_utils(my_transaction)

    function new(string name = "my_transaction");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(my_transaction)
        `uvm_field_int(dmac, UVM_ALL_ON)//UVM_ALL_ON就是所有自动化操作全部打开
        `uvm_field_int(smac, UVM_ALL_ON)
        `uvm_field_int(enter_type, UVM_ALL_ON)
        `uvm_field_array_int(pload, UVM_ALL_ON)
        `uvm_field_int(crc, UVM_LOW_ON)
    `uvm_object_utils_end
//    function void my_print();
//        $display("dmac = %0h", dmac);//%0h可以不用打印出高位没有用的0
//        $display("smac = %0h", smac);
//        $display("ether_type = %0h", ether_type);
//        for(int i = 0; i < pload.size() ; i++) begin
//            $display("pload[%0d] = %0h", i, pload[i]);
//        end
//        $display("crc = %0h", crc);
//    endfunction
//
//    function void my_copy(my_transaction tr);
//        if (tr == null) begin
//            `uvm_fatal("my_transaction", "tr is null!!!")
//        end
//        dmac = tr.dmac;
//        smac = tr.smac;
//        ether_type = tr.ether_type;
//        crc = tr.crc;
//        pload = new[tr.pload.size()];
//        for(int i = 0; i < pload.size(); i++)begin
//            pload[i] = tr.pload[i];
//        end
//    endfunction
//
//    function bit my_compore(my_transaction tr);
//        bit result;
//        if(tr == null) begin
//            `uvm_fatal("my_transaction", "tr is null")
//        end
//        result = ((dmac == tr.dmac) &&
//                  (smac == tr.smac) &&
//                  (ether_type == tr.ether_type) &&
//                  (crc == tr.crc));
//        if (pload.size() != tr.pload.size)
//            result = 0;
//        for(int i = 0; i < pload.size(); i++) begin
//            if(pload[i] != tr.pload[i])
//                result = 0;
//        end
//        return result;
//    endfunction
endclass

`endif
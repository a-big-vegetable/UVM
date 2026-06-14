`ifndef MY_MODEL_SV
`define MY_MODEL_SV

class my_model extends uvm_component;

    uvm_blocking_get_port #(my_transaction) port;
    uvm_analysis_port #(my_transaction) ap;

    extern function new(string name, uvm_component parent);
    extern function build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);

    `uvm_component_utils(my_model)
endclass

function my_model::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function my_model::build_phase(uvm_phase phase);
    super.build_phase(phase);
    port = new("port", this);
    ap = new("ap", this);
endfunction

task my_model::main_phase(uvm_phase phase);
    my_transaction tr;
    my_transaction new_tr;//tr,new_tr都是句柄类型的变量，类似安全的指针
    super.main_phase(phase);
    while(1) begin
        port.get(tr);//tr在这里被赋值了，已经指向了get传入的地方，不需要再new了
        new_tr = new("new_tr");//要再new出来一块新的内存
        new_tr.copy(tr);
        `uvm_info("my_model","get one transaction, copy and print it:", UVM_LOW)
        new_tr.print();
        ap.write(new_tr);
    end
endtask
`endif
`ifndef MY_MODEL_SV
`define MY_MODEL_SV

class my_model extends uvm_component;

    uvm_blocking_get_port #(my_transaction) port;
    uvm_analysis_port #(my_transaction) ap;

    extern function new(string name, uvm_compoent parent);
    extern function build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);

    `uvm_component_utils(my_model)
endclass

function my_model::new(string name, uvm_compoent parent);
    super.new(name, parent);
endfunction

function my_model::build_phase(uvm_phase phase);
    super.build_phase(phase);
    port = new("port", this);
    ap = new("ap", this);
endfunction

task my_model::main_phase(uvm_phase phase);
    my_transaction tr;
    my_transaction new_tr;
    super.main_phase(phase);
    while(1) begin
    port.get(tr);
    new_tr = new("new_tr", this);
    new_tr.my_copy(tr);
    
endtask
`endif
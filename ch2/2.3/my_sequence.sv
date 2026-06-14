`ifndef MY_SEQUENCE__SV
`define MY_SEQUENCE__SV

class my_sequence extends uvm_sequence #(my_transaction);
    `uvm_object_utils(my_sequence)
    my_transaction m_trans;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task body();
        phase.raise_objection(this);
        repeat(10) begin
            `uvm_do(m_trans)//帮助自动实例化，随机化，传递transaction给sequencer
        end
        #1000
        phase.drop_objection(this);
    endtask
endclass
`endif
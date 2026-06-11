`ifndef MY_AGENT_SV
`define MY_AGENT_SV

class my_agent extends uvm_agent;
    my_driver   drv;
    my_monitor  mon;
    uvm_analysis_port #(my_transaction) ap;

    function new(string name = "my_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);

    `uvm_component_utils(my_agent)
endclass

function void my_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (is_active == UVM_ACTIVE) begin
        drv = my_driver::type_id::create("drv", this);
    end
    mon = my_monitor::type_id::create("mon", this);
endfunction

function void my_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    ap = mon.ap;//不放在bulid_phase里是为了后续的可读性与维护
endfunction

`endif
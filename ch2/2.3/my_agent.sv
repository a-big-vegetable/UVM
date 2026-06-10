`ifndefine MY_AGENT_SV
`define MY_AGENT_SV

class my_agent entends uvm_agent;
    my_driver   drv;
    my_monitor  mon;

    function new(string name = "my_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    extern virtual function void bulid_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);

    `uvm_component_utils(my_agent)
endclass

`endif

function void my_agent::bulid_phase(uvm_phase phase);
    super.bulid_phase(phase);

    if (is_active == UVM_ACTIVE) begin
        drv = my_driver::type_id::create("drv", this);
    end
    mon = my_monitor::type_id::create("mon", this);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
endfunction
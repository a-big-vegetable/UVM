`ifndef MY_ENV_SV
`define MY_ENV_SV

class my_env extends uvm_env;
    my_agent i_agt;
    my_agent o_agt;
    my_model model;

    function new(string name = "my_env", uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        i_agt = my_agent::type_id::create("i_agt", this);
        o_agt = my_agent::type_id::create("o_agt", this);
        model = my_model::type_id::create("model", this);
        i_agt.is_active = UVM_ACTIVE;
        o_agt.is_active = UVM_PASSIVE;
    endfunction

    `uvm_component_utils(my_env)
endclass

`endif
`ifndef MY_ENV_SV
`define MY_ENV_SV

class my_env extends uvm_env;
    `uvm_component_utils(my_env)//最好放在最前面，class一定义就放
    my_agent i_agt;
    my_agent o_agt;
    my_model mdl;
    my_scoreboard scb;
    uvm_tlm_analysis_fifo #(my_transaction) agt_mdl_fifo;
    uvm_tlm_analysis_fifo #(my_transaction) agt_scb_fifo;
    uvm_tlm_analysis_fifo #(my_transaction) mdl_scb_fifo;

    function new(string name = "my_env", uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        i_agt = my_agent::type_id::create("i_agt", this);
        o_agt = my_agent::type_id::create("o_agt", this);
        mdl   = my_model::type_id::create("mdl",   this);
        scb   = my_scoreboard::type_id::create("scb", this);
        i_agt.is_active = UVM_ACTIVE;
        o_agt.is_active = UVM_PASSIVE;
        agt_mdl_fifo = new("agt_mdl_fifo", this);
        agt_scb_fifo = new("agt_scb_fifo", this);
        mdl_scb_fifo = new("mdl_scb_fifo", this);

    endfunction

    extern  function void connect_phase(uvm_phase phase);//extern定义不需要virtual关键字
endclass

    virtual function void my_env::connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        i_agt.ap.connect(agt_mdl_fifo.analysis_export);
        mdl.port.connect(agt_mdl_fifo.blocking_get_export);
        mdl.ap.connect(mdl_scb_fifo.analysis_export);
        scb.exp_port.connect(mdl_scb_fifo.blocking_get_export);
        o_agt.ap.connect(agt_scb_fifo.analysis_export);
        scb.act_port.connect (agt_scb_fifo.blocking_get_export);
    endfunction

`endif
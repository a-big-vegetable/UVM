`ifndef BASE_TEST_SV
`define BASE_TEST_SV

class base_test extends uvm_test;
    `uvm_compoent_utils(uvm_test)

    my_env env;
    function new(string name, uvm_compoent parent);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void report_phase(uvm_phase phase);
endclass

function void uvm_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = my_env::type_id::create("env", this);
    uvm_config_db #(uvm_object_wrapper)::set(this,
                                      "env.i_agt.sqr.main_phase",
                                      "default_sequence",
                                      my_sequence::type_id::get());
endfuntion

function void uvm_test::report_phase(uvm_phase phase);
    super.report_phase(phase);
    uvm_report_server server;
    int err_num;

    server = get_report_server();
    err_num = server.get_severity_count(UVM_ERROR);

    if (err_num != 0)begin
        $display("TEST CASE FAILED");
    end
    else begin
        $display("TEST CASE PASSED");
    end
endfunction
`endif
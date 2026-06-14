`ifndef MY_SCOREBOARD_SV
`define MY_SCOREBOARD_SV
class my_scoreboard extends uvm_scoreboard;
    my_transaction expect_queue[$];
    uvm_blocking_get_port #(my_transaction) exp_port;
    uvm_blocking_get_port #(my_transaction) act_port;
    `uvm_component_utils(my_scoreboard)

    extern virtual function new(string name, uvm_component parent = null);
    extern virtual task main_phase(uvm_phase phase);
    extern virtual function void build_phase(uvm_phase phase);
endclass

function my_scoreboard::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void my_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    exp_port = new("exp_port", this);
    act_port = new("act_port", this);
endfunction

task my_scoreboard::main_phase(uvm_phase phase);
    bit result;
    my_transaction get_expect, get_actual, temp_tran;

    super.main_phase(phase);
    fork
        while(1) begin
            exp_port.get(get_expect);
            expect_queue.push_back(get_expect);
        end
        while(1) begin
            act_port.get(get_actual);
            if(expect_queue.size() > 0) begin
                temp_tran = expect_queue.pop_front();
                result = get_actual.compare(temp_tran);
                if (result) begin
                    `uvm_info("my_scoreboard", "Compore SUCCESSFULLY", UVM_LOW)
                end
                else begin
                    `uvm_error("my_scoreboard", "Compore FAILED");
                    $display("the expect pkt is");
                    temp_tran.print();
                    $display("the actual pkt is");
                    get_actual.print();
                end
            end
            else begin
                `uvm_error("my_scoreboard", "Received from DUT, while Expect Quene is exmpt")
                $display("the unexpect pkt is");
                get_actual.print();
            end
        end
    join
endtask
`endif
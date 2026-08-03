`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

class scoreboard;
    mailbox #(transaction) expect_out;
    mailbox #(transaction) actual_out;
    transaction expect_transaction;
    transaction actual_transaction;
    int error_num = 0;
    int right_num = 0;

    function new(mailbox #(transaction) expect_out,mailbox #(transaction) actual_out);
        this.expect_out = expect_out;
        this.actual_out = actual_out;
    endfunction

    task run();
        forever begin
            expect_transaction = new();
            actual_transaction = new();
            expect_out.get(expect_transaction);
            actual_out.get(actual_transaction);
            if(expect_transaction.data != actual_transaction.data) begin
                $error("Mismatch! exp = %h, act = %h",expect_transaction.data, actual_transaction.data);
                error_num++;
            end
            else right_num++;
        end
    endtask

    function void report();
        $display("==== scoreboard report ===");
        $display("PASS: %d",  right_num);
        $display("ERROR: %d", error_num);
    endfunction
endclass
`endif
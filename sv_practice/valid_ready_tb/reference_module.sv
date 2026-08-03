`ifndef REFERENCE_SV
`define REFERENCE_SV

class reference;
    mailbox #(transaction) in_mb;
    mailbox #(transaction) expect_out;
    transaction in;
    transaction out;

    function new(mailbox #(transaction) in_mb, mailbox #(transaction) expect_out);
        this.in_mb = in_mb;
        this.expect_out = expect_out;
    endfunction

    task run();
        forever begin
            in = new();
            out = new();
            in_mb.get(in);
            out.data = in.data;
            expect_out.put(out);
        end
    endtask
endclass

`endif
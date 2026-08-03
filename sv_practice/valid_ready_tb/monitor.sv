`ifndef MONITOR_SV
`define MONITOR_SV

class monitor;
    virtual valid_ready_if.mon_mp vif;
    transaction in;
    transaction out;
    mailbox #(transaction) in_mb;
    mailbox #(transaction) out_mb;

    function new(virtual valid_ready_if.mon_mp vif, mailbox #(transaction) in_mb, mailbox #(transaction) out_mb);
        this.vif = vif;
        this.in_mb = in_mb;
        this.out_mb = out_mb;
    endfunction

    task input_mon();
        forever begin
            @(posedge vif.clk);
            if(vif.valid == 1 && vif.ready == 1) begin
                in = new();
                in.data = vif.data;   
                in_mb.put(in);
                $display("[MON] I get a input data ; data = %h", in.data);
            end
        end
    endtask

    task output_mon();
        forever begin
            @(posedge vif.clk);
                out = new();
                if(vif.valid_out) begin
                    out.data = vif.data_out;
                    out_mb.put(out);
                    $display("[MON] I get a output data ; data = %h", out.data);
                end
        end
    endtask
endclass

`endif
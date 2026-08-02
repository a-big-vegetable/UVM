`ifndef MONITOR_SV
`define MONITOR_SV

class monitor;
    virtual valid_ready_if.mon_mp vif;
    transaction mon_transaction;
    mailbox #(transaction) in_mb;
    mailbox #(transaction) out_mb;

    function new(virtual valid_ready_if.mon_mp vif);
        this.vif = vif;
    endfunction

    task input_mon();
        in_mb = new();
        forever begin
            @(posedge vif.clk);
            if(vif.valid == 1 && vif.ready == 1) begin
                mon_transaction = new();
                mon_transaction.data = vif.data;   
                in_mb.put(mon_transaction);
                $display("[MON] I get a input data ; data = %h", mon_transaction.data);
            end
        end
    endtask

endclass

`endif
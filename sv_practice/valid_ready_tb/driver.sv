`ifndef DRIVER_SV
`define DRIVER_SV

class driver;
    virtual valid_ready_if.drv_mp vif;

    function new(virtual valid_ready_if.drv_mp vif);
        this.vif = vif;
    endfunction

    transaction pack;

    task run();
        pack = new();
        forever begin
            if(!pack.randomize()) begin
                $fatal("pack.randomize fatal");
            end
            @(posedge vif.clk);
            vif.valid <= 1'b1;
            vif.data  <= pack.data;
            pack.display();
            @(posedge vif.clk iff vif.ready == 1);
            vif.valid <= 1'b0;
        end
    endtask

    task reset();
        vif.data  <= 32'b0;
        vif.valid <=  1'b0;
    endtask
endclass

`endif
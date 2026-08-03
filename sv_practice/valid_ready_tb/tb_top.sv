`timescale 1ns/1ns
`include "valid_ready_if.sv"
`include "transaction.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "reference_module.sv"
`include "dut.sv"


module tb_top;
    logic clk;
    logic rst_n;
    mailbox #(transaction) expect_out;
    mailbox #(transaction) actual_out;
    mailbox #(transaction) in_mb;

    valid_ready_if vif(
        .clk   (clk),
        .rst_n (rst_n)
    );

    dut u_dut(
        .vif       (vif)
    );

    driver my_driver;
    monitor my_monitor;
    scoreboard my_scoreboard;
    reference my_reference;

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 1'b0;
        expect_out = new();
        actual_out = new();
        in_mb =new();
        my_driver = new(vif);
        my_monitor = new(vif, in_mb, actual_out);
        my_scoreboard = new(expect_out, actual_out);
        my_reference = new(in_mb, expect_out);
        my_driver.reset();
        #20;
        rst_n = 1'b1;
        fork
            my_driver.run();
            my_monitor.input_mon();
            my_monitor.output_mon();
            my_scoreboard.run();
            my_reference.run();
        join_none
    end

    initial begin
        $display("time rst_n valid ready data valid_out data_out");
        forever begin
            @(posedge clk);
            #1;
            $display("%0t %0b %0b %0b 0x%08h %0b 0x%08h",
                     $time, rst_n, vif.valid, vif.ready, vif.data,
                     vif.valid_out, vif.data_out);
        end
    end

    initial begin
    #1000;
        my_scoreboard.report();
        $finish;
    end
endmodule

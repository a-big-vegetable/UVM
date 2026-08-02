`timescale 1ns/1ns
`include "valid_ready_if.sv"
`include "transaction.sv"
`include "driver.sv"
`include "monitor.sv"
`include "dut.sv"

module tb_top;
    logic clk;
    logic rst_n;
    logic valid_out;
    logic [31:0] data_out;

    valid_ready_if vif(
        .clk   (clk),
        .rst_n (rst_n)
    );

    dut u_dut(
        .vif       (vif),
        .valid_out (valid_out),
        .data_out  (data_out)
    );

    driver my_driver;
    monitor my_monitor;

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 1'b0;
        my_driver = new(vif);
        my_monitor = new(vif);
        my_driver.reset();
        #20;
        rst_n = 1'b1;
        fork
            my_driver.run();
            my_monitor.input_mon();
        join_none
    end

    initial begin
        $display("time rst_n valid ready data valid_out data_out");
        forever begin
            @(posedge clk);
            #1;
            $display("%0t %0b %0b %0b 0x%08h %0b 0x%08h",
                     $time, rst_n, vif.valid, vif.ready, vif.data,
                     valid_out, data_out);
        end
    end

    initial begin
        #100;
        $finish;
    end
endmodule

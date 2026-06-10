`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "my_driver.sv"

module tb_top;
reg clk;
reg rst_n;

initial begin
    clk = 0;
    forever begin
    #100ms clk = ~clk;
    end
end

initial begin
    rst_n = 0;
    #1000ms;
    rst_n = 1;
end

initial begin
    run_test("my_driver");
end

my_if input_if(clk, rst_n);
my_if output_if(clk, rst_n);

set
dut my_dut(
    .clk(clk),
    .rst_n(rst_n),
    .rx_dv(input_if.valid),
    .txd (output_if.data),
    .tx_en(output_if.valid)
)

endmodule

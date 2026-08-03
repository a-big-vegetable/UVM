interface valid_ready_if #(parameter DATA_WIDTH = 32)(input clk, input rst_n);
    logic valid;
    logic ready;
    logic [DATA_WIDTH - 1 : 0] data;
    logic                  valid_out;
    logic [DATA_WIDTH-1:0] data_out;

    modport drv_mp(input  ready, rst_n, clk,
                   output valid, data);
    modport mon_mp(input  ready, rst_n, clk, valid, data,data_out, valid_out);
    modport dut_mp(input  rst_n, clk, valid, data,
                   output ready, data_out, valid_out);

endinterface

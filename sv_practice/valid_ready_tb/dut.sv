`ifndef DUT_SV
`define DUT_SV

module dut #(
    parameter int DATA_WIDTH = 32
) (
    valid_ready_if.dut_mp vif,
    output logic                  valid_out,
    output logic [DATA_WIDTH-1:0] data_out
);

    assign vif.ready = vif.rst_n;

    always_ff @(posedge vif.clk or negedge vif.rst_n) begin
        if (!vif.rst_n) begin
            valid_out <= 1'b0;
            data_out  <= '0;
        end
        else begin
            valid_out <= vif.valid && vif.ready;
            if (vif.valid && vif.ready) begin
                data_out <= vif.data;
            end
        end
    end

endmodule

`endif

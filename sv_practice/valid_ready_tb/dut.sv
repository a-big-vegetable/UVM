`ifndef DUT_SV
`define DUT_SV

module dut #(
    parameter int DATA_WIDTH = 32
) (
    valid_ready_if.dut_mp vif
);

    assign vif.ready = vif.rst_n;

    always_ff @(posedge vif.clk or negedge vif.rst_n) begin
        if (!vif.rst_n) begin
            vif.valid_out <= 1'b0;
            vif.data_out  <= '0;
        end
        else begin
            vif.valid_out <= vif.valid && vif.ready;
            if (vif.valid && vif.ready) begin
                vif.data_out <= vif.data;
            end
        end
    end

endmodule

`endif

module packet_test;

    class packet;
        rand bit [31:0] addr;
        rand bit [31:0] data;
        rand bit [ 1:0] kind;

        constraint addr_c {
            addr inside {[8'h00:8'hff]};
        }

        constraint kind_c {
            kind inside {0,1,2};
        }

        function new(bit [31:0] addr = 32'h0,
                     bit [31:0] data = 32'h0,
                     bit [ 1:0] kind = 2'h0);
            this.addr = addr;
            this.data = data;
            this.kind = kind;
        endfunction

        function void print();
            $display("addr = 0x%08h, data = 0x%08h, kind = %0d",
                     addr, data, kind);
        endfunction
    endclass

    initial begin
        packet packet1;

        packet1 = new();

        repeat(20) begin
            packet1.randomize();
            packet1.print();
        end
    end

endmodule

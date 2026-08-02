`ifndef TRANSACTION_SV
`define TRANSACTION_SV

class transaction;
    rand bit [31:0] data;
    function new(bit [31:0]data = 32'b0);
        this.data = data;
    endfunction

    function void display();
        $display("transaction.data = 0x%08h", this.data);
    endfunction
endclass


`endif
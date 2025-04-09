`timescale 1ns / 1ps

module tb_fifo();

    reg clk;
    reg reset;
    reg [7:0] wdata;
    reg wr;
    reg rd;
    wire [7:0] rdata;
    wire empty;
    wire full;


    fifo dut (
        .clk(clk),
        .reset(reset),
        .wdata(wdata),
        .wr(wr),
        .full(full),
        .rd(rd),
        .rdata(rdata),
        .empty(empty)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        wdata = 0;
        wr = 0;
        rd = 0;
        #10; 
        reset = 0;
        #10;
        wr = 1;
        wdata = 8'haa;
        #10;
        wdata = 8'h55;
        #10;
        wr = 0;
        rd = 1;
        #20;
        $stop;
    end

endmodule

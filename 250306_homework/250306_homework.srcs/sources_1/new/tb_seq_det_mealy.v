`timescale 1ns / 1ps

module tb_seq_det_mealy;
    reg clk, rst, din_bit;
    wire dout_bit;

    seq_det_mealy UUT (
        .clk(clk),
        .rst(rst),
        .din_bit(din_bit),
        .dout_bit(dout_bit)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1; 
        din_bit = 0;
        #10 rst = 0;

        #10 din_bit = 0;
        #10 din_bit = 0;
        #10 din_bit = 1;
        #10 din_bit = 1;
        #10 din_bit = 0;
        #10 din_bit = 1;
        #10 din_bit = 1;
        #5  din_bit = 0;
        #15 din_bit = 1;
        #20;

        #10 rst = 1;
        #10 rst = 0;

        #10 din_bit = 0;
        #10 din_bit = 1;
        #10 din_bit = 1;
        #10 din_bit = 0;
        #10 din_bit = 0;

        #10 $finish;
    end

endmodule

`timescale 1ns / 1ps
// tb_RV32I.sv
module tb_RV32I();

    logic clk;
    logic reset;

    MCU dut (.*);

    always #5 clk = ~clk;

    initial begin
        clk = 0; reset = 1;
        #10 reset = 0;
        #40 $finish;
    end
endmodule

`timescale 1ns / 1ps
// tb_DedicatedProcessor.sv //0to10_sum_교수님
module tb_DedicatedProcessor();

    logic clk;
    logic reset;
    logic [7:0] outPort;

    top_DedicatedProcessor DUT(.*);

    always #5 clk = ~clk;
    
    initial begin
        clk = 0; reset = 1;
        #10 reset = 0;
        wait(outPort == 8'd55);
        #20 $finish;
    end

endmodule

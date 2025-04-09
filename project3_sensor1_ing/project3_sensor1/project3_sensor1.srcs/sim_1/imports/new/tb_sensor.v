`timescale 1ns / 1ps
// tb_sensor.v
module tb_sensor ();

    reg clk, reset, start_trigger, data;
    wire [7:0] seg_out;
    wire [3:0] seg_comm;
    wire start_tick;

    top_sensor U_top_sensor (
        .clk(clk),
        .reset(reset),
        .start_trigger(start_trigger),
        .data(data),
        .seg_out(seg_out),
        .seg_comm(seg_comm),
        .start_tick(start_tick)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        start_trigger = 0 ;
        data = 0;
        #50;
        reset =0;
        #100;
        start_trigger = 1;
        #50000000;
        data =1;
        #20000;
        data = 0;


    end
endmodule

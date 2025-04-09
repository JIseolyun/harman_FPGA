`timescale 1ns / 1ps
//top_project3.v
module top_project3 (
    input clk,
    input rst,
    input btn_start,
    input echo,
    output trig,
    //output [7:0] dist,
    output [7:0] seg,
    output [3:0] seg_comm,
    output done
);

    wire tick;
    wire start_count;
    wire [13:0] dist;

    baud_tick_1usec u_tick (
        .clk(clk),
        .rst(rst),
        .tick(tick)
    );

    US_controller u_us (
        .clk(clk),
        .rst(rst),
        .tick(tick),
        .btn_start(btn_start),
        .echo(echo),
        .trig(trig),
        .start_count(start_count),
        .done(done)
    );

    dist_calculator u_dist (
        .clk(clk),
        .rst(rst),
        .tick(tick),
        .start_count(start_count),
        .echo(echo),
        .dist(dist)
    );
    
    fnd_controller u_fnd_controller (
        .clk(clk),
        .reset(rst),
        //.bcd(127),
        .bcd(dist),                    
        .seg(seg),        
        .seg_comm(seg_comm)

    );

endmodule
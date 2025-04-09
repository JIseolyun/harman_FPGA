`timescale 1ns / 1ps

module dist_calculator(
    input clk,
    input rst,
    input tick,
    input start_count,
    input echo,
    output reg [13:0] dist
    //input [31:0] echo_time_count,
    //input in,
    //output reg distance_cm,
    //output reg out
    );

    reg [15:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            dist <= 0;
        end else if (start_count) begin
            if (echo)
                count <= count + 1;
            else begin
                dist <= count / 58;
                count <= 0;
            end
        end
    end

endmodule
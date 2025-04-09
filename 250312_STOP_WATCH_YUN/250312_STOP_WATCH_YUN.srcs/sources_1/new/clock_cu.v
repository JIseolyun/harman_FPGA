`timescale 1ns / 1ps

module Clock_CU (
    input clk,
    input reset,
    input add_sec,
    input add_min,
    input add_hour,
    output reg inc_sec,
    output reg inc_min,
    output reg inc_hour
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            inc_sec  <= 0;
            inc_min  <= 0;
            inc_hour <= 0;
        end else begin
            if (add_sec)  inc_sec  <= 1;
            if (add_min)  inc_min  <= 1;
            if (add_hour) inc_hour <= 1;
        end
    end
endmodule
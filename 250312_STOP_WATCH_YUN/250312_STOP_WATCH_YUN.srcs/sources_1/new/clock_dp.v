`timescale 1ns / 1ps

module Clock_DP (
    input clk,
    input reset,
    input inc_sec,
    input inc_min,
    input inc_hour,
    output reg [5:0] clock_sec, 
    output reg [5:0] clock_min, 
    output reg [4:0] clock_hour
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            clock_sec  <= 0;
            clock_min  <= 0;
            clock_hour <= 0;
        end else begin
            if (inc_sec) begin
                clock_sec <= clock_sec + 1;
                if (clock_sec == 59) begin
                    clock_sec <= 0;
                    clock_min <= clock_min + 1;
                end
            end
            if (inc_min) begin
                clock_min <= clock_min + 1;
                if (clock_min == 59) begin
                    clock_min <= 0;
                    clock_hour <= clock_hour + 1;
                end
            end
            if (inc_hour) begin
                clock_hour <= clock_hour + 1;
                if (clock_hour == 23) clock_hour <= 0;
            end
        end
    end
endmodule


/*
module mux_2x1 (
    input sw_mode,
    input [3:0] msec_sec,
    input [3:0] min_hour,
    output reg [3:0] bcd
);

    always @(*) begin
        case (sw_mode)
            1'b0: bcd = msec_sec;
            1'b1: bcd = min_hour;
            default: bcd = 4'hf;
        endcase
    end
endmodule*/
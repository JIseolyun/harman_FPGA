`timescale 1ns / 1ps

module STOP_Watch(
        input run,
        input clear,
        output o_dp // dp에서 나오는 출력 (2x1먹스에 들어가는거)
    );

    wire clk, reset, btn_run, btn_clear, sw_mode, fnd_comm, fnd_font;

    top_stopwatch U_top_stopwatch(
        .clk(clk),
        .reset(reset),
        .btn_run(btn_run),
        .btn_clear(btn_clear),
        .sw0(sw0),
        .fnd_comm(fnd_comm),
        .fnd_font(fnd_font)
    );

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

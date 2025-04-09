`timescale 1ns / 1ps

module Top_Module (
    input clk,
    input reset,
    input sw1,  // Stopwatch 모드 선택
    input sw2,  // Clock 모드 선택
    input start, stop, clear,  // Stopwatch 제어
    input add_sec, add_min, add_hour,  // Clock 제어
    output [7:0] fnd_font,  // 7-Segment Display
    output [3:0] fnd_comm
);
    reg mode;  // 0: Clock, 1: Stopwatch

    wire run, inc_sec, inc_min, inc_hour;
    wire [5:0] sec, min;
    wire [4:0] hour;
    wire [9:0] msec;

    // 모드 선택
    always @(posedge clk or posedge reset) begin
        if (reset) mode <= 0;  // 기본값은 Clock
        else if (sw1) mode <= 1; // Stopwatch
        else if (sw2) mode <= 0; // Clock
    end

    stopwatch_cu U_Stopwatch_CU (
        .clk(clk),
        .reset(reset),
        .i_btn_run(w_run),
        .i_btn_clear(w_clear),
        .o_run(run),
        .o_clear(clear)
    );

    stopwatch_dp U_StopWatch_DP(
        .clk(clk),
        .reset(reset),
        .run(run),
        .clear(clear),
        .msec(msec),
        .sec(sec),
        .min(min),
        .hour(hour)
    );

    // Clock 모드
    Clock_CU clock_cu (
        .clk(clk), 
        .reset(reset),
        .add_sec(add_sec), 
        .add_min(add_min), 
        .add_hour(add_hour),
        .inc_sec(inc_sec),
        .inc_min(inc_min), 
        .inc_hour(inc_hour)
    );

    Clock_DP clock_dp (
        .clk(clk), 
        .reset(reset),
        .inc_sec(inc_sec), 
        .inc_min(inc_min), 
        .inc_hour(inc_hour),
        .clock_sec(o_sec),
        .clock_min(o_min), 
        .clock_hour(o_hour)
    );

    mux_8x4 mux_8x4(
        .sw1(sw1), //
        .clock_msec(clock_msec), //
        .clock_sec(o_sec),
        .clock_min(o_min),
        .clock_hour(o_hour),
        .msec(msec),
        .sec(sec),
        .min(min),
        .hour(hour),
        .f_msec(f_msec),
        .f_sec(f_sec),
        .f_min(f_min),
        .f_hour(f_hour)
);

    fnd_controller U_Fnd_Ctrl(
        .clk(clk),
        .reset(reset),
        .mode(mode),
        .msec(f_msec),
        .sec(f_sec),
        .min(f_min),
        .hour(f_hour),
        .fnd_font(fnd_font),
        .fnd_comm(fnd_comm)
    );

endmodule

module mux_8x4 (
    input sw1,
    input [6:0] clock_msec, msec,
    input [5:0] clock_sec, sec,
    input [5:0] clock_min, min,
    input [4:0] clock_hour, hour,
    output reg [6:0] f_msec,
    output reg [5:0] f_sec,
    output reg [5:0] f_min,
    output reg [4:0] f_hour
);

    always @(*) begin
        if (sw1[0] == 1) begin
            
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
/*
module top_stopwatch (
    input clk,
    input reset,
    input btn_run,
    input btn_clear,
    input sw_mode,
    output [3:0] fnd_comm,
    output [7:0] fnd_font

);
    wire w_run, w_clear, run, clear;
    wire [6:0] msec, sec, min, hour;

    stopwatch_dp U_StopWatch_DP(
        .clk(clk),
        .reset(reset),
        .run(run),
        .clear(clear),
        .msec(msec),
        .sec(sec),
        .min(min),
        .hour(hour)
    );
    
    btn_debounce U_Btn_DB_RUN (
        .clk(clk),
        .reset(reset),
        .i_btn(btn_run),
        .o_btn(w_run)
    );

     btn_debounce U_Btn_DB_CLEAR (
        .clk(clk),
        .reset(reset),
        .i_btn(btn_clear),
        .o_btn(w_clear)
    );

    stopwatch_cu U_Stopwatch_CU (
        .clk(clk),
        .reset(reset),
        .i_btn_run(w_run),
        .i_btn_clear(w_clear),
        .o_run(run),
        .o_clear(clear)
    );

    fnd_controller U_Fnd_Ctrl (
        .clk(clk),
        .reset(reset),
        .sw_mode(sw_mode),
        .msec(msec),
        .sec(sec),
        .min(min),
        .hour(hour),
        .fnd_font(fnd_font),
        .fnd_comm(fnd_comm)
    );


endmodule
*/
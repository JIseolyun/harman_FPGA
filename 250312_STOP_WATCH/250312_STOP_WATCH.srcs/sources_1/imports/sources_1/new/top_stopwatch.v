`timescale 1ns / 1ps

module top_stopwatch (
    input clk,
    input reset,
    input btn_run,
    input btn_clear,
    input sw0,
    output [3:0] fnd_comm,
    output [7:0] fnd_font

);
    wire w_run, w_clear, run, clear;    // 반드시 선언을 해주자
    wire [6:0] msec, sec, min, hour;
    /*
    fnd_Display U_fnd_Display (
        .sw0(),
        .sw1(),
        .led1(),
        .led2(),
        .led3(),
        .led4()
    );*/

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
//디코더
/*
module fnd_Display (
    input sw0,
    input sw1,
    output led00,
    output led01,
    output led10,
    output led11
);

    // 00 -> led00
    // 01 -> led01
    // 10 -> led10
    // 11 -> led11
    always @(*) begin
        if () begin
            
        end
    end

endmodule*/
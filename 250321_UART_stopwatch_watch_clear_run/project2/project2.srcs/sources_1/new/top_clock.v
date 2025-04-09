//top_clock.v
`timescale 1ns / 1ps

module top_watch (
    input clk,
    input reset,
    // Basys3 5개 버튼
    input btnC,  // 센터: 모든 모드(둘 다)에서 reset
    input btnL,   // 왼: 스톱워치 모드에서는 run, 시계 모드에서는 시간(+1)
    input btnR,   // 오: 스톱워치 모드에서는 clear, 시계 모드에서는 미사용
    input btnU,   // 위: 시계 모드에서는 초(+1), 스톱워치 모드에서는 미사용
    input btnD,   // 아: 시계 모드에서는 분(+1), 스톱워치 모드에서는 미사용
    // 모드 선택 스위치
    input sw_clock,  // 1: 시계 모드, 0: 스톱워치 모드
    input sw_mode,  // 0: 초:밀리초 표시, 1: 시간:분 표시
    // 7세그먼트 디스플레이 출력
    output [3:0] fnd_comm,
    output [7:0] fnd_font,
    // 모드 표시 LED (4개)
    output [3:0] led
);


    // 1) 버튼 디바운스 처리
    wire w_reset, w_btnL, w_btnR, w_btnU, w_btnD;

    btn_debounce db_reset (
        .clk  (clk),
        .reset(reset),
        .i_btn(btnC),
        .o_btn(w_reset)
    );

    btn_debounce db_L (
        .clk  (clk),
        .reset(reset),
        .i_btn(btnL),
        .o_btn(w_btnL)
    );

    btn_debounce db_R (
        .clk  (clk),
        .reset(reset),
        .i_btn(btnR),
        .o_btn(w_btnR)
    );

    btn_debounce db_U (
        .clk  (clk),
        .reset(reset),
        .i_btn(btnU),
        .o_btn(w_btnU)
    );

    btn_debounce db_D (
        .clk  (clk),
        .reset(reset),
        .i_btn(btnD),
        .o_btn(w_btnD)
    );


    // 2) 모드에 따른 버튼 신호호
    wire st_run, st_clear;
    assign st_run   = (sw_clock == 0) ? w_btnL : 1'b0;
    assign st_clear = (sw_clock == 0) ? w_btnR : 1'b0;

    // 시계 모드 (sw_clock == 1)
    wire clk_hour_inc, clk_sec_inc, clk_min_inc;
    assign clk_hour_inc = (sw_clock == 1) ? w_btnL : 1'b0;
    assign clk_sec_inc  = (sw_clock == 1) ? w_btnU : 1'b0;
    assign clk_min_inc  = (sw_clock == 1) ? w_btnD : 1'b0;


    // 3) 스톱워치 (CU + DP)
    wire run, clear;
    wire [6:0] st_msec;  // 밀리초
    wire [5:0] st_sec, st_min;  // 초, 분
    wire [4:0] st_hour;  // 시

    stopwatch_cu U_stopwatch_cu (
        .clk        (clk),
        .reset      (w_reset),
        .i_btn_run  (st_run),
        .i_btn_clear(st_clear),
        .o_run      (run),
        .o_clear    (clear)
    );

    stopwatch_dp U_stopwatch_dp (
        .clk  (clk),
        .reset(w_reset),
        .run  (run),
        .clear(clear),
        .msec (st_msec),
        .sec  (st_sec),
        .min  (st_min),
        .hour (st_hour)
    );


    // 4) 시계 (CU + DP)
    wire [6:0] clk_msec;
    wire [5:0] clk_sec, clk_min;
    wire [4:0] clk_hour;

    // 시계 제어: btnL → hour, btnU → sec, btnD → min
    wire hour_inc, min_inc, sec_inc;

    clock_cu U_clk_cu (
        .clk            (clk),
        .reset          (w_reset),
        .i_btn_hour_plus(clk_hour_inc),  // btnL in 시계 모드
        .i_btn_min_plus (clk_min_inc),   // btnD in 시계 모드
        .i_btn_sec_plus (clk_sec_inc),   // btnU in 시계 모드
        .o_hour_inc     (hour_inc),
        .o_min_inc      (min_inc),
        .o_sec_inc      (sec_inc)
    );

    clock_dp U_clock_dp (
        .clk_100k(clk),
        .reset(w_reset),
        .i_hour_inc(hour_inc),
        .i_min_inc(min_inc),
        .i_sec_inc(sec_inc),
        .msec(clk_msec),
        .sec(clk_sec),
        .min(clk_min),
        .hour(clk_hour)
    );



    // 5) 7세그먼트 출력용 신호 선택 (MUX)
    wire [6:0] msec_sel = (sw_clock) ? clk_msec : st_msec;
    wire [5:0] sec_sel = (sw_clock) ? clk_sec : st_sec;
    wire [5:0] min_sel = (sw_clock) ? clk_min : st_min;
    wire [4:0] hour_sel = (sw_clock) ? clk_hour : st_hour;

    fnd_controller U_fnd_ctrl (
        .clk     (clk),
        .reset   (w_reset),
        .sw_mode (sw_mode),
        .msec    (msec_sel),
        .sec     (sec_sel),
        .min     (min_sel),
        .hour    (hour_sel),
        .fnd_font(fnd_font),
        .fnd_comm(fnd_comm)
    );


    // 6) LED 모드 표시 (4개)
    assign led[0] = (sw_clock == 1'b1 && sw_mode == 1'b1);
    assign led[1] = (sw_clock == 1'b1 && sw_mode == 1'b0);
    assign led[2] = (sw_clock == 1'b0 && sw_mode == 1'b1);
    assign led[3] = (sw_clock == 1'b0 && sw_mode == 1'b0);

endmodule
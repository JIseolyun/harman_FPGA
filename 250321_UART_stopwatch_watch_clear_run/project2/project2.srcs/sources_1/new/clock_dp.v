//clock_dp.v
`timescale 1ns / 1ps

module clock_dp (
    input clk_100k,
    input reset,
    input i_hour_inc,
    input i_min_inc,
    input i_sec_inc,
    output [6:0] msec,
    output [5:0] sec,
    output [5:0] min,
    output [4:0] hour
);
    wire w_clk_100hz;
    wire w_msec_tick, w_sec_tick, w_min_tick;
    wire sec_tick, min_tick, hour_tick;
    //msec
    time_counter #(
        .TICK_COUNT(100),
        .BIT_WIDTH(7)
    ) U_msec (
        .clk(clk_100k),
        .reset(reset),
        .tick(w_clk_100hz),
        .clear(1'b0),
        .o_time(msec),
        .o_tick(w_msec_tick)
    );

    //sec
    assign sec_tick = w_msec_tick | i_sec_inc;
    time_counter #(
        .TICK_COUNT(60),
        .BIT_WIDTH(6)
    ) U_sec (
        .clk(clk_100k),
        .reset(reset),
        .tick(sec_tick),
        .clear(1'b0),
        .o_time(sec),
        .o_tick(w_sec_tick)
    );

    //min
    assign min_tick = w_sec_tick | i_min_inc;
    time_counter #(
        .TICK_COUNT(60),
        .BIT_WIDTH(6)
    ) U_min (
        .clk(clk_100k),
        .reset(reset),
        .tick(min_tick),
        .clear(1'b0),
        .o_time(min),
        .o_tick(w_min_tick)
    );

    //hour
    assign hour_tick = w_min_tick | i_hour_inc;
    time_counter #(
        .TICK_COUNT(24),
        .BIT_WIDTH(5)
    ) U_hour (
        .clk(clk_100k),
        .reset(reset),
        .tick(hour_tick),
        .clear(1'b0),
        .o_time(hour),
        .o_tick()
    );

    clk_div_100 U_CLK_Div(
        .clk(clk_100k),
        .reset(reset),
        .run(1'b1),
        .clear(1'b0),
        .o_clk(w_clk_100hz)
    );



endmodule

module time_counter #(
    parameter TICK_COUNT = 100,
    parameter BIT_WIDTH = 7
)(
    input clk,
    input reset,
    input tick,
    input clear,
    output reg [BIT_WIDTH-1:0] o_time,
    output reg o_tick
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            o_time <= 0;
            o_tick <= 0;
        end else begin
            o_tick <= 1'b0;
            if (clear)
                o_time <= 0;
            else if (tick) begin
                if (o_time == TICK_COUNT - 1) begin
                    o_time <= 0;
                    o_tick <= 1'b1;
                end else begin
                    o_time <= o_time + 1;
                end
            end
        end
    end
endmodule

module clk_div_100 (
    input  clk,
    input  reset,
    input  run,
    input  clear,
    output o_clk
);

    //parameter FCOUNT = 1_000_000;//10; for test//1_000_000; // 100hz만들기위한
    parameter FCOUNT = 100;
    reg [$clog2(FCOUNT)-1:0] count_reg, count_next;
    reg clk_reg, clk_next;  // 출력을 f/f으로 내보내기 위해서.

    assign o_clk = clk_reg;  // 최종 출력.

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            count_reg <= 0;
            clk_reg   <= 0;
        end else begin
            count_reg <= count_next;
            clk_reg   <= clk_next;
        end
    end
    // next
    always @(*) begin
        count_next = count_reg;
        clk_next   = 1'b0;  //clk_reg;
        if (run == 1'b1) begin
            if (count_reg == FCOUNT - 1) begin
                count_next = 0;
                clk_next   = 1'b1;  // 출력 high
            end else begin
                count_next = count_reg + 1;
                clk_next   = 1'b0;
            end
        end else if (clear == 1'b1) begin
            count_next = 0;
            clk_next   = 0;
        end
    end

endmodule
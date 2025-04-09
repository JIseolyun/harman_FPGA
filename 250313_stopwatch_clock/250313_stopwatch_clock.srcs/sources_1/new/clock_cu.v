//clock_cu.v
`timescale 1ns / 1ps

module clock_cu (
    input clk,
    input reset,

    // 버튼 입력
    input i_btn_hour_plus,
    input i_btn_min_plus,
    input i_btn_sec_plus,

    // 내부에서 DP에게 inc 신호 전송
    output reg o_hour_inc,
    output reg o_min_inc,
    output reg o_sec_inc
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            o_hour_inc <= 0;
            o_min_inc  <= 0;
            o_sec_inc  <= 0;
        end else begin
            // 매 클럭마다 기본값 0
            o_hour_inc <= 1'b0;
            o_min_inc  <= 1'b0;
            o_sec_inc  <= 1'b0;
            // 버튼이 눌린 순간에만 1 클럭동안
            if (i_btn_hour_plus) o_hour_inc <= 1'b1;
            if (i_btn_min_plus) o_min_inc <= 1'b1;
            if (i_btn_sec_plus) o_sec_inc <= 1'b1;
        end
    end
endmodule

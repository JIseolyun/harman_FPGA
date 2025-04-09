`timescale 1ns / 1ps

`timescale 1ns / 1ps

module fnd_controller (
    input clk,
    input reset,
    input [13:0] bcd,
    output [7:0] seg,
    output [3:0] seg_comm
);
    // 10000진 카운터
    // 0~9999 -> 몇 비트로 처리해야 하는가? -> log2(9999)
    // $clog2())-1:0
    // assign seg_comm = 4'b1110;  // segment 0의 자리 on, seg는 anode type

    wire [3:0] w_digit_1;
    wire [3:0] w_digit_10;
    wire [3:0] w_digit_100;
    wire [3:0] w_digit_1000;
    wire [3:0] w_bcd;
    wire [1:0] w_seg_sel;
    wire w_clk_100hz;

    clk_divider U_Clk_Divider (
        .clk  (clk),
        .reset(reset),
        .o_clk(w_clk_100hz)
    );

    counter_4 U_counter_4 (
        .clk  (w_clk_100hz),
        .reset(reset),
        .o_sel(w_seg_sel)
    );

    docoder_2x4 U_docoder_2x4 (
        .seg_sel (w_seg_sel),
        .seg_comm(seg_comm)
    );

    digit_splitter U_digit_splitter (
        .bcd(bcd),
        .digit_1(w_digit_1),
        .digit_10(w_digit_10),
        .digit_100(w_digit_100),
        .digit_1000(w_digit_1000)
    );

    mux_4x1 U_mux_4x1 (
        .sel(w_seg_sel),
        .digit_1(w_digit_1),
        .digit_10(w_digit_10),
        .digit_100(w_digit_100),
        .digit_1000(w_digit_1000),
        .bcd(w_bcd)
    );

    bcdtoseg U_bcdtoseg (
        .bcd(w_bcd),
        .seg(seg)
    );
endmodule
/*
module clk_divider (
    input  clk,
    input  reset,
    output o_clk
);

    // reg [19:0] r_counter;
    parameter FCOUNT = 10_000_000; // 100MHz -> 10Hz
    reg [$clog2(FCOUNT)-1:0] r_counter;  //$clog2 : 수의 필요한 비트수 계산
    reg r_clk;
    assign o_clk = r_clk;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            r_counter <= 0;  // 리셋상태
            r_clk <= 1'b0;
        end else begin
            // clock divide 계산, 
            if (r_counter == FCOUNT - 1) begin
                r_counter <= 0;
                r_clk <= ~r_clk;
                //r_clk <= 1'b1;  // r_clk : 0->1
            end else begin
                r_counter <= r_counter + 1;
                //r_clk <= 1'b0;  // r_clk : 1->0, 0->0 : 0으로 유지
            end
        end
    end

endmodule*/

module clk_divider (
    input  clk,
    input  reset,
    output o_clk
);

    // reg [19:0] r_counter;
    parameter FCOUNT = 1_000_000 ;
    reg [$clog2(FCOUNT)-1:0] r_counter;  //$clog2 : 수의 필요한 비트수 계산
    reg r_clk;
    assign o_clk = r_clk;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            r_counter <= 0;  // 리셋상태
            r_clk <= 1'b0;
        end else begin
            // clock divide 계산, 100Mhz -> 100hz
            if (r_counter == FCOUNT - 1) begin
                r_counter <= 0;
                r_clk <= 1'b1;  // r_clk : 0->1
            end else begin
                r_counter <= r_counter + 1;
                r_clk <= 1'b0;  // r_clk : 1->0, 0->0 : 0으로 유지
            end
        end
    end

endmodule

module counter_4 (
    input clk,
    input reset,
    output [1:0] o_sel
);
    reg [1:0] r_counter;
    assign o_sel = r_counter;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            r_counter <= 0;
        end else begin
            r_counter <= r_counter + 1;
        end
    end

endmodule


module docoder_2x4 (
    input [1:0] seg_sel,
    output reg [3:0] seg_comm
);

    // 2x4 decoder
    always @(seg_sel) begin  // * : 모든 입력을 감시한다
        case (seg_sel)
            2'b00:   seg_comm = 4'b1110;
            2'b01:   seg_comm = 4'b1101;
            2'b10:   seg_comm = 4'b1011;
            2'b11:   seg_comm = 4'b0111;
            default: seg_comm = 4'b1110;
        endcase
    end

endmodule

module digit_splitter (
    input  [13:0] bcd,
    output [3:0] digit_1,
    output [3:0] digit_10,
    output [3:0] digit_100,
    output [3:0] digit_1000
);
    assign digit_1 = bcd % 10;
    assign digit_10 = bcd / 10 % 10;
    assign digit_100 = bcd / 100 % 10;
    assign digit_1000 = bcd / 1000 % 10;

endmodule

module mux_4x1 (
    input  [1:0] sel,
    input  [3:0] digit_1,
    input  [3:0] digit_10,
    input  [3:0] digit_100,
    input  [3:0] digit_1000,
    output [3:0] bcd
);

    // 이러게 안하고 위에 reg 해도 됨
    reg [3:0] r_bcd;
    assign bcd = r_bcd;
    always @(sel, digit_1, digit_10, digit_100, digit_1000) begin
        case (sel)
            2'b00:   r_bcd = digit_1;
            2'b01:   r_bcd = digit_10;
            2'b10:   r_bcd = digit_100;
            2'b11:   r_bcd = digit_1000;
            default: r_bcd = 4'bx;
        endcase
    end

endmodule

module bcdtoseg (
    input [3:0] bcd,  // [3:0] sum 값
    output reg [7:0] seg  // reg type 지정 (default: wire)
);
    // always 구문은 출력으로 wire X, reg type을 가져야 한다
    always @(bcd) begin     // 항상 @(이벤트 대상) 감시. begin부터 end를 실행

        case (bcd)  // if문
            4'h0: seg = 8'hC0;
            4'h1: seg = 8'hF9;
            4'h2: seg = 8'hA4;
            4'h3: seg = 8'hB0;
            4'h4: seg = 8'h99;
            4'h5: seg = 8'h92;
            4'h6: seg = 8'h82;
            4'h7: seg = 8'hF8;
            4'h8: seg = 8'h80;
            4'h9: seg = 8'h90;
            4'hA: seg = 8'h88;
            4'hB: seg = 8'h83;
            4'hC: seg = 8'hC6;
            4'hD: seg = 8'hA1;
            4'hE: seg = 8'h86;
            4'hF: seg = 8'h8E;
            default: seg = 8'hff;
        endcase
    end
endmodule


















/*
module fnd_controller(
    input clk,
    input rst,
    input [15:0] dist,           
    output reg [3:0] an,         // 자리 선택
    output reg [6:0] seg,        
    output reg dp               // 소수점 off
);

    reg [3:0] digit0, digit1, digit2, digit3;
    reg [1:0] scan_cnt;
    reg [19:0] clkdiv;

    integer temp;
    // 거리 값 10진수 변환
    always @(*) begin
        temp = dist;
        digit3 = temp / 1000;
        temp = temp % 1000;
        digit2 = temp / 100;
        temp = temp % 100;
        digit1 = temp / 10;
        digit0 = temp % 10;
    end

    // 스캔 주기 생성 (약 1ms = 100kHz 기준 100,000clk)
    always @(posedge clk or posedge rst) begin
        if (rst)
            clkdiv <= 0;
        else
            clkdiv <= clkdiv + 1;
    end

    // 자리 선택 스캔 (1ms마다 자리 바꿈)
    always @(posedge clk or posedge rst) begin
        if (rst)
            scan_cnt <= 0;
        else if (clkdiv == 100_000) begin
            scan_cnt <= scan_cnt + 1;
            clkdiv <= 0;
        end
    end

    // an 및 seg 출력
    reg [3:0] cur_digit;
    always @(*) begin
        dp = 1'b1; // 소수점 off
        case (scan_cnt)
            2'd0: begin an = 4'b1110; cur_digit = digit0; end
            2'd1: begin an = 4'b1101; cur_digit = digit1; end
            2'd2: begin an = 4'b1011; cur_digit = digit2; end
            2'd3: begin an = 4'b0111; cur_digit = digit3; end
            default: begin an = 4'b1111; cur_digit = 4'd15; end
        endcase

        seg = seg_decode(cur_digit);
    end

    // 숫자 -> 7세그먼트 디코딩
    function [6:0] seg_decode;
        input [3:0] num;
        begin
            case (num)
                4'd0: seg_decode = 7'b1000000;
                4'd1: seg_decode = 7'b1111001;
                4'd2: seg_decode = 7'b0100100;
                4'd3: seg_decode = 7'b0110000;
                4'd4: seg_decode = 7'b0011001;
                4'd5: seg_decode = 7'b0010010;
                4'd6: seg_decode = 7'b0000010;
                4'd7: seg_decode = 7'b1111000;
                4'd8: seg_decode = 7'b0000000;
                4'd9: seg_decode = 7'b0010000;
                default: seg_decode = 7'b1111111;
            endcase
        end
    endfunction
endmodule*/

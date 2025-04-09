`timescale 1ns / 1ps

module fnd_controller (
    input clk,
    input reset,
    input [13:0] bcd,
    output [7:0] seg,
    output [3:0] seg_comm
);
    wire [3:0] w_bcd;
    wire [3:0] w_sec_digit_1, w_sec_digit_10;  // 초의 10의 자리와 1의 자리
    wire [3:0] w_msec_digit_1, w_msec_digit_10;  // 밀리초의 10의 자리와 1의 자리
    wire [1:0] w_seg_sel;  // 세그먼트 선택
    wire w_clk_100hz;

    // BCD 값을 초와 밀리초로 분리
    wire [7:0] sec = bcd[5:0];
    //bcd[13:6];  // bcd의 상위 8비트 (초 값)
    wire [7:0] msec = bcd[13:6];
    //bcd[5:0];  // bcd의 하위 6비트 (밀리초 값)


    clk_divider U_Clk_Divider (
        .clk(clk),
        .reset(reset),
        .o_clk(w_clk_100hz)
    );
    counter_4 U_Counter_4 (
        .clk  (w_clk_100hz),
        .reset(reset),
        .o_sel(w_seg_sel)
    );


    decoder_2x4 U_decoder_2x4 (
        .seg_sel (w_seg_sel),
        .seg_comm(seg_comm)
    );
/*
    digit_splitter U_Digit_Splitter (
        .bcd(bcd),
        .digit_1(w_digit_1),
        .digit_10(w_digit_10),
        .digit_100(w_digit_100),
        .digit_1000(w_digit_1000)
    );*/

     // 초를 10의 자리와 1의 자리로 분리하는 digit_splitter 인스턴스화
    digit_sec_splitter U_digit_sec_splitter (
        .bcd(sec),     // 초 입력
        .sec_digit_1(w_sec_digit_1), // 1의 자리
        .sec_digit_10(w_sec_digit_10)  // 10의 자리
    );

    // 밀리초를 10의 자리와 1의 자리로 분리하는 digit_splitter 인스턴스화
    digit_msec_splitter U_digit_msec_splitter (
        .bcd(msec),    // 밀리초 입력
        .msec_digit_1(w_msec_digit_1),// 1의 자리
        .msec_digit_10(w_msec_digit_10) // 10의 자리
    );


     // 4-to-1 MUX (디스플레이에 맞는 값을 선택)
    mux_4x1 U_Mux_4x1 (
        .sel(w_seg_sel),
        .digit_1(w_sec_digit_1),
        .digit_10(w_sec_digit_10),
        .digit_100(w_msec_digit_1),
        .digit_1000(w_msec_digit_10),
        .bcd(w_bcd)
    );



    bcdtoseg U_bcdtoseg (
        .bcd(w_bcd),  // [3:0] sum 값 
        .seg(seg)
    );

endmodule

module clk_divider (
    input  clk,
    input  reset,
    output o_clk
);
    parameter FCOUNT = 500_000 ;// 이름을 상수화하여 사용.
    // $clog2 : 수를 나타내는데 필요한 비트수 계산
    reg [$clog2(FCOUNT)-1:0] r_counter;
    reg r_clk;
    assign o_clk = r_clk;

    always @(posedge clk, posedge reset) begin
        if (reset) begin  // 
            r_counter <= 0;  // 리셋상태
            r_clk <= 1'b0;
        end else begin
            // clock divide 계산, 100Mhz -> 200hz
            if (r_counter == FCOUNT - 1) begin
                r_counter <= 0;
                r_clk <= 1'b1;  // r_clk : 0->1
            end else begin
                r_counter <= r_counter + 1;
                r_clk <= 1'b0;  // r_clk : 0으로 유지.;
            end
        end
    end

endmodule

module counter_4 (
    input        clk,
    input        reset,
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

module decoder_2x4 (
    input [1:0] seg_sel,
    output reg [3:0] seg_comm
);

    // 2x4 decoder
    always @(seg_sel) begin
        case (seg_sel)
            2'b00:   seg_comm = 4'b1110;
            2'b01:   seg_comm = 4'b1101;
            2'b10:   seg_comm = 4'b1011;
            2'b11:   seg_comm = 4'b0111;
            default: seg_comm = 4'b1110;
        endcase
    end

endmodule
/*
module digit_splitter (
    input  [13:0] bcd,
    output [3:0] digit_1,
    output [3:0] digit_10,
    output [3:0] digit_100,
    output [3:0] digit_1000
);
    assign digit_1 = bcd % 10;  // 10의 1의 자리
    assign digit_10 = bcd / 10 % 10;  // 10의 10의 자리
    assign digit_100 = bcd / 100 % 10;  // 10의 100의 자리
    assign digit_1000 = bcd / 1000 % 10;  // 10의 1000의 자리

endmodule*/

module digit_sec_splitter (
    input  [13:0] bcd,
    output [3:0] sec_digit_1,
    output [3:0] sec_digit_10
);
    assign sec_digit_1 = bcd % 10;  // 10의 1의 자리
    assign sec_digit_10 = bcd / 10 % 10;  // 10의 10의 자리
endmodule

module digit_msec_splitter (
    input  [13:0] bcd,
    output [3:0] msec_digit_1,
    output [3:0] msec_digit_10
);
    assign msec_digit_1 = bcd % 10;  // 10의 1의 자리
    assign msec_digit_10 = bcd / 10 % 10;  // 10의 10의 자리
endmodule

module mux_4x1 (
    input  [1:0] sel,
    input  [3:0] digit_1,
    input  [3:0] digit_10,
    input  [3:0] digit_100,
    input  [3:0] digit_1000,
    output [3:0] bcd
);
    reg [3:0] r_bcd;
    assign bcd = r_bcd;
    // * : input 모두 감시, 아니면 개별 입력 선택 할 수 있다.
    // alwasys : 항상 감시한다 @이벤트 이하를 ()의 변화가 있으면, begin - end를 수행해라.
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
    output reg [7:0] seg
);
    // always 구문 출력으로 reg type을 가져야 한다.
    always @(bcd) begin

        case (bcd)
            4'h0: seg = 8'hc0;
            4'h1: seg = 8'hF9;
            4'h2: seg = 8'hA4;
            4'h3: seg = 8'hB0;
            4'h4: seg = 8'h99;
            4'h5: seg = 8'h92;
            4'h6: seg = 8'h82;
            4'h7: seg = 8'hf8;
            4'h8: seg = 8'h80;
            4'h9: seg = 8'h90;
            4'hA: seg = 8'h88;
            4'hB: seg = 8'h83;
            4'hC: seg = 8'hc6;
            4'hD: seg = 8'ha1;
            4'hE: seg = 8'h86;
            4'hF: seg = 8'h8E;
            default: seg = 8'hff;
        endcase
    end
endmodule

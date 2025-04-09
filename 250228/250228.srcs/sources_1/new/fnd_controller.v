`timescale 1ns / 1ps

module fnd_controller (
    input  [3:0] bcd,
    input  [1:0] seg_sel,
    output [7:0] seg,
    output [3:0] seg_comm
);

    decorder_2x4 U_decorder_2x4 (
        .seg_sel (seg_sel),
        .seg_comm(seg_comm)
    );
    //assign seg_comm = 4'b1110;  // segment 0의 자리 on, seg가 anode type.
    bcdtoseg U_bcdtoseg (
        .bcd(bcd),
        .seg(seg)
    );  // 인스턴스 끝

endmodule

module decorder_2x4 (
    input [1:0] seg_sel,
    output reg [3:0] seg_comm
);
    // 2x4 decorder
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

module bcdtoseg (
    input [3:0] bcd,  // [3:0] sum 값
    output reg [7:0] seg  // reg -> 저장하다, 유지하다
);
    // always 구문 출력으로 reg type을 가져야 한다.
    // 항상 대상 이벤트 감시
    always @(bcd) begin

        case (bcd)
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
            default: seg = 8'hff;  // OFF 상태
        endcase
    end
endmodule

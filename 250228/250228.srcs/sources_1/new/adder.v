`timescale 1ns / 1ps

module calculator (
    input [7:0] a, // 수정
    input [7:0] b, // 수정
    input [1:0] btn,
    output [7:0] seg,
    output [3:0] seg_comm,
    output c_led
);
    wire [7:0] w_sum; // 수정
    fnd_controller U_fnd_controller (
        .bcd(w_sum),
        .seg_sel(btn),
        .seg(seg),
        .seg_comm(seg_comm)
    );
    //assign seg_comm = 4'b1110;  // segment 0의 자리 on, seg가 anode type.
    fa_8 U_fa_8 ( // 수정
        .a(a),
        .b(b),
        .sum(w_sum),
        .c(c_led)
    );
    


endmodule

// 모듈 이름에 숫자가 첫 글자이면 안됨 -> module 4bit_fa -> XXXXX
// [?:?] -> 벡터형 -> 배열형 아님
module fa_8 (
    input [7:0] a,  // 수정
    input [7:0] b, // 수정
    //input cin,
    output [7:0] sum, // 수정
    output c
);
    wire [7:0] w_c; // 수정
    full_adder U_fa0(
        .a(a[0]),
        .b(b[0]),
        .cin(1'b0), // 1bit 바이너리 // 첫 번째 자리의 캐리 입력을 0으로 설정
        .sum(sum[0]),
        .c(w_c[0])
    );

    full_adder U_fa1(
        .a(a[1]),
        .b(b[1]),
        .cin(w_c[0]), // 1bit 바이너리 // 첫 번째 자리의 캐리 입력을 0으로 설정
        .sum(sum[1]),
        .c(w_c[1])
    );

    full_adder U_fa2(
        .a(a[2]),
        .b(b[2]),
        .cin(w_c[1]), // 1bit 바이너리 // 첫 번째 자리의 캐리 입력을 0으로 설정
        .sum(sum[2]),
        .c(w_c[2])
    );

    full_adder U_fa3(
        .a(a[3]),
        .b(b[3]),
        .cin(w_c[2]), // 1bit 바이너리 // 첫 번째 자리의 캐리 입력을 0으로 설정
        .sum(sum[3]),
        .c(w_c[3])
    );

    full_adder U_fa4(
        .a(a[4]),
        .b(b[4]),
        .cin(w_c[3]), // 1bit 바이너리 // 첫 번째 자리의 캐리 입력을 0으로 설정
        .sum(sum[4]),
        .c(w_c[4])
    );

    full_adder U_fa5(
        .a(a[5]),
        .b(b[5]),
        .cin(w_c[4]), // 1bit 바이너리 // 첫 번째 자리의 캐리 입력을 0으로 설정
        .sum(sum[5]),
        .c(w_c[5])
    );

    full_adder U_fa6(
        .a(a[6]),
        .b(b[6]),
        .cin(w_c[5]), // 1bit 바이너리 // 첫 번째 자리의 캐리 입력을 0으로 설정
        .sum(sum[6]),
        .c(w_c[6])
    );

    full_adder U_fa7(
        .a(a[7]),
        .b(b[7]),
        .cin(w_c[6]), // 1bit 바이너리 // 첫 번째 자리의 캐리 입력을 0으로 설정
        .sum(sum[7]),
        .c(c)
    );
endmodule

// ========================== Full Adder 모듈 ==========================
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output c
);

    wire w_s, w_c1, w_c2;

    assign c = w_c1 | w_c2;

    half_adder U_ha1(
        .a(a),
        .b(b),
        .sum(w_s),
        .c(w_c1)
    );
    half_adder U_ha2(
        .a(w_s),
        .b(cin),
        .sum(sum),
        .c(w_c2)
    );
endmodule


// ========================== Half Adder 모듈 ==========================
module half_adder (
    input  a,    // 1bit wire
    input  b,
    output sum,
    output c
);

    // assign sum = a ^ b;
    // assign c = a & b;

    // 게이트 프리미티브
    xor (sum, a, b);  // (출력, 입력0, 입력1, .....)
    and (c, a, b);
    


endmodule

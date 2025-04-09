`timescale 1ns / 1ps

// 1bit FA
module full_adder_4bit(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] s,
    output c
);
    //wire w_s;   // wiring U_HA1 out s to U_HA2 in a
    //wire w_c1, w_c2;
    wire w_c1, w_c2, w_c3;
    
    //assign c = w_c1 | w_c2;
    
    full_adder U_FA1(
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .s(s[0]),
        .c(w_c1)
    );

    full_adder U_FA2(
        .a(a[1]),
        .b(b[1]),
        .cin(cin),
        .s(s[1]),
        .c(w_c2)
    );

    full_adder U_FA3(
        .a(a[2]),
        .b(b[2]),
        .cin(cin),
        .s(s[2]),
        .c(w_c3)
    );
    
    full_adder U_FA4(
        .a(a[3]),
        .b(b[3]),
        .cin(cin),
        .s(s[3]),
        .c(c)
    
    );

endmodule

/*module full_adder(
    input [3:0] a,
    input [3:0] b,
    output [3:0] s,
    output c
);
    
    // full adder 4bit
    //assign s = a ^ b;
    //assign c = a & b;   
    
endmodule
*/
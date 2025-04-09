`timescale 1ns / 1ps

module tb_adder_4bit();

    reg [3:0] a, b;
    reg cin;
    wire [3:0] s;
    wire c;
    
    full_adder_4bit u_full_adder_4bit( // module 인스턴스화
        .a(a),
        .b(b),
        .cin(cin),    // input carry
        .s(s),
        .c(c)
    );    

    initial
    begin
         #10; a = 4'b0000; b = 4'b0000; cin = 0;
         #10; a = 4'b0001; b = 4'b0010; cin = 0;
         #10; a = 4'b0110; b = 4'b0101; cin = 0;
         #10; a = 4'b1111; b = 4'b0001; cin = 0;
         #10; a = 4'b1010; b = 4'b0101; cin = 1;
         #10; a = 4'b1111; b = 4'b1111; cin = 1;
        $stop;
    end

endmodule


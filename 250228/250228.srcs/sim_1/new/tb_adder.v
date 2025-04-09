`timescale 1ns / 1ps
// 수정
module tb_adder();

    reg [7:0] a, b;
    wire [7:0] sum;
    wire c;

    fa_8 dut (
        .a(a),  // 8bit vertor형
        .b(b),
        .sum(sum),
        .c(c)
    );

    integer i;

    initial begin
        a = 8'h00;
        b = 8'h00;
        #10;
        for (i=0; i<256; i=i+1) begin
            a = i;
            #10;
        end
        #10;
        $stop;
    end

endmodule
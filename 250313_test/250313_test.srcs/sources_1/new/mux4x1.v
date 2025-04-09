`timescale 1ns / 1ps

module mux4x1 (
    input  [3:0] a,
    b,
    c,
    d,
    input  [1:0] sel,
    output reg [3:0] mux_out
);
    // case문문
    /*
    always @(*) begin
        case (sel)
            2'b00: mux_out = a; 
            2'b01: mux_out = b; 
            2'b10: mux_out = c; 
            2'b11: mux_out = d; 
            default: mux_out = 4'bx;
        endcase
    end*/

    //3항 연산자
    /*
    assign mux_out = (sel == 0) ? a:
                     (sel == 1 ) ? b:
                     (sel == 2) ? c:
                     (sel == 3) ? d : 4'bx;*/

    // else if
    /*
    always @(*) begin
        if (sel == 2'b00) mux_out = a;
        else if (sel == 2'b01) mux_out = b;
        else if (sel == 2'b10) mux_out = c;
        else if (sel == 2'b11) mux_out = d;
        else mux_out = 4'bx;
    end
*/

endmodule

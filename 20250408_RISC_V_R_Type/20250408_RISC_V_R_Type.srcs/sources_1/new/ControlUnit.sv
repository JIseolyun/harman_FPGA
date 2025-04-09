`timescale 1ns / 1ps
// ControlUnit.sv
module ControlUnit (
    input  logic [31:0] instrCode,
    output logic        regFileWe,
    output logic [ 1:0] aluControl
);
    wire [6:0] opcode = instrCode[6:0];
    wire [3:0] operator = {
        instrCode[30], instrCode[14:12]
    };  // {funct7[5], funct3}


    always_comb begin
        regFileWe = 1'b0;
        case (opcode)
            7'b0110011: regFileWe = 1'b1;  // R-Type
        endcase
    end

    always_comb begin
        aluControl = 2'bx;
        case (opcode)
            7'b0110011: begin  // R-Type
                aluControl = 2'bx;
                case (operator)
                    4'b0000: aluControl = 2'b00;  // add
                    4'b1000: aluControl = 2'b01;  // sub
                    4'b0110: aluControl = 2'b10;  // or
                    4'b0111: aluControl = 2'b11;  // and 
                endcase

            end
        endcase
    end
endmodule

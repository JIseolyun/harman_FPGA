`timescale 1ns / 1ps
// ControlUnit.sv

`include "defines.sv"
module ControlUnit (
    input  logic [31:0] instrCode,
    output logic        regFileWe,
    output logic [ 3:0] aluControl
);
    wire [6:0] opcode = instrCode[6:0];
    wire [3:0] operators = {
        instrCode[30], instrCode[14:12]
    };  // {funct7[5], funct3}


    always_comb begin
        regFileWe = 1'b0;
        case (opcode)
            `OP_TYPE_R: regFileWe = 1'b1;  // R-Type
        endcase
    end

    always_comb begin
        aluControl = 2'bx;
        case (opcode)
            `OP_TYPE_R: aluControl = operators;  // {funct7[5], funct3}
        endcase
    end
endmodule

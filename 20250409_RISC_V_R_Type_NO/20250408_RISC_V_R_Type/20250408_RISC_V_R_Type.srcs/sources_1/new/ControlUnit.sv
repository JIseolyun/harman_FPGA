`timescale 1ns / 1ps
// ControlUnit.sv
module ControlUnit (
    input logic [31:0] instrCode,
    output logic regFileWe,
    output logic [3:0] aluControl
);
    wire [6:0] opcode = instrCode[6:0];
    wire [3:0] operator = {instrCode[30], instrCode[14:12]};  // {funct7[5], funct3}


    always_comb begin
        regFileWe = 1'b0;
        case (opcode)
            7'b0110011: regFileWe = 1'b1; // R-Type
        endcase
    end

    always_comb begin
        aluControl = 4'bxxxx;
        case (opcode)
            7'b0110011: begin // R-Type
                aluControl = 4'bxxxx;
                case (operator)
                    4'b0000: aluControl = 4'b0000; // ADD
                    4'b1000: aluControl = 4'b1000; // SUB
                    4'b0001: aluControl = 4'b0001; // SLL
                    4'b0101: aluControl = 4'b0101; // SRL
                    4'b1101: aluControl = 4'b1101; // SRA
                    4'b0010: aluControl = 4'b0010; // SLT
                    4'b0011: aluControl = 4'b0011; // SLTU
                    4'b0100: aluControl = 4'b0100; // XOR
                    4'b0110: aluControl = 4'b0110; // OR
                    4'b0111: aluControl = 4'b0111; // AND
                    default: aluControl = 4'bxxxx;
                endcase
            
            end
        endcase
    end
endmodule

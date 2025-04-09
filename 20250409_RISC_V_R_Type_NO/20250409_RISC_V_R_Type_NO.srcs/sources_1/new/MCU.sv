`timescale 1ns / 1ps
// MCU.sv
module MCU(
    input logic clk,
    input logic reset
    );

    logic [31:0] instrCode;
    logic [31:0] instrMemAdder;

    RV32I_Core U_Core (.*);

    rom U_ROM (
        .addr(instrMemAdder),
        .data(instrCode)
    );
endmodule

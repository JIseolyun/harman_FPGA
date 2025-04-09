`timescale 1ns / 1ps
// RV32I_Core.sv
module RV32I_Core (
    input  logic        clk,
    input  logic        reset,
    input  logic [31:0] instrCode,      //data
    output logic [31:0] instrMemAdder,
    output logic        dataWe,
    output logic [31:0] dataAddr,
    output logic [31:0] dataWData
);

    logic       regFileWe;
    logic [3:0] aluControl;
    logic       aluSrcMuxSel;

    ControlUnit U_ControlUnit (.*);
    DataPath U_DataPath (.*);

endmodule


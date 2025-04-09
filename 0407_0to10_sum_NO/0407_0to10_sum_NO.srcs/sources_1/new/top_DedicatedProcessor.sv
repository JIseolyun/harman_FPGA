`timescale 1ns / 1ps
// top_DedicatedProcessor.sv //0to10_sum_교수님
module top_DedicatedProcessor(
    input logic clk,
    input logic reset,
    output logic [7:0] outPort
);
    // 내부 신호 선언
    logic sumSrcMuxSel;
    logic iSrcMuxSel;
    logic sumEn;
    logic iEn;
    logic adderSrcMuxSel;
    logic outBuf;
    logic iLe10;
    
    // 모듈 인스턴스화
    DataPath U_Datapath(.*);
    ControlUnit U_ControlUnit(.*);
endmodule


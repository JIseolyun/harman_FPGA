`timescale 1ns / 1ps
// DataPath.sv
module DataPath (
    input logic clk,
    input logic reset,
    input logic [31:0] instrCode,   //data
    output logic [31:0] instrMemAdder,
    input logic regFileWe,
    input logic [3:0] aluControl
);
    logic [31:0] aluResult, RFData1, RFData2;
    logic [31:0] PCSrcData, PCOutData;

    assign instrMemAdder = PCOutData;

    RegisterFile U_RegFile (
        .clk(clk),
        .we(regFileWe),
        .RAddr1(instrCode[19:15]),
        .RAddr2(instrCode[24:20]),
        .WAddr(instrCode[11:7]),
        .WData(aluResult),
        .RData1(RFData1),
        .RData2(RFData2)
    );

    alu U_ALU (
        .aluControl(aluControl),
        .a(RFData1),
        .b(RFData2),
        .result(aluResult)
    );

    register U_PC (
        .clk(clk),
        .reset(reset),
        .d(PCSrcData),
        .q(PCOutData)
    );

    adder U_PC_Adder (
        .a(32'd4),
        .b(PCOutData),
        .y(PCSrcData)
    );

endmodule

module alu (
    input  logic [ 3:0] aluControl,
    input  logic [31:0] a,
    input  logic [31:0] b,
    output logic [31:0] result
);

    always_comb begin
        case (aluControl)
            4'b0000:   result = a + b; // ADD
            4'b1000:   result = a - b; // SUB
            4'b0001: result = a << b[4:0]; // SLL
            4'b0101: result = a >> b[4:0]; // SRL
            4'b1101: result = $signed(a) >>> b[4:0]; // SRA
            4'b0010: result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0; // SLT (signed)
            4'b0011: result = (a < b) ? 32'd1 : 32'd0; // SLTU (unsigned)
            4'b0100: result = a ^ b; // XOR
            4'b0110:   result = a | b; // OR
            4'b0111:   result = a & b; // AND
            default: result = 32'bx;
        endcase
    end
endmodule

module register (
    input logic clk,
    input logic reset,
    input logic [31:0] d,
    output logic [31:0] q
);
    always_ff @(posedge clk, posedge reset) begin
        if (reset) q <= 0;
        else q <= d;
    end
endmodule

module adder (
    input  logic [31:0] a,
    input  logic [31:0] b,
    output logic [31:0] y
);
    assign y = a + b;
endmodule

module RegisterFile (
    input logic clk,
    input logic we,
    input logic [4:0] RAddr1,
    input logic [4:0] RAddr2,
    input logic [4:0] WAddr,
    input logic [31:0] WData,
    output logic [31:0] RData1,
    output logic [31:0] RData2
);
    logic [31:0] RegFile[0:2**5-1];
    //test를 위해 임의로 넣음 11+12=23
    initial begin
        for (int i=0; i<32; i++) begin
            RegFile[i] = 10 + i;
        end
    end

    always_ff @(posedge clk) begin
        if (we) RegFile[WAddr] <= WData;
    end

    assign RData1 = (RAddr1 != 0) ? RegFile[RAddr1] : 32'b0;
    assign RData2 = (RAddr2 != 0) ? RegFile[RAddr2] : 32'b0;
endmodule


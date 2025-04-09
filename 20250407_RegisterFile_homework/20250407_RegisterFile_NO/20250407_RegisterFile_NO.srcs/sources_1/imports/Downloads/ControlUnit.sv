`timescale 1ns / 1ps
// ControlUnit.sv
module ControlUnit (
    input  logic       clk,
    input  logic       reset,
    output logic       RFSrcMuxSel,
    output logic [2:0] readAddr1,
    output logic [2:0] readAddr2,
    output logic [2:0] writeAddr,
    output logic       writeEn,
    output logic       outBuf,
    output logic [2:0] ALUop,
    input  logic       lt
);
    typedef enum { S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18 } state_e;
    
    state_e state, state_next;
    // 1 + 3 + 3 + 3 + 1 + 1 + 3 = 15비트
    logic [14:0] out_signals;

    assign {RFSrcMuxSel, readAddr1, readAddr2, writeAddr, writeEn, outBuf, ALUop} = out_signals;

    always_ff @(posedge clk, posedge reset) begin : state_reg
        if (reset) state <= S0;
        else state <= state_next;
    end

    always_comb begin : state_next_machine
        state_next     = state;
        out_signals = 0;
        case (state)
            //{RFSrcMuxSel, readAddr1, readAddr2, writeAddr, writeEn, outBuf, ALUop} = out_signals;
            S0: begin // R1 = 1
                out_signals = 15'b1_000_000_001_1_0_000;
                state_next     = S1;
            end
            S1: begin // R2 = 0
                out_signals = 15'b0_000_000_010_1_0_000;
                state_next     = S2;
            end
            S2: begin // R3 = 0;
                out_signals = 15'b0_000_000_011_1_0_000;
                state_next     = S3;
            end
            S3: begin // R4 = R1 + R1
                out_signals = 15'b0_001_001_100_1_0_000;
                state_next = S4;
            end
            S4: begin // outport = R4
                out_signals = 15'b0_100_000_000_0_1_000;
                state_next     = S5;
            end
            S5: begin // R5 = R4 + R4
                out_signals = 15'b0_100_100_101_1_0_000;
                state_next     = S6;
            end
            S6: begin // outport = R5
                out_signals = 15'b0_101_000_000_0_1_000;
                state_next     = S7;
            end
            S7: begin // R6 = R5 - R1
                out_signals = 15'b0_101_001_110_1_0_001;
                state_next  = S8;
            end
            S8: begin // outport = R6
                out_signals = 15'b0_110_000_000_0_1_000;
                state_next  = S9;
            end
            S9: begin // R2 = R6 and R4
                out_signals = 15'b0_110_100_010_1_0_010;
                state_next  = S10;
            end
            S10: begin // outport = R2
                out_signals = 15'b0_010_000_000_0_1_000;
                state_next  = S11;
            end
            S11: begin // R3 = R2 or R5
                out_signals = 15'b0_010_101_011_1_0_011;
                state_next  = S12;
            end
            S12: begin // outport = R3
                out_signals = 15'b0_011_000_000_0_1_000;
                state_next  = S13;
            end
            S13: begin // R7 = R3 exor R2
                out_signals = 15'b0_011_010_111_1_0_100;
                state_next  = S14;
            end
            S14: begin // outport = R7
                out_signals = 15'b0_111_000_000_0_1_000;
                state_next  = S15;
            end
            S15: begin // R4 = not R7
                out_signals = 15'b0_111_000_100_1_0_101;
                state_next = S16;
            end
            S16: begin // outport = R4
                out_signals = 15'b0_100_000_000_0_1_000;
                state_next = S17;
            end
            S17: begin // if(R7 > R4) -> S5
                out_signals = 15'b0_100_111_000_0_0_000;
                if (lt)
                    state_next = S5; // R5맞나?..
                else
                    state_next = S18;
            end
            S18: begin // halt
                out_signals = 15'b0_000_000_000_0_0_000;
                state_next  = S18;
            end
        endcase
    end
endmodule

`timescale 1ns / 1ps
// DataPath.sv //0to10sum
module DataPath(
    input logic clk,
    input logic reset,
    input logic ASrcMuxSel,
    input logic AEn,
    input logic SUMEn,
    output logic ALt11,
    input logic OutBuf,
    output logic [7:0] outPort,
    output logic [7:0] A_out
    );

    // wire
    wire [7:0] A;
    wire [7:0] A_adder_out;
    wire [7:0] mux_out;

    wire [7:0] SUM;
    wire [7:0] SUM_adder_out;

    assign outPort = (OutBuf) ? SUM : 8'd0;
    assign A_out = A;
    
    // 인스턴스화
    mux_8bit U_mux_8bit (
        .sel(ASrcMuxSel),
        .in0(A),
        .in1(A_adder_out),
        .out(mux_out)
    );

    A_register U_A_register (
        .clk(clk),
        .reset(reset),
        .en(AEn),
        .d(mux_out),
        .q(A)
    );

    A_adder U_A_adder (
        .a(A),
        .b(8'd1),
        .sum(A_adder_out)
    );

    comparator U_comparator (
        .a(A),
        .b(8'd11),
        .lt(ALt11)
    );

    SUM_register U_SUM_register (
        .clk(clk),
        .reset(reset),
        .en(SUMEn),
        .d(SUM_adder_out),
        .q(SUM)
    );

    SUM_adder U_SUM_adder (
        .a(SUM),
        .b(A),
        .sum(SUM_adder_out)
    );


endmodule

// mux_8bit : 8비트 2:1 멀티플렉서 모듈
module mux_8bit (
    input logic sel,    // 선택 신호: 1이면 in1, 0이면 in0 선택
    input logic [7:0] in0,  // 선택되지 않을 경우 선택되는 입력 (A)
    input logic [7:0] in1,  // 선택 신호가 1일 때 선택되는 입력 (adder_out)
    output logic [7:0] out  // 출력 신호
);
    always_comb begin
        if (sel) begin
            out = in1;
        end else begin
            out = in0;
        end
    end
endmodule

// 레지스터 모듈: 동기식 reset, enable 적용
module A_register (
    input logic clk,
    input logic reset,
    input logic en,
    input logic [7:0] d,
    output logic [7:0] q
);
    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            q <= 0;
        end else begin
            if (en) begin
                q <= d;
            end
        end
    end
endmodule

// 레지스터 모듈: 동기식 reset, enable 적용
module SUM_register (
    input logic clk,
    input logic reset,
    input logic en,
    input logic [7:0] d,
    output logic [7:0] q
);
    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            q <= 0;
        end else begin
            if (en) begin
                q <= d;
            end
        end
    end
endmodule

// adder 모듈: 두 8비트 입력을 더함
module A_adder (
    input  logic [7:0] a,
    input  logic [7:0] b,   // 1
    output logic [7:0] sum
);
    assign sum = a + b;
endmodule

// adder 모듈: 두 8비트 입력을 더함
module SUM_adder (
    input  logic [7:0] a,
    input  logic [7:0] b, 
    output logic [7:0] sum
);
    assign sum = a + b;
endmodule

// comparator 모듈: a와 b를 비교하여, a가 작으면 lt = 1
module comparator (
    input logic [7:0] a,
    input logic [7:0] b,    // 11
    output logic lt
);
    assign lt = a < b;

endmodule
`timescale 1ns / 1ps
//DataPath.sv
module DataPath (
    input logic clk,
    input logic reset,
    input logic ASrcMuxSel, // MUX 선택: 0 -> 현재값, 1 -> A+1
    input logic AEn,    // A Reg 업데이트 enable
    output logic ALt10, // A<10 비교 결과: 1 -> 작음
    input logic OutBuf, // 출력 버퍼 제어 신호: 1 -> A값을 outPort로 출력
    output logic [7:0] outPort
);
    // wire
    wire [7:0] A;
    wire [7:0] adder_out;
    wire [7:0] mux_out;

    // 출력 버퍼: OutBuf가 1 -> A 값을 outPort에 출력 // 아니면 0 출력
    assign outPort = (OutBuf) ? A : 8'd0;

    // 인스턴스화
    mux_8bit U_mux_8bit (
        .sel(ASrcMuxSel),
        .in0(A),
        .in1(adder_out),
        .out(mux_out)
    );

    register U_register (
        .clk(clk),
        .reset(reset),
        .en(AEn),
        .d(mux_out),
        .q(A)
    );

    adder U_adder (
        .a(A),
        .b(8'd1),
        .sum(adder_out)
    );

    comparator U_comparator (
        .a(A),
        .b(8'd10),
        .lt(ALt10)
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
module register (
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
module adder (
    input  logic [7:0] a,
    input  logic [7:0] b,   // 1
    output logic [7:0] sum
);
    assign sum = a + b;
endmodule

// comparator 모듈: a와 b를 비교하여, a가 작으면 lt = 1
module comparator (
    input logic [7:0] a,
    input logic [7:0] b,    // 10
    output logic lt
);
    assign lt = a < b;

endmodule

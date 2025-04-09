`timescale 1ns / 1ps
// uart_cu.v
// PC에서 커맨드 입력을 받아서 stopwatch & watch 시스템이 동작하도록 제어하는 모듈

module uart_cu(
    input clk,
    input rst,
    input data, // 데이터 수신 신호 (유효 데이터가 들어왔는지 확인)
    input [7:0] data_in,    // UART로부터 수신한 8비트 데이터      
    output reg pc_run,  // 스톱워치 시작 제어 신호
    output reg pc_clear,  // 스톱워치 초기화 제어 신호
    output reg pc_sec_inc,    // 시계 초 증가 제어 신호
    output reg pc_min_inc  // 시계 분 증가 제어 신호
);

    reg [3:0] continue; // 명령 지속 카운터 (신호 유지 시간 제어용)
    //parameter HOLD_CYCLES = 50; // 신호 유지 클럭 수 // 추가

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // 리셋 시 모든 제어 신호 초기화
            pc_run <= 1'b0;
            pc_clear <= 1'b0;
            pc_sec_inc <= 1'b0;
            pc_min_inc <= 1'b0;
            continue <= 1'b0;
        end else begin
            if (data) begin
                // 새로운 명령이 들어오면 해당 명령에 따라 제어 신호 설정
                continue <= 0;

                case (data_in)
                    "r", "R", "h", "H": pc_run <= 1'b1;           // run 명령 (스톱워치 시작)
                    "c", "C": pc_clear <= 1'b1;                   // clear 명령 (스톱워치 초기화)
                    "s", "S": pc_sec_inc <= 1'b1;                 // 초 증가 명령
                    "m", "M": pc_min_inc <= 1'b1;                 // 분 증가 명령
                endcase
            end else if (continue < 15) begin    //수정 8->
                // 명령 입력 후 일정 시간 동안 제어 신호 유지
                continue <= continue + 1;
            end else begin
                    // 제어 신호 해제
                    pc_run <= 0;
                    pc_clear <= 0;
                    pc_sec_inc <= 0;
                    pc_min_inc <= 0;
            end 
        end
    end
endmodule


`timescale 1ns / 1ps
/*
module uart_cu(
    input  clk,
    input  reset,
    input  w_rx_done,       // UART 수신 완료 신호
    input  [7:0] w_o_data,  // UART 수신 데이터
    output reg sensor_trigger // 's' 입력 시 1클럭 동안만 1로 세우는 신호
);

    // 상태 정의
    localparam S_IDLE = 2'd0, S_CHECK = 2'd1, S_TRIGGER = 2'd2;

    reg [1:0] state, next;

    // 상태 레지스터
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
        end else begin
            state <= next;
        end
    end

    // 출력 및 다음 상태 결정
    always @(*) begin
        // 기본값
        sensor_trigger = 1'b0;
        next = state;

        case (state)
            S_IDLE: begin
                // w_rx_done=1이 들어오면, 수신 데이터 확인하러 S_CHECK로 이동
                if (w_rx_done == 1'b1)
                    next = S_CHECK;
            end

            S_CHECK: begin
                // 수신 데이터가 's'(0x73)인지 확인
                if (w_o_data == 8'h73) begin
                    next = S_TRIGGER;
                end else begin
                    // 's'가 아니면 다시 IDLE로
                    next = S_IDLE;
                end
            end

            S_TRIGGER: begin
                // 이 상태에서 sensor_trigger를 1로 세움
                sensor_trigger = 1'b1;
                // 한 클럭 후 IDLE로 복귀
                next = S_IDLE;
            end

            default: begin
                next = S_IDLE;
            end
        endcase
    end
endmodule*/

module uart_cu(
    input  clk,
    input  reset,
    input  w_rx_done,       // UART 수신 완료 신호
    input  [7:0] w_o_data,  // UART 수신 데이터
    output reg sensor_trigger // 's' 입력 시 확장된 펄스 생성 신호
);

    // 상태 정의
    localparam S_IDLE    = 2'd0,
               S_CHECK   = 2'd1,
               S_TRIGGER = 2'd2;
    // 펄스 길이
    localparam EXTENSION_CYCLES = 1000000;

    reg [1:0] state, next;
    reg [3:0] trigger_counter; // S_TRIGGER 상태에서의 클럭 카운터

    // 상태 및 카운터 레지스터
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
            trigger_counter <= 0;
        end else begin
            state <= next;
            if (state == S_TRIGGER)
                trigger_counter <= trigger_counter + 1;
            else
                trigger_counter <= 0;
        end
    end

    // 출력 및 다음 상태 결정
    always @(*) begin
        // 기본 출력은 0, 기본 다음 상태는 현재 상태
        sensor_trigger = 1'b0;
        next = state;
        case (state)
            S_IDLE: begin
                // 새로운 수신 완료 신호가 있으면 S_CHECK로
                if (w_rx_done == 1'b1)
                    next = S_CHECK;
            end

            S_CHECK: begin
                // 수신 데이터가 's'(8'h73)이면 S_TRIGGER로 
                if (w_o_data == 8'h73)
                    next = S_TRIGGER;
                else
                    next = S_IDLE;
            end

            S_TRIGGER: begin
                // 이 상태에서는 sensor_trigger를 High로 유지
                sensor_trigger = 1'b1;
                // 지정한 EXTENSION_CYCLES 클럭 동안 유지한 후 IDLE로
                if (trigger_counter < EXTENSION_CYCLES)
                    next = S_TRIGGER;
                else
                    next = S_IDLE;
            end

            default: begin
                next = S_IDLE;
            end
        endcase
    end
endmodule





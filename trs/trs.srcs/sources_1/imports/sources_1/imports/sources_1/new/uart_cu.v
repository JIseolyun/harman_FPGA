`timescale 1ns / 1ps
// uart_cu.v
// 's' send 갑지를 통해 s_trigger 출력
module uart_cu(
    input  clk,
    input  reset,
    input  w_rx_done,       // UART 수신 완료 신호 (1클럭 High)
    input  [7:0] w_o_data,  // UART 수신 데이터
    output reg s_trigger // 's' 입력 시 생성되는 1클럭짜리 출력
);
    // FSM 정의의
    parameter S_IDLE = 0, S_CHECK = 1, S_TRIGGER = 2;

    reg [1:0] state, next;
    //reg [3:0] trigger_counter; // 현재는 trigger_counter도 사용X (S_TRIGGER에서만 증가)

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            //state <= 0;
            //trigger_counter <= 0;
            state <= 0;
        end else begin
            state <= next;
            /*if (state == S_TRIGGER)
                trigger_counter <= trigger_counter + 1;
            else
                trigger_counter <= 0;*/
        end
    end

    always @(*) begin
        // 기본 출력은 0, 기본 다음 상태는 현재 상태
        s_trigger = 1'b0;
        next = state;

        case (state)
            S_IDLE: begin
                // 새로운 수신 완료 신호가 있으면 -> S_CHECK
                if (w_rx_done == 1'b1)
                    next = S_CHECK;
            end

            S_CHECK: begin
                // 수신 데이터가 's'(8'h73)이면 -> S_TRIGGER
                if (w_o_data == 8'h73)
                    next = S_TRIGGER;
                else
                    next = S_IDLE;
            end

            S_TRIGGER: begin
                // 1클럭 동안만 s_trigger를 High로
                s_trigger = 1'b1;
                next = S_IDLE;
            end

            default: begin
                next = S_IDLE;
            end
        endcase
    end
endmodule
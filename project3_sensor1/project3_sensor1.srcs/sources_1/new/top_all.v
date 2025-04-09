`timescale 1ns / 1ps

module top_all (
    input  clk,
    input  reset,
    // 원래 쓰던 버튼 입력
    input  start_trigger,
    // 초음파 센서 echo
    input  data,
    // UART RX/TX
    input  rx,
    output tx,

    // 초음파 센서에서 나오는 신호들
    output start_tick,
    output [7:0] seg_out,
    output [3:0] seg_comm
);

    // UART FSM 인스턴스 (전체 UART 기능 + s 감지)
    wire w_sensor_trigger_from_uart;
    // 버튼 입력과 UART의 sensor_trigger를 OR 연산하여 센서 트리거 생성
    wire w_start_trigger = start_trigger | w_sensor_trigger_from_uart;

    uart_fsm U_UART (
        .reset(reset),
        .clk(clk),
        .btn_start(1'b0),       // 미사용
        .tx_data_in(8'h00),      // 필요시 수정
        .tx(tx),
        .tx_done(),             // 미사용
        .w_o_data(),           
        .rx(rx),
        .sensor_trigger(w_sensor_trigger_from_uart)
    );
    
    top_sensor U_TOP_SENSOR (
        .clk(clk),
        .reset(reset),
        .start_trigger(w_start_trigger),
        .data(data),
        .start_tick(start_tick),
        .seg_out(seg_out),
        .seg_comm(seg_comm)
    );

endmodule


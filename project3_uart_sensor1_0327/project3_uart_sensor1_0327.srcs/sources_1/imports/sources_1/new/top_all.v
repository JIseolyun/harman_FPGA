`timescale 1ns / 1ps
// top_all.v
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

    // UART FSM (전체 UART 기능 + s 감지)
    top_uart U_TOP_UART (
        .reset(reset),
        .clk(clk),
        .btn_start(1'b0),       // 미사용
        .tx_data_in(8'h00),      // 필요시 수정
        .tx(tx),
        .tx_done(),             // 미사용
        .w_o_data(),           
        .rx(rx),
        .s_trigger(s_trigger)
    );
    
    top_sensor U_TOP_SENSOR (
        .clk(clk),
        .reset(reset),
        .start_trigger(start_trigger),
        .data(data),
        .start_tick(start_tick),
        .s_tick(s_trigger),
        .seg_out(seg_out),
        .seg_comm(seg_comm)
    );

endmodule


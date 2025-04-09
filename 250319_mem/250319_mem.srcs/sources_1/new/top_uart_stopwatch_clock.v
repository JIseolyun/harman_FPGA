`timescale 1ns / 1ps
//버려려
module top_uart_stopwatch_clock(
    input clk,
    input rst,
    input rx,
    output tx,
    output [3:0] fnd_comm,
    output [7:0] fnd_font,
    output [3:0] led
);

   
    uart U_UART (
        .clk(clk),
        .rst(rst),
        .btn_start(~fifo_tx_empty),
        .tx_data_in(w_tx_rx_dataout),
        .tx_done(uart_tx_done),
        .tx(tx),
        .rx(rx),
        .rx_done(uart_rx_done),
        .rx_data(uart_rx_data)
    );

    top_uart_fifo U_UART_FIFO (
        .clk(clk),
        .rst(rst),
        .rx(tx),
        .tx(rx)
    );

    top_watch U_STOPWATCH_WATCH (
        .clk(clk),
        .btnC(),
        .btnL(),
        .btnR(),
        .btnU(),
        .btnD(),
        .sw_clock(),
        .sw_mode(),
        .fnd_comm(),
        .fnd_font(),
        .led()
    );

endmodule

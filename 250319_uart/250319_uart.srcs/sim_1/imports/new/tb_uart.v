`timescale 1ns / 1ps
module tb_uart ();

    reg clk, rst; //btn_start;
    //reg [7:0] data_in;
    reg rx;
    wire w_tick, w_rx_done;
    wire [7:0] rx_data;

    baud_tick_gen U_BAUD_TICK (
        .clk(clk),
        .rst(rst),
        .baud_tick(w_tick)
    );

    uart_rx DUT_rx(
        .clk(clk),
        .rst(rst),
        .tick(w_tick),
        .rx(rx),
        .rx_done(w_rx_done),
        .rx_data(rx_data)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        rx = 1;
        #10;
        rst = 0;
        #100;
        rx = 0; // start
        #10416;    // 9600 bit
         rx = 1; // data 0
        #10416;    // 9600 bit
         rx = 0; // data 1
        #10416;    // 9600 bit
         rx = 0; // data 2
        #10416;    // 9600 bit
         rx = 0; // data 3
        #10416;    // 9600 bit
         rx = 1; // data 4
        #10416;    // 9600 bit
         rx = 1; // data 5
        #10416;    // 9600 bit
         rx = 0; // data 6
        #10416;    // 9600 bit
         rx = 0; // data 7
        #10416;    // 9600 bit
        rx = 1; // stop
        #1000;
        $stop;
    end
endmodule
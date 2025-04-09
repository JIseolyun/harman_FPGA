`timescale 1ns / 1ps

module tb_uart();
     //global
    reg clk;
    reg reset;
    //tx
    reg [7:0] tx_data;
    reg tx_start;
    wire tx_busy;
    wire tx_done;
    wire tx;
    //rx
    //reg rx;
    wire [7:0] rx_data;
    wire rx_done;

    uart dut (
        .clk(clk),
        .reset(reset),
        .tx_data(tx_data),
        .tx_start(tx_start),
        .tx_busy(tx_busy),
        .tx_done(tx_done),
        .tx(tx),
        .rx(tx),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; reset = 1;
        #10 reset = 0;
        @(posedge clk); // 클럭 양의 에지 기다림
        #1 tx_data = 8'b11001010; tx_start = 1;
        @(posedge clk); // 다음 클럭
        #1 tx_start = 0;
        @(posedge tx_done); // 송신 완료될 때까지 기다림
        #20;
        $finish;
    end
endmodule

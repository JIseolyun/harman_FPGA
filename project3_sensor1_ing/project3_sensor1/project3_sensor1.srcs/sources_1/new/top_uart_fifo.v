`timescale 1ns / 1ps

module top_uart_fifo (
    input clk,
    input rst,
    input rx,
    output tx
);

    wire [7:0] fifo_tx_rdata;
    wire fifo_tx_empty;
    wire fifo_tx_full;
    wire [7:0] fifo_rx_rdata;

    wire uart_tx_done, uart_rx_done;
    wire [7:0] uart_rx_data;

    wire [7:0] w_tx_rx_dataout;


    fifo FIFO_TX (
        .clk(clk),
        .reset(rst),
        .wdata(fifo_rx_rdata),
        .wr(~fifo_rx_empty),
        .full(fifo_tx_full),
        .rd(~uart_tx_done&~fifo_tx_empty),
        .rdata(fifo_tx_rdata),
        .empty(fifo_tx_empty)
    );

    fifo FIFO_RX (
        .clk(clk),
        .reset(rst),
        .wdata(uart_rx_data),
        .wr(uart_rx_done),
        .full(),
        .rd(~fifo_tx_full),
        .rdata(fifo_rx_rdata),
        .empty(fifo_rx_empty)
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

    data_save U_Data_Save(
        .clk(clk),
        .reset(rst),
        .rd(~fifo_rx_empty),
        .data_in(fifo_rx_rdata),
        .data_out(w_tx_rx_dataout)
    );


endmodule

module data_save(
    input clk,
    input reset,
    input rd,
    input [7:0] data_in,
    output [7:0] data_out
);
    reg [7:0] data_reg,data_next;
    assign data_out = data_reg;
    always @(posedge clk) begin
        if (reset) begin
            data_reg <=0;
        end
        else begin
            data_reg <= data_next;
        end
    end
    always@(*) begin
        data_next = data_reg;
        if(rd) begin
            data_next = data_in;
        end

    
end
 
endmodule
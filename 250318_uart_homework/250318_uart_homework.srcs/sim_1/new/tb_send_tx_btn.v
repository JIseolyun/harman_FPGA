`timescale 1ns / 1ps

module tb_send_tx_btn();

    reg clk;
    reg rst;
    reg btn_start;
    wire tx;

    send_tx_btn dut(
        .clk(clk),
        .rst(rst),
        .btn_start(btn_start),
        .tx(tx)
    );

    always #0.05 clk = ~clk;

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        btn_start = 1'b0;

        #20 rst = 1'b0;
        #100000;
        #100000 btn_start = 1'b1;
        #100000 btn_start = 1'b0;
        #100000 btn_start = 1'b1;
        #100000 btn_start = 1'b0;
        //#100000 btn_start = 1'b1;
        //#100000 btn_start = 1'b0;

    end

endmodule

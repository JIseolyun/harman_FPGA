`timescale 1ns / 1ps

module tb_tick();

    baud_tick_1usec(
        .clk(clk),
        .rst(rst),
        .tick(tick)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        tick = 
    end

endmodule

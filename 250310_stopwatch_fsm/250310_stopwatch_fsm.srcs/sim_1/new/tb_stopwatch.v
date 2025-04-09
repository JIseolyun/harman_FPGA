`timescale 1ns / 1ps

module tb_stopwatch ();

    reg clk, reset, run, clear;
    wire [6:0] msec, sec, min, hour;

    stopwatch_dp dut (
        .clk  (clk),
        .reset(reset),
        .run  (run),
        .clear(clear),
        .msec (msec),
        .sec  (sec),
        .min  (min),
        .hour (hour)
    );

    always #5 clk = ~clk;  // clk 생성.

    initial begin
        //  초기화
        clk   = 0;
        reset = 1;
        run   = 0;
        clear = 0;

        #10;    //  10나노 run = 1
        reset = 0;
        run   = 1;
        wait (sec == 2);    //  2초 대기기

        #10;
        run = 0;
    end

endmodule

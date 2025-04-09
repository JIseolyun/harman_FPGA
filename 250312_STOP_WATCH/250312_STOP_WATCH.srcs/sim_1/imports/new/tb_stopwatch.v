`timescale 1ns / 1ps

module tb_stopwatch ();

    reg clk, reset, run, clear, sw_mode;
    wire [6:0] msec, sec, min, hour;
    wire [7:0] fnd_font;
    wire [3:0] fnd_comm;

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

    fnd_controller dut1(
        .clk(clk),
        .reset(reset),
        .sw_mode(sw_mode),
        .msec(msec),
        .sec(sec),
        .min(min),
        .hour(hour),
        .fnd_font(fnd_font),
        .fnd_comm(fnd_comm)
    );

    always #5 clk = ~clk;  // clk 생성.

    initial begin
        //  초기화
        clk   = 0;
        reset = 1;
        run   = 0;
        clear = 0;
        sw_mode = 0;

        #10;    //  10나노 run = 1
        reset = 0;
        run   = 1;
        wait (sec == 2);    //  2시간 대기

       // wait (sec == 1);    //  2시간 대기
        #10;
        run = 0;    // stop
        repeat(4) @(posedge clk)    // 4번 반복, clk posedge 이벤트
            clear = 1;
        #100;
        $stop;
    end

endmodule

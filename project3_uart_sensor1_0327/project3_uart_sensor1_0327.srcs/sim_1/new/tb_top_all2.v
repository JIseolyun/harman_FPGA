`timescale 1ns / 1ps
// tb_top_all2.v
// sensor가 정상적으로 구동하는지
// sensor의 스펙에 맞게 설계되었는지 확인
module tb_top_all2();
    reg clk;
    reg reset;
    reg start_trigger;
    reg data;

    wire start_tick;
    wire [7:0] seg_out;
    wire [3:0] seg_comm;

    top_sensor U_top_sensor(
        .clk(clk),
        .reset(reset),
        .start_trigger(start_trigger),
        .data(data),
        .start_tick(start_tick),
        .seg_out(seg_out),
        .seg_comm(seg_comm)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        start_trigger = 0;
        data = 0;

        #50;
        reset = 0;

        // 1클럭 동안 트리거
        #10000;
        start_trigger = 1;
        wait(U_top_sensor.U_btn_db.o_btn == 1);
        start_trigger = 0;

        // Echo high 800us
        #800000; 
        data = 1;
        #800000;
        data = 0;
        #100000;

        $stop;
    end

endmodule

`timescale 1ns / 1ps
// tb_top_all.v
// comportmaster에서 s 입력하면 start_trigger가 발생되는지 확인하는 tb
module tb_top_all();

    // input은 reg
    // output은 wire
    reg clk;
    reg reset;
    reg start_trigger;
    reg data;   //echo
    reg rx;

    wire tx;
    wire start_tick;
    wire [7:0] seg_out;
    wire [3:0] seg_comm;

    top_all U_top_all (
        .clk(clk),
        .reset(reset),
        .start_trigger(start_trigger),
        .data(data),
        .rx(rx),
        .tx(tx),
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
            rx = 1;

            #50;
            reset = 0;
            
            #10000;

            // echo 신호 수동 생성   // echo high 시간 100us -> 거리 = Echo High 시간(us) / 58 -> 
            //100 / 58 = 1.72cm #100000
            // echo 신호 수동 생성
            send_data(8'h73);
            // 800 / 58 = 13.79cm
            #800000;
            data = 1;
            #800000;
            data = 0;
            #100000;
            $stop;  
        end

        // Task: 데이터 송신 시뮬레이션 (TX -> RX LoopBack)
        task send_data(input [7:0] data);
            integer i;
            begin
                $display("Sending data: %h", data);

                // Start bit (Low)
                rx = 0;
                #(10 * 10417);  // Baud Rate에 따른 시간 지연 (9600bps 기준)

                // Data bits (LSB first)
                for (i = 0; i < 8; i = i + 1) begin
                    rx = data[i];
                    #(10 * 10417);  // 각 비트 전송 시간 지연
                end

                // Stop bit (High)
                rx = 1;
                #(10 * 10417);  // 정지 비트 시간 지연

                $display("Data sent: %h", data);
            end
        endtask
endmodule
/*
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
);*/

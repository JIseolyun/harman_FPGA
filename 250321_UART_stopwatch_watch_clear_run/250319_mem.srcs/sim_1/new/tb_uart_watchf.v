`timescale 1ns / 1ps
module tb_uart_watchf;

    //==== 신호 선언 ====
    reg  clk;
    reg  rst;       
    reg  rx;        
    wire tx;        

    //==== DUT 인스턴스 ====
    top_uart_fifo uut (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .tx(tx)
    );

    //==== 클럭 생성 (100MHz 가정) ====
    always #5 clk = ~clk;

    // UART 보오레이트(9600bps) → 비트당 ~104.167us
    parameter BIT_TIME = 104167;

    //==== 초기 동작 ====
    initial begin
        clk = 0;
        rst = 1;   // 설계에 맞춰 active high/low 확인
        rx  = 1;   // Idle

        #50  rst = 0;
        #1000;

        // 1) 'h' 전송 → 시(hour) 증가
        send_data("h");  // 8'h68
        #500000;         // 증가 후 상태 확인

        // 2) 'm' 전송 → 분(min) 증가
        send_data("m");  // 8'h6D
        #500000;

        // 3) 's' 전송 → 초(sec) 증가
        send_data("s");  // 8'h73
        #500000;

        $finish;
    end

    //==== UART 송신 태스크 ====
    task send_data(input [7:0] data);
        integer i;
        begin
            // Start bit
            rx = 0;
            #(BIT_TIME);

            // 8 data bits
            for (i = 0; i < 8; i = i + 1) begin
                rx = data[i];
                #(BIT_TIME);
            end

            // Stop bit
            rx = 1;
            #(BIT_TIME);
        end
    endtask

endmodule

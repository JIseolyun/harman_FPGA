`timescale 1ns / 1ps

module tb_uart_fifo();
    reg clk;
    reg rst;
    reg rx;
    wire tx;
    // 예시로 스톱워치 값을 출력하는 포트가 있다면 주석 해제
    // wire [15:0] stopwatch_value;

    top_uart_fifo U_top_uart_fifo(
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .tx(tx)
        // 만약 스톱워치 값 출력 포트가 있다면 연결: .stopwatch(stopwatch_value)
    );

    // 100MHz 클럭 생성 (10ns 주기)
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;   // 초기 active high reset
        rx = 1;    // UART RX Idle 상태

        #50 rst = 0;   // 50ns 후 리셋 해제
        #10000;        // 시스템 안정화 시간

        // "r"을 전송해서 스톱워치 시작 명령을 내림
        $display("Sending 'r' command to start the stopwatch.");
        send_data(8'h72); // 'r'
        send_data(8'h73);
        send_data(8'h74);
        send_data(8'h75);
        
        // "r" 전송 후, 스톱워치가 시작되어 카운터가 증가하는지 확인하기 위해 충분한 시간 대기
        #100000;  // 1ms 대기 (필요에 따라 시간 조정)

        // 시뮬레이터의 웨이브폼 뷰어에서 스톱워치 관련 신호(예: stopwatch_value)가 변화하는지 확인하세요.
        // $display("Stopwatch value: %h", stopwatch_value);

        // 추가로 다른 명령을 전송할 수도 있음 (예: 스톱, 리셋 등)
        // send_data(8'h63); // 예: 'c' 또는 다른 명령

        #100000; // 최종 대기 후 시뮬레이션 종료
        $finish;
    end

    // UART 전송 태스크: start bit, 8 data bits, stop bit 순으로 rx에 데이터 전송
    task send_data(input [7:0] data);
        integer i;
        begin
            $display("Sending data: %h", data);
            // Start bit (Low)
            rx = 0;
            #(10 * 10417);  // 한 비트 전송 시간 (9600bps 기준, 약 104us)

            // Data bits (LSB first)
            for (i = 0; i < 8; i = i + 1) begin
                rx = data[i];
                #(10 * 10417);
            end

            // Stop bit (High)
            rx = 1;
            #(10 * 10417);
            $display("Data sent: %h", data);
        end
    endtask

endmodule

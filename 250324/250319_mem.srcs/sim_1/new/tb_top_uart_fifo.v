`timescale 1ns / 1ps
//0323

module tb_top_uart_fifo;

  //==== 신호 선언 ====
  reg clk;
  reg rst;     // active low reset
  reg rx;        // UART RX (입력)
  wire tx;       // UART TX (출력)
  
  //==== DUT 인스턴스 ====
  top_uart_fifo uut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .tx(tx)
    // 필요시 다른 포트 연결
  );
  
  //==== 클럭 생성 ====
  // 예: 10ns 주기 -> 100MHz
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  // UART 한 비트당 기간(baud rate)에 맞춰 딜레이를 줄 때 사용
  // 예) 9600 baud면 약 104us/bit (이하 예시는 단축을 위해 10ns 로 가정)
  parameter BAUD_PERIOD = 10;  // 실제 환경에 맞춰 조정 필요

  //==== UART 전송용 태스크 ====
  task uart_send_byte(input [7:0] data);
    integer i;
    begin
      // Start bit (0)
      rx = 0;
      #(BAUD_PERIOD);
      
      // 8 data bits (LSB부터)
      for (i = 0; i < 8; i = i + 1) begin
        rx = data[i];
        #(BAUD_PERIOD);
      end
      
      // Stop bit (1)
      rx = 1;
      #(BAUD_PERIOD);
    end
  endtask

  //==== 초기 동작 ====
  initial begin
    // 초기값 설정
    rx = 1;       // UART RX는 Idle 상태가 1
    rst = 0;    // reset active
    #(50);
    rst = 1;    // reset 해제
    
    // reset 해제 후 잠시 대기 (시스템 안정화)
    #(50);
    
    // r, c, h, m, s 순서로 전송
    // (각 문자의 ASCII 코드를 태스크로 전송)
    uart_send_byte("r");  // 0x72
    #(20);
    uart_send_byte("c");  // 0x63
    #(20);
    uart_send_byte("h");  // 0x68
    #(20);
    uart_send_byte("m");  // 0x6D
    #(20);
    uart_send_byte("s");  // 0x73
    #(20);
    
    // 추가 테스트 시 여러 문자를 더 전송하거나
    // FIFO가 가득 차거나 비어있을 때 동작 등을 테스트해볼 수 있음
    
    // 시뮬레이션 종료 전 충분히 대기
    #(200);
    $finish;
  end

endmodule

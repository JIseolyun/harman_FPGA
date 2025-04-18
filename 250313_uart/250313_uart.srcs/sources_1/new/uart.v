//uart.v
`timescale 1ns / 1ps

// UART 모듈
module uart (
    input clk,        // 시스템 클럭 입력
    input rst,        // 비동기 리셋 신호
    input btn_start,  // 데이터 전송 시작 트리거
    input [7:0] tx_data_in,
    output tx_done,
    output tx         // UART 송신 신호 (시리얼 출력)
);

    wire w_tick; // Baud rate tick 신호

    // UART 송신기 인스턴스화
    uart_tx U_UART_TX(
        .clk(clk),
        .rst(rst),
        .tick(w_tick),
        .start_trigger(btn_start),
        .data_in(tx_data_in), // ASCII 코드 '0' (0x30)을 송신
        .o_tx_done(tx_done),
        .o_tx(tx)
    );

    // Baud Rate 생성기 인스턴스화
    baud_tick_gen U_BAUD_Tick_Gen (
        .clk(clk),
        .rst(rst),     
        .baud_tick(w_tick) // Baud rate tick 신호 생성
    );

endmodule

// UART 송신기 모듈
module uart_tx (
    input clk,          // 시스템 클럭
    input rst,          // 비동기 리셋
    input tick,         // Baud rate tick 신호
    input start_trigger,// 전송 시작 신호
    input [7:0] data_in,// 송신할 8비트 데이터
    output o_tx_done,
    output o_tx         // UART 송신 신호 (1비트, 시리얼 데이터)
);
    // FSM 상태 정의
    /*
    parameter IDLE = 4'h0, START = 4'h1, 
                D0 = 4'h2, D1 = 4'h3, D2 = 4'h4, D3 = 4'h5,
                D4 = 4'h6, D5 = 4'h7, D6 = 4'h8, D7 = 4'h9,
                STOP = 4'ha;*/
    parameter IDLE = 4'h0, START = 4'h1, DATA = 4'h2, STOP = 4'h3;
    
    reg [3:0] state, next; // 현재 상태 및 다음 상태 변수
    reg tx_reg, tx_next;   // 현재 송신 비트 및 다음 송신 비트 저장
    reg tx_done_reg, tx_done_next;
    reg [2:0] i;

    assign o_tx_done = tx_done_reg;
    assign o_tx = tx_reg; // 출력 신호 설정

    // 상태 및 출력 저장 레지스터
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            state  <= 0;
            tx_reg <= 1'b1; // IDLE 상태에서는 TX가 HIGH
            tx_done_reg <= 0;
            i <= 0;
        end else begin
            state  <= next;
            tx_reg <= tx_next;
            tx_done_reg <= tx_done_next;
        end
    end

    // 상태 전이 로직 (FSM)
    always @(*) begin
        next = state;
        tx_next = tx_reg;
        tx_done_next = tx_done_reg;
        case (state)
            IDLE: begin
                //tx_done_next = 1'b1;   //high 1번 자리
                tx_next = 1'b1;
                if (start_trigger) begin
                    // 1번 자리
                    next = START;
                end
            end
            START: begin
                if (tick == 1'b1) begin
                    tx_done_next = 1'b1;   // 2번 자리
                    tx_next = 1'b0; // Start bit 전송 (LOW)
                    next = DATA;
                end
            end
            DATA: begin
                if (tick == 1'b1) begin
                    if (i < 8) begin
                        
                    end
                end else begin
                    next=STOP;
                end
            end
            STOP: begin
                if (tick == 1'b1) begin
                    tx_done_next = 1'b0; //3번 자리
                    tx_next = 1'b1; // Stop bit 전송 (HIGH)
                    next=IDLE;
                end
            end
            /*
            
            D0: begin
                if (tick == 1'b1) begin
                    tx_next = data_in[0]; // 데이터 LSB부터 전송
                    next=D1;
                end
            end
            D1: begin
                if (tick == 1'b1) begin
                    tx_next = data_in[1];
                    next=D2;
                end
            end
            D2: begin
                if (tick == 1'b1) begin
                    tx_next = data_in[2];
                    next=D3;
                end
            end
            D3: begin
                if (tick == 1'b1) begin
                    tx_next = data_in[3];
                    next=D4;
                end
            end
            D4: begin
                if (tick == 1'b1) begin
                    tx_next = data_in[4];
                    next=D5;
                end
            end
            D5: begin
                if (tick == 1'b1) begin
                    tx_next = data_in[5];
                    next=D6;
                end
            end
            D6: begin
                if (tick == 1'b1) begin
                    tx_next = data_in[6];
                    next=D7;
                end
            end
            D7: begin
                if (tick == 1'b1) begin
                    tx_next = data_in[7]; // MSB 전송
                    next=STOP;
                end
            end*/
            /*
            STOP: begin
                if (tick == 1'b1) begin
                    tx_done_next = 1'b0; //3번 자리
                    tx_next = 1'b1; // Stop bit 전송 (HIGH)
                    next=IDLE;
                end
            end*/
        endcase
    end
endmodule

// Baud Rate Tick 생성기 모듈 (DP)
module baud_tick_gen (
    input clk,          // 시스템 클럭
    input rst,          // 비동기 리셋
    output baud_tick    // Baud rate tick 신호 출력
);
    parameter BAUD_RATE = 9600;  // 전송 속도 (9600bps) //BAUD_RATE_19200 = 19200;
    localparam BAUD_COUNT = 100_000_000 / BAUD_RATE; // Baud rate 계산 (100MHz 기준)
    reg [$clog2(BAUD_COUNT)-1:0] count_reg, count_next; // 카운터 레지스터
    reg tick_reg, tick_next; // Tick 신호 레지스터

    assign baud_tick = tick_reg; // Tick 신호 출력

    // 레지스터 업데이트
    always @(posedge clk, posedge rst) begin
        if (rst == 1) begin
            count_reg <= 0;
            tick_reg  <= 0;
        end else begin
            count_reg <= count_next;
            tick_reg  <= tick_next;
        end
    end

    // Baud rate tick 생성 로직
    always @(*) begin
        count_next = count_reg;
        tick_next  = tick_reg;
        if (count_reg == BAUD_COUNT - 1) begin
            count_next = 0;
            tick_next  = 1'b1; // Tick 신호 생성
        end else begin
            count_next = count_reg + 1;
            tick_next  = 1'b0;
        end
    end

endmodule

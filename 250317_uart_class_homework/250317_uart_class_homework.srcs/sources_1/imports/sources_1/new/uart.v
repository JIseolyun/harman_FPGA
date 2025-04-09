//uart.v // 교수님코드
`timescale 1ns / 1ps

// UART 모듈
module uart (
    input        clk,         // 시스템 클럭 입력
    input        rst,         // 비동기 리셋 신호
    input        btn_start,   // 데이터 전송 시작 트리거
    input  [7:0] tx_data_in,
    output       tx_done,
    output       tx           // UART 송신 신호 (시리얼 출력)
);

    wire w_tick;  // Baud rate tick 신호

    // UART 송신기 인스턴스화
    uart_tx U_UART_TX (
        .clk(clk),
        .rst(rst),
        .tick(w_tick),
        .start_trigger(btn_start),
        .data_in(tx_data_in),  // ASCII 코드 '0' (0x30)을 송신
        .o_tx_done(tx_done),
        .o_tx(tx)
    );

    // Baud Rate 생성기 인스턴스화
    baud_tick_gen U_BAUD_Tick_Gen (
        .clk(clk),
        .rst(rst),
        .baud_tick(w_tick)  // Baud rate tick 신호 생성
    );

endmodule

// UART 송신기 모듈
module uart_tx (
    input clk,  // 시스템 클럭
    input rst,  // 비동기 리셋
    input tick,  // Baud rate tick 신호
    input start_trigger,  // 전송 시작 신호
    input [7:0] data_in,  // 송신할 8비트 데이터
    output o_tx_done,
    output o_tx  // UART 송신 신호 (1비트, 시리얼 데이터)
);
    // FSM 상태 정의
    parameter IDLE = 0, SEND = 1, START = 2, DATA = 3, STOP = 4;

    reg [3:0] state, next;
    reg tx_reg, tx_next;
    reg tx_done_reg, tx_done_next;
    reg [2:0] bit_count_reg, bit_count_next;
    reg [3:0] tick_count_reg, tick_count_next;
    assign o_tx_done = tx_done_reg;
    assign o_tx = tx_reg;


    always @(posedge clk, posedge rst) begin
        if (rst) begin
            state <= 0;
            tx_reg <= 1'b1;
            tx_done_reg <= 0;
            bit_count_reg <= 0;
            tick_count_reg <= 0;
        end else begin
            state <= next;
            tx_reg <= tx_next;
            tx_done_reg <= tx_done_next;
            bit_count_reg <= bit_count_next;
            tick_count_reg <= tick_count_next;
        end
    end

    // FSM
    always @(*) begin
        next = state;
        tx_next = tx_reg;
        tx_done_next = tx_done_reg;
        bit_count_next = bit_count_reg;
        tick_count_next = tick_count_reg;
        case (state)
            IDLE: begin
                tx_next = 1'b1;
                tx_done_next = 1'b0;
                tick_count_next = 4'h0;
                if (start_trigger) begin
                    next = SEND;
                end
            end
            SEND: begin
                if (tick == 1'b1) begin
                    next = START;
                end
            end
            START: begin
                tx_done_next = 1'b1;
                tx_next = 1'b0;  // 출력을 0으로 유지.
                if (tick == 1'b1) begin
                    if (tick_count_reg == 15) begin
                        next = DATA;
                        bit_count_next = 1'b0;
                        tick_count_next = 1'b0;
                    end else begin
                        tick_count_next = tick_count_reg + 1;
                    end
                end
            end
            /*
            DATA: begin
                if (tick == 1'b1) begin
                    tx_next = data_in[bit_count_reg];
                    bit_count_next = bit_count_reg + 1;
                    if (bit_count_next == 8) begin
                        next = STOP;
                    end else begin
                        next = DATA;
                    end
                end
            end*/
            DATA: begin
                
                if (tick) begin
                tx_next = data_in[bit_count_reg];
                    if (tick_count_reg == 15) begin
                        tick_count_next =  0;
                        if (bit_count_reg == 7) begin
                            next = STOP;
                        end else begin
                            next = DATA;
                            bit_count_next = bit_count_reg + 1;
                        end
                    end else begin
                        tick_count_next = tick_count_reg + 1;
                    end
                end
            end
            STOP: begin
                tx_next = 1'b1;
                if (tick == 1'b1) begin
                    if (tick_count_reg == 15) begin
                        next = IDLE;
                    end else begin
                        tick_count_next = tick_count_reg + 1;
                    end
                end
            end
        endcase
    end
endmodule

// Baud Rate Tick 생성기 모듈 (DP)
module baud_tick_gen (
    input  clk,       // 시스템 클럭
    input  rst,       // 비동기 리셋
    output baud_tick  // Baud rate tick 신호 출력
);
    parameter BAUD_RATE = 9600;  // 전송 속도 (9600bps) //BAUD_RATE_19200 = 19200;
    localparam BAUD_COUNT = (100_000_000 / BAUD_RATE)/16; // Baud rate 계산 (100MHz 기준)
    reg [$clog2(BAUD_COUNT)-1:0]
        count_reg, count_next;  // 카운터 레지스터
    reg tick_reg, tick_next;  // Tick 신호 레지스터

    assign baud_tick = tick_reg;  // Tick 신호 출력

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
            tick_next  = 1'b1;  // Tick 신호 생성
        end else begin
            count_next = count_reg + 1;
            tick_next  = 1'b0;
        end
    end

endmodule

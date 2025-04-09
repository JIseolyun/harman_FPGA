`timescale 1ns / 1ps
//realtop
// top_uart_fifo.v
module top_uart_fifo (
    input  clk,
    input  rst,
    input  rx,   // UART 수신 핀
    output tx,   // UART 송신 핀

    input btnL,  // 왼쪽 버튼 (run / 시계 시간 증가)
    input btnR,  // 오른쪽 버튼 (clear)
    input btnU,  // 위쪽 버튼 (초 증가)
    input btnD,  // 아래쪽 버튼 (분 증가)
    input sw_mode,  // 모드 선택 스위치 (0: stopwatch, 1: watch)
    input sw_select,// 표시 방식 선택 스위치 (초:밀리초 or 시:분)

    output [3:0] led,  // LED 출력
    output [3:0] fnd_comm,  // FND 자릿수 선택 신호
    output [7:0] fnd_font  // FND 데이터 출력
);

    // 내부 연결 신호 정의
    wire [7:0] fifo_tx_rdata;
    wire fifo_tx_empty;
    wire fifo_tx_full;
    wire [7:0] fifo_rx_rdata;

    wire uart_tx_done, uart_rx_done;
    wire [7:0] uart_rx_data; // 이거수정해볼게게

    wire [7:0] w_tx_rx_dataout;

    wire run, clear, sec_inc, min_inc;

    // 버튼 입력 또는 UART 명령으로 동작 제어
    assign run = btnL | a_pc_run;
    assign clear = btnR | a_pc_clear;
    assign sec_inc = btnU | a_pc_sec_inc;
    assign min_inc = btnD | a_pc_min_inc;
    /*
    ila_0 U_ILA (
        .clk(clk),
        .probe0(rx_data),
        .probe1(rx_done)
    );*/

    // ====인스턴스화====

    // 송신 FIFO: RX FIFO → 저장 → TX FIFO → UART 전송
    fifo FIFO_TX (
        .clk(clk),
        .reset(rst),
        .wdata(fifo_rx_rdata),
        .wr(~fifo_rx_empty),
        .full(fifo_tx_full),
        .rd(~uart_tx_done & ~fifo_tx_empty),
        .rdata(fifo_tx_rdata),
        .empty(fifo_tx_empty)
    );

    // 수신 FIFO: UART 수신 데이터 저장
    fifo FIFO_RX (
        .clk(clk),
        .reset(rst),
        .wdata(uart_rx_data),
        .wr(uart_rx_done),
        .full(),
        .rd(~fifo_tx_full),
        .rdata(fifo_rx_rdata),
        .empty(fifo_rx_empty)
    );

    // UART 명령 해석: 수신 데이터에 따라 동작 제어 신호 생성
    uart_cu U_uart_cu (
        .clk(clk),
        .rst(rst),
        .data(uart_rx_done),
        .data_in(uart_rx_data),
        .pc_run(a_pc_run),
        .pc_clear(a_pc_clear),
        .pc_min_inc(a_pc_min_inc),
        .pc_sec_inc(a_pc_sec_inc)
    );

    // UART 모듈
    uart U_UART (
        .clk(clk),
        .rst(rst),
        .btn_start(~fifo_tx_empty),
        .tx_data_in(w_tx_rx_dataout),
        .tx_done(uart_tx_done),
        .tx(tx),
        .rx(rx),
        .rx_done(uart_rx_done),
        .rx_data(uart_rx_data)
    );

    // 송신 데이터 저장용 레지스터: RX FIFO에서 읽은 데이터를 잠깐 저장
    data_save U_Data_Save (
        .clk(clk),
        .reset(rst),
        .rd(~fifo_rx_empty),
        .data_in(fifo_rx_rdata),
        .data_out(w_tx_rx_dataout)
    );

    // 시계 & 스톱워치 모듈
    top_watch U_STOPWATCH_WATCH (
        .clk     (clk),
        .btnC    (rst),        // 공통 리셋
        .btnL    (run),        // 스톱워치: run, 시계: 시간 +1
        .btnR    (clear),      // 스톱워치: clear
        .btnU    (sec_inc),    // 시계: 초 +1
        .btnD    (min_inc),    // 시계: 분 +1
        .sw_clock(sw_mode),    // 모드 선택 (0: stopwatch, 1: watch)
        .sw_mode (sw_select),  // FND 출력 모드 선택
        .fnd_comm(fnd_comm),   // FND 자릿수 출력
        .fnd_font(fnd_font),   // FND 숫자 출력
        .led     (led)         // LED 출력
    );


endmodule

// FIFO에서 읽은 데이터를 저장하여 UART 전송 시 사용
module data_save (
    input clk,
    input reset,
    input rd,  // 데이터 읽기 신호 (RX FIFO에서)
    input [7:0] data_in,  // 입력 데이터
    output [7:0] data_out  // 저장된 출력 데이터
);
    reg [7:0] data_reg, data_next;
    assign data_out = data_reg;

    // 클럭에 따라 데이터 레지스터 업데이트
    always @(posedge clk) begin
        if (reset) begin
            data_reg <= 0;
        end else begin
            data_reg <= data_next;
        end
    end

    // 읽기 신호가 있을 때만 data_in을 저장
    always @(*) begin
        data_next = data_reg;
        if (rd) begin
            data_next = data_in;
        end
    end


endmodule

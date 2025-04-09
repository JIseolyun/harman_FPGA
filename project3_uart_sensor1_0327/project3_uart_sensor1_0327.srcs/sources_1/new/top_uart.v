`timescale 1ns / 1ps
// top_uart.v
// 기존 uart FSM 모듈 + uart_cu
module top_uart (
    input clk,
    input reset,

    input btn_start,  // 현재 미사용
    input [7:0] tx_data_in,  // 외부로부터 송신할 데이터 입력
    output tx,  // UART 송신 출력 신호
    inout tx_done,  // UART 송신 완료 상태 (외부 모듈에서 상태 확인용)
    output [7:0] w_o_data,  // UART 수신 데이터 출력
    input rx,  // UART 수신 입력 신호

    output s_trigger    // 's' 입력 감지 시 생성된 s_trigger 신호 출력
);
    wire w_tick, w_btn_start;   // UART 9600 Baud Rate 타이밍을 위한 틱 신호
    wire w_tx_done, w_rx_done;  // UART 송신 및 수신 완료 신호
    wire [7:0] w_o_data2, w_o_data3, w_o_data4; // 데이터 처리를 위한 임시 버퍼 신호
    wire w_empty, w_empty2, w_full;  // FIFO 관련 내부 신호

    uart_tx U_uart_tx (
        .clk(clk),
        .reset(reset),
        .tick(w_tick),
        .data_in(w_o_data4),
        .start_trigger(~w_empty2),
        .o_tx(tx),
        .tx_done(tx_done)
    );

    uart_rx U_uart_rx (
        .clk(clk),
        .reset(reset),
        .tick(w_tick),
        .rx(rx),
        .rx_done(w_rx_done),
        .o_data(w_o_data)
    );

    tick_gen U_tick_gen (
        .clk  (clk),
        .reset(reset),
        .tick (w_tick)
    );

    fifo FIFO_RX (
        .clk(clk),
        .reset(reset),
        .wdata(w_o_data),
        .wr(w_rx_done),
        .rd(~w_full),
        .rdata(w_o_data2),
        .empty(w_empty),
        .full()
    );

    fifo FIFO_TX (
        .clk(clk),
        .reset(reset),
        .wdata(w_o_data2),
        .wr(~w_empty),
        .rd({~w_empty2 && ~tx_done}),
        .rdata(w_o_data3),
        .empty(w_empty2),
        .full(w_full)
    );

    // 재훈 data_save 추가
    data_save U_Data_save (
        .clk(clk),
        .reset(reset),
        .rd(~w_empty2),
        .data_in(w_o_data3),
        .data_out(w_o_data4)
    );

    uart_cu U_uart_cu (
        .clk(clk),
        .reset(reset),
        .w_rx_done(w_rx_done),
        .w_o_data(w_o_data),
        .s_trigger(s_trigger)
    );  //uart_cu.v에 따로 있음.

endmodule

module uart_rx (
    input clk,
    input reset,
    input tick,
    input rx,
    output rx_done,
    output [7:0] o_data
);


    reg [7:0] data, data_next;
    reg [4:0] tick_count, tick_count_next;
    reg [1:0] state, next;
    reg r_rx_done, r_rx_done_next;
    reg [3:0] data_count, data_count_next;

    parameter R_IDLE = 4'h0, START = 4'h1, DATA_STATE = 4'h2, STOP = 4'h3;

    assign o_data  = data;
    assign rx_done = r_rx_done;
    assign o_data  = data;


    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= 0;
            data <= 0;
            data_count <= 0;
            tick_count <= 0;
            r_rx_done <= 0;
        end else begin
            state <= next;
            r_rx_done <= r_rx_done_next;
            data_count <= data_count_next;
            tick_count <= tick_count_next;
            data <= data_next;

        end
    end


    always @(*) begin
        next = state;
        r_rx_done_next = 0;
        data_count_next = data_count;
        tick_count_next = tick_count;
        data_next = data;
        case (state)
            R_IDLE: begin
                if (rx == 0) begin
                    next = START;
                end
            end
            START: begin
                if (tick == 1) begin
                    tick_count_next = tick_count + 1;
                    if (tick_count_next == 8) begin
                        next = DATA_STATE;
                        tick_count_next = 0;
                    end
                end
            end
            DATA_STATE: begin
                if (tick == 1) begin
                    tick_count_next = tick_count + 1;
                    if (tick_count_next == 16) begin
                        data_next[data_count] = rx;
                        tick_count_next = 0;
                        data_count_next = data_count + 1;
                        if (data_count_next == 8) begin
                            data_count_next = 0;
                            tick_count_next = 0;
                            next = STOP;
                        end
                    end
                end
            end

            STOP: begin
                if (tick == 1) begin
                    tick_count_next = tick_count + 1;
                    if (tick_count_next == 24) begin
                        next = R_IDLE;
                        tick_count_next = 0;
                        r_rx_done_next = 1;
                    end
                end
            end


        endcase

    end
endmodule

module uart_tx (
    input clk,
    input reset,
    input tick,
    input [7:0] data_in,
    input start_trigger,

    output o_tx,
    output tx_done
);
    parameter R_IDLE = 4'h0, START = 4'h1, DATA_STATE = 4'h2, STOP = 4'h3;

    reg [3:0] data_count, data_count_next;
    reg [3:0] state, next;
    reg [3:0] tick_count, tick_count_next;
    reg tx, tx_next;
    reg r_tx_done, r_tx_done_next;
    assign tx_done = r_tx_done;
    assign o_tx = tx;
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= 0;
            tx <= 1;
            r_tx_done <= 0;
            data_count <= 0;
            tick_count <= 0;
        end else begin
            state <= next;
            tx <= tx_next;
            r_tx_done <= r_tx_done_next;
            data_count <= data_count_next;
            tick_count <= tick_count_next;
        end
    end

    always @(*) begin
        next = state;
        tx_next = tx;
        r_tx_done_next = r_tx_done;
        data_count_next = data_count;
        tick_count_next = tick_count;
        case (state)
            R_IDLE: begin
                tx_next = 1'b1;
                r_tx_done_next = 0;
                tick_count_next = 0;
                if (start_trigger == 1) begin
                    next = START;
                    r_tx_done_next = 1;
                end
            end
            START: begin
                if (tick == 1) begin
                    if (tick_count == 15) begin
                        tx_next = 1'b0;
                        data_count_next = 0;
                        tick_count_next = 0;
                        next = DATA_STATE;
                    end else begin
                        tick_count_next = tick_count + 1;
                    end
                end
            end

            DATA_STATE: begin
                if (tick == 1) begin
                    if (tick_count == 15) begin
                        begin
                            tx_next = data_in[data_count];
                            data_count_next = data_count + 1;
                            tick_count_next = 0;
                            if (data_count_next == 8) begin
                                next = STOP;
                            end
                        end
                    end else begin
                        tick_count_next = tick_count + 1;
                    end
                end
            end
            STOP: begin
                if (tick == 1) begin
                    if (tick_count == 15) begin
                        data_count_next = 0;
                        tx_next = 1'b1;
                        tick_count_next = 0;
                        next = R_IDLE;
                    end else begin
                        tick_count_next = tick_count + 1;
                    end
                end
            end
        endcase
    end
endmodule

// UART 송신을 위한 데이터 임시 저장 모듈 (data_save)
// FIFO에서 전달된 데이터를 UART 송신 모듈로 전달하기 전에 한 클럭 동안 저장하는 버퍼 역할 수행
module data_save (
    input clk,                // 시스템 클럭 (동기 신호)
    input reset,              // 리셋 신호 (Active High)
    input rd,                 // 데이터 읽기 활성화 신호 (Read Enable)
    input [7:0] data_in,      // FIFO 등 외부에서 전달된 입력 데이터
    output [7:0] data_out     // UART 송신 모듈로 전달할 출력 데이터
);

    reg [7:0] data_reg, data_next;  // 데이터 저장을 위한 레지스터 선언

    // 저장된 데이터를 출력에 바로 연결
    assign data_out = data_reg;

    // 동기 로직: 클럭 상승 에지마다 레지스터 값 업데이트 
    always @(posedge clk) begin
        if (reset) begin
            data_reg <= 0;          // 리셋 시 데이터 초기화
        end else begin
            data_reg <= data_next;  // 평상시 다음 데이터 값을 저장
        end
    end

    // 조합 로직: 다음 데이터 값을 결정하는 로직
    always @(*) begin
        data_next = data_reg;       // 기본적으로 이전 데이터 유지
        if (rd) begin
            data_next = data_in;    // 데이터 읽기 신호 활성화 시 입력 데이터를 저장
        end
    end

endmodule

module tick_gen (
    input  clk,
    input  reset,
    output tick
);

    parameter BAUD_RATE = 9600;
    localparam BAUD_COUNT = (100_000_000 / BAUD_RATE) / 16;
    reg [$clog2(BAUD_COUNT)-1:0] count_reg, count_next;

    reg tick_reg, tick_next;
    assign tick = tick_reg;

    always @(posedge clk, posedge reset) begin
        if (reset == 1) begin
            count_reg <= 0;
            tick_reg  <= 0;
        end else begin
            count_reg <= count_next;
            tick_reg  <= tick_next;
        end
    end


    always @(*) begin
        count_next = count_reg;
        tick_next  = tick_reg;
        if (count_reg == BAUD_COUNT - 1) begin
            count_next = 0;
            tick_next  = 1;
        end else begin
            count_next = count_reg + 1;
            tick_next  = 0;
        end
    end

endmodule

module fifo (
    input clk,
    input reset,
    // write
    input [7:0] wdata,
    input wr,
    // read
    input rd,
    output [7:0] rdata,
    output empty,
    output full
);

    wire [3:0] w_waddr, w_raddr;

    register_file uregister (
        .clk(clk),
        .waddr(w_waddr),
        .wdata(wdata),
        .raddr(w_raddr),
        .wr({~full & wr}),
        .rdata(rdata)
    );

    fifo_cu ufifo_cu (
        .clk(clk),
        .reset(reset),
        .wr(wr),
        .rd(rd),
        .waddr(w_waddr),
        .raddr(w_raddr),
        .full(full),
        .empty(empty)
    );
endmodule

module register_file (
    input clk,
    input [3:0] waddr,
    input [7:0] wdata,
    input [3:0] raddr,
    input wr,
    output [7:0] rdata
);

    reg [7:0] ram[0:2**4-1];

    assign rdata = ram[raddr];

    always @(posedge clk) begin
        if (wr) begin
            ram[waddr] = wdata;
        end
    end

endmodule

module fifo_cu (
    input clk,
    input reset,
    input wr,
    input rd,
    output [3:0] waddr,
    output [3:0] raddr,
    output full,
    output empty
);

    reg full_reg, full_next, empty_reg, empty_next;
    reg [3:0] w_ptr, w_ptr_next, r_ptr, r_ptr_next;
    assign empty = empty_reg;
    assign full  = full_reg;
    assign waddr = w_ptr;
    assign raddr = r_ptr;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            w_ptr <= 0;
            r_ptr <= 0;
            full_reg <= 0;
            empty_reg <= 1;
        end else begin
            full_reg <= full_next;
            empty_reg <= empty_next;
            w_ptr <= w_ptr_next;
            r_ptr <= r_ptr_next;
        end
    end

    always @(*) begin
        full_next  = full_reg;
        empty_next = empty_reg;
        w_ptr_next = w_ptr;
        r_ptr_next = r_ptr;
        case ({
            wr, rd
        })
            2'b01: begin
                if (empty_reg == 0) begin
                    r_ptr_next = r_ptr + 1;
                    full_next  = 1'b0;
                    if (w_ptr_next == r_ptr_next) begin
                        empty_next = 1'b1;
                    end
                end
            end
            2'b10: begin
                if (full_reg == 0) begin
                    w_ptr_next = w_ptr + 1;
                    empty_next = 1'b0;
                    if (w_ptr_next == r_ptr_next) begin
                        full_next = 1'b1;
                    end
                end
            end

            2'b11: begin
                if (empty_reg == 1'b1) begin
                    w_ptr_next = w_ptr + 1;
                    empty_next = 1'b0;
                end else if (full_reg == 1'b1) begin
                    r_ptr_next = r_ptr + 1;
                    full_next  = 1'b0;
                end else begin
                    r_ptr_next = r_ptr + 1;
                    w_ptr_next = w_ptr + 1;
                end
            end

        endcase
    end

endmodule


`timescale 1ns / 1ps

module uart (
    //global
    input clk,
    input reset,
    //tx
    input [7:0] tx_data,
    input tx_start,
    output tx_busy,
    output tx_done,
    output tx,
    //rx
    input rx,
    output [7:0] rx_data,
    output rx_done
);

    wire br_tick;

    baudrate_gen U_BaudRate_Gen (
        .clk(clk),
        .reset(reset),
        .br_tick(br_tick)
    );

    transmitter U_Transmitter (
        .clk(clk),
        .reset(reset),
        .tx_data(tx_data),
        .tx_start(tx_start),
        .br_tick(br_tick),
        .tx_busy(tx_busy),
        .tx_done(tx_done),
        .tx(tx)
    );

    receiver U_Receiver (
        .clk(clk),
        .reset(reset),
        .br_tick(br_tick),
        .rx_data(rx_data),
        .rx_done(rx_done),
        .rx(rx)
    );

endmodule

module baudrate_gen (
    input clk,
    input reset,
    output reg br_tick
);
    reg [9:0] br_counter;
    // 100_000_000/9600/16-1 = 650 -> 2의 10승 = 1024 -> [9:0]

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            br_counter <= 0;
            br_tick <= 1'b0;
        end else begin
            if (br_counter == 100_000_000 / 9600 / 16 - 1) begin //"100MHz 클럭을 9600bps로 분주하겠다"는 의미 
                //클럭을 10417주기마다 한 번 "tick"을 발생시켜야 UART 타이밍과 일치함
                //→ 이건 9600bps의 1비트 기간을 16개로 나눈 clock tick을 생성
                //→ 즉, UART 송수신기 내부 FSM이 1비트를 16개의 세부 tick으로 쪼개어 처리할 수 있도록 만듦
                br_counter <= 0;
                br_tick <= 1'b1;
            end else begin
                br_counter <= br_counter + 1;
                br_tick <= 1'b0;
            end
        end
    end
endmodule

//tx
module transmitter (
    input clk,
    input reset,
    input [7:0] tx_data,
    input tx_start,
    input br_tick,
    output tx_busy,
    output tx_done,
    output reg tx
);
    localparam IDLE = 0, START = 1, DATA = 2, STOP = 3;
    reg [1:0] state, state_next;
    reg [7:0] temp_data_reg, temp_data_next;
    reg [2:0] bit_counter_reg, bit_counter_next;
    reg [3:0] tick_counter_reg, tick_counter_next;
    reg tx_busy_reg, tx_busy_next, tx_done_reg, tx_done_next;

    assign tx_busy = tx_busy_reg;
    assign tx_done = tx_done_reg;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= IDLE;
            temp_data_reg <= 0;
            bit_counter_reg <= 0;
            tick_counter_reg <= 0;
            tx_busy_reg <= 1'b0;
            tx_done_reg <= 1'b0;
        end else begin
            state <= state_next;
            temp_data_reg <= temp_data_next;
            bit_counter_reg <= bit_counter_next;
            tick_counter_reg <= tick_counter_next;
            tx_busy_reg <= tx_busy_next;
            tx_done_reg <= tx_done_next;
        end
    end

    // posedge clk, posedge reset -> 이 구조 밀려서 못 씀
    // * -> =
    // posedge -> <= 
    // reg, next 생성 이유? -> latch 방지
    // tx_busy -> 값이 1일 때: "바쁘다", 송신 동작 중 // 값이 0일 때: "한가하다", tx_data를 받아도 됨
    // tx_done -> 의미: 이번 전송이 "완료됨"을 한 사이클 동안 알리는 신호 -> 즉, 외부에서 "송신이 끝났는지"를 판단하는 용도로 사용
    always @(*) begin
        state_next = state;
        temp_data_next = temp_data_reg;
        bit_counter_next = bit_counter_reg;
        tick_counter_next = tick_counter_reg;
        tx_busy_next = tx_busy_reg;
        tx_done_next = tx_done_reg;
        //tx를 reg와 next로 나누지 않아도 latch가 발생하지 않았음!!
        //tx가 모든 state에 다 들어가있다. (여기 1~4)
        case (state)
            IDLE: begin
                tx = 1'b1;  //여기1
                tx_busy_next = 1'b0;
                tx_done_next = 1'b0;
                if (tx_start) begin
                    state_next = START;
                    temp_data_next = tx_data;  //temp라는 임시 저장처에 넣음
                    tx_busy_next = 1'b1;
                end
            end
            START: begin
                tx = 1'b0;  //여기2
                if (br_tick) begin
                    if (tick_counter_reg == 15) begin
                        state_next = DATA;
                        bit_counter_next = 0;
                        tick_counter_next = 0;
                    end else begin
                        tick_counter_next = tick_counter_reg + 1;
                    end
                end
            end
            DATA: begin
                tx = temp_data_reg[0];  //여기3
                if (br_tick) begin
                    if (tick_counter_reg == 15) begin
                        tick_counter_next = 0;
                        if (bit_counter_reg == 7) begin
                            state_next = STOP;
                        end else begin
                            bit_counter_next = bit_counter_reg + 1;
                            temp_data_next   = {1'b0, temp_data_reg[7:1]};
                        end
                    end else begin
                        tick_counter_next = tick_counter_reg + 1;
                    end
                end
            end
            STOP: begin
                tx = 1'b1;  //여기4
                if (br_tick) begin
                    if (tick_counter_reg == 15) begin
                        state_next = IDLE;
                        tick_counter_next = 0;
                        tx_done_next = 1'b1;
                    end else begin
                    tick_counter_next = tick_counter_reg + 1;
                    end
                end
            end
        endcase
    end

endmodule

//rx
module receiver (
    input clk,
    input reset,
    input br_tick,
    output [7:0] rx_data,
    output rx_done,
    input rx
);
    localparam IDLE = 0, START = 1, DATA = 2, STOP = 3;
    reg [1:0] state, state_next;
    reg rx_done_reg, rx_done_next;
    reg [2:0] bit_counter_reg, bit_counter_next;
    reg [3:0] tick_counter_reg, tick_counter_next;
    reg [7:0] temp_data_reg, temp_data_next;

    assign rx_data = temp_data_reg;
    assign rx_done = rx_done_reg; 

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= IDLE;
            rx_done_reg <= 1'b0;
            bit_counter_reg <= 1'b0;
            tick_counter_reg <= 1'b0;
            temp_data_reg <= 1'b0;
        end else begin
            state <= state_next;
            rx_done_reg <= rx_done_next;
            bit_counter_reg <= bit_counter_next;
            tick_counter_reg <= tick_counter_next;
            temp_data_reg <= temp_data_next;
        end
    end

    always @(*) begin
        state_next = state;
        rx_done_next = rx_done_reg;
        bit_counter_next = bit_counter_reg;
        tick_counter_next = tick_counter_reg;
        temp_data_next = temp_data_reg;
        case (state)
            IDLE: begin
                rx_done_next = 1'b0;
                if (rx == 1'b0) begin
                    state_next = START;
                    bit_counter_next = 0;
                    tick_counter_next = 0;
                    temp_data_next = 0;
                end
            end 
            START: begin
                if (br_tick) begin
                    if (tick_counter_reg == 7) begin
                        state_next = DATA;
                        tick_counter_next = 0;
                    end else begin
                        tick_counter_next = tick_counter_reg + 1;
                    end
                end
            end
            DATA: begin
                if (br_tick) begin
                    if (tick_counter_reg == 15) begin
                        tick_counter_next = 0;
                        temp_data_next = {rx, temp_data_next[7:1]};
                        if (bit_counter_reg == 7) begin
                            state_next = STOP;
                            bit_counter_next = 0;
                        end else begin
                            bit_counter_next = bit_counter_reg + 1;
                        end
                    end else begin
                        tick_counter_next = tick_counter_reg + 1;
                    end
                end
            end
            STOP: begin
                if (br_tick) begin
                    if (tick_counter_reg == 15) begin
                        rx_done_next = 1'b1;
                        state_next = IDLE;
                    end else begin
                        tick_counter_next = tick_counter_reg + 1;
                    end
                end 
            end
        endcase
    end
endmodule

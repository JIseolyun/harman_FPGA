`timescale 1ns / 1ps
// top_dht11.v

module dht11 (
    input clk,
    input reset,
    //input start_trigger,
    input btn_start,
    output [3:0] led,
    inout dht_io
    //input data,
    //output start_tick,
    //output [7:0] seg_out,
    //output [3:0] seg_comm
);
    wire w_tick;
    //wire w_start_trigger;
    //wire [15:0] w_o_data;

    dht11_controller U_dht11_ctrl (
        .clk(clk),
        .reset(reset),
        .tick(w_tick),
        .start(btn_start),  // btn_start
        .led_m(led),
        .humidity(),
        .temperature(),
        .dht_io(dht_io)
    );
    /*
    btn_debounce U_btn_db(
        .i_btn(start_trigger),
        .clk  (clk),
        .reset(reset),
        .o_btn(w_start_trigger)
    );
*/
    tick_gen_1us U_tick_1us (
        .clk  (clk),
        .reset(reset),
        .tick (w_tick)
    );
    /*
    fnd_controller U_fnd_contrl(
        .clk(clk),
        .reset(reset),
        .count(w_o_data),
        .seg_out(seg_out),
        .seg_comm(seg_comm)
    );*/
endmodule

//0이 읽히면 high
module dht11_controller (
    input clk,
    input reset,
    input tick,
    input start,  // btn_start
    output [3:0] led_m,
    output [15:0] humidity,
    output [15:0] temperature,

    inout dht_io
);
    //parameter START_CNT = 18000, WAIT_CNT = 30, TIME_OUT = 20;
    // DATA_01 -> 4보다 작거나 or 크거나
    // 
    parameter START_CNT = 1800, WAIT_CNT = 3, SYNC_CNT = 8, DATA_SYNC = 5, DATA_01 = 4, 
              STOP_CNT = 5, TIME_OUT = 2000; //교수님코드
    
    //localparam IDLE = 0, START = 1, WAIT = 2, READ = 3;
    localparam IDLE = 0, START = 1, WAIT = 2, SYNC_LOW = 3, SYNC_HIGH = 4, DATA_SYNC = 5, 
               DATA_DC = 6, STOP = 7;

    // reg / wire 
    reg [2:0] c_state, n_state;
    reg [$clog2(TIME_OUT)-1:0] count_reg, count_next;
    //  reg io_oe_reg. io_oe_next
    reg io_oe_reg, io_oe_next;
    reg io_out_reg, io_out_next;
    reg led_ind_reg, led_ind_next;  // indicator
    reg [39:0] data_reg, data_next; // 추가가

    // out 3state on/off
    assign dht_io = (io_oe_reg) ? io_oe_reg : 1'bz;
    assign led_m  = {led_ind_reg, c_state};

    // state
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            c_state <= IDLE;
            count_reg <= 0;
            led_ind_reg <= 0;
            io_out_reg <= 1'b1;  // idle, high
            io_oe_reg <= 0;
        end else begin
            c_state <= n_state;
            count_reg <= count_next;
            led_ind_reg <= led_ind_next;
            io_out_reg <= io_out_next;
            io_oe_reg <= io_oe_next;
        end
    end
    // next
    always @(*) begin
        n_state = c_state;
        count_next = count_reg;
        led_ind_next = led_ind_reg;
        io_out_next = io_out_reg;
        io_oe_next = io_oe_reg;
        case (c_state)
            IDLE: begin
                io_out_next = 1'b1;
                io_oe_next  = 1'b1;
                if (start) begin
                    n_state = START;
                    count_next = 0;
                end
            end
            START: begin
                io_out_next = 1'b0;
                // tick 1때만 count.
                if (tick) begin
                    if (count_reg == START_CNT - 1) begin
                        n_state = WAIT;
                        count_next = 0;
                    end else begin
                        count_next = count_reg + 1;
                    end
                end
            end
            WAIT: begin
                io_out_next = 1'b1;
                if (tick) begin
                    if (count_reg == WAIT_CNT - 1) begin
                        n_state = SYNC_LOW;
                        count_next = 0;
                    end else begin
                        count_next = count_reg + 1;
                    end
                end
            end
            SYNC_LOW: begin
                io_out_next = 1'b0;
                if (tick) begin
                    if (count_reg == SYNC_CNT - 1) begin
                        n_state = SYNC_HIGH;
                        count_next = 0;
                    end else begin
                        count_next = count_reg + 1;
                    end
                end
            end
            SYNC_HIGH: begin
                io_out_next = 1'b1;
                if (tick) begin
                    if (count_reg == SYNC_CNT - 1) begin
                        n_state = DATA_SYNC;
                        count_next = 0;
                    end else begin
                        count_next = count_reg + 1;
                    end
                end
            end
            DATA_SYNC: begin
                io_out_next = 1'b0;
                if (tick) begin
                    if (count_reg == DATA_SYNC - 1) begin
                        n_state = DATA_DC;
                        count_next = 0;
                    end else begin
                        count_next = count_reg + 1;
                    end
                end
            end
            DATA_DC: begin // 판별// DATA_0이냐 DATA_1이냐
                if (count_reg < 40) begin
                    data_next [bit_count_reg] = 1'b0;
                    data_next = {1'b0, data_reg[39:1], 1'b0};
                    //n_state = STOP;
                    //count_next = 0;
                end else begin
                    data_next [bit_count_reg] = 1'b1;
                    //data_next = {1'b0, data_reg[39:1], 1'b0};
                end
            end
            STOP: begin
                io_out_next = 1'b1;
                if (tick) begin
                    if (count_reg == STOP_CNT - 1) begin
                        n_state = IDLE;
                        count_next = 0;
                    end else begin
                        count_next = count_reg + 1;
                    end
                end
                if (dht_io == 1'b0) begin
                    led_ind_next = 1'b1;
                end else begin
                    led_ind_next = 1'b0;
                end
            end
            /*
            READ: begin
                // io oe change.
                // output open, High-z
                io_oe_next = 1'b0;
                if (tick) begin
                    if (count_reg == TIME_OUT) begin
                        n_state = IDLE;
                        count_next = 0;
                    end else begin
                        count_next = count_reg + 1;
                    end
                end
                if (dht_io == 1'b0) begin
                    led_ind_next = 1'b1;
                end else begin
                    led_ind_next = 1'b0;
                end
            end*/

        endcase


    end


endmodule
module tick_gen_1us (
    input  clk,
    input  reset,
    output tick
);

    parameter FCOUNT = 1000;
    reg [$clog2(FCOUNT)-1:0] counter;
    reg tick_reg;
    assign tick = tick_reg;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            counter  <= 0;
            tick_reg <= 0;
        end else begin
            if (counter == FCOUNT - 1) begin
                counter  <= 0;
                tick_reg <= 1'b1;
            end else begin
                counter  <= counter + 1;
                tick_reg <= 1'b0;
            end
        end
    end

endmodule

/*
module tick_1us (
    input  clk,
    input  reset,
    output tick
);

    localparam BAUD_COUNT = 100;
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
            tick_next  = 1'b1;
        end else begin
            count_next = count_reg + 1;
            tick_next  = 1'b0;
        end
    end

endmodule*/



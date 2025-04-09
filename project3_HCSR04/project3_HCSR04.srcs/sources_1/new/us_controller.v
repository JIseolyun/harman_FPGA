`timescale 1ns / 1ps
//US_controller.v
module US_controller (
    input clk,
    input rst,
    input tick,
    input btn_start,
    input echo,
    output reg trig,
    output reg start_count,
    output reg done
);

    parameter IDLE  = 2'd0;
    parameter START = 2'd1;
    parameter COUNT = 2'd2;
    parameter CALC  = 2'd3;

    reg [1:0] state, next_state;

    reg [9:0] cnt;

    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin 
                if (btn_start) next_state = START;
            end
            START: begin 
                if (cnt == 10) next_state = COUNT;
            end
            COUNT: begin
                if (!echo) next_state = CALC;
            end
            CALC: begin
                next_state = IDLE;
            end
        endcase
    end
    
    // latch가 너무 많으니 reg/next 구조로 변경해서 assign 구조로 바꾸기!
    //reg [1:0] trig_reg, trig_next;
    // reg [1:0] cnt_reg, cnt_next;
    // reg [1:0] start_count_reg, start_count_next;
    // reg [1:0] done_reg, done_next;


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            trig <= 0;
            cnt <= 0;
            start_count <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    trig <= 0;
                    cnt <= 0;
                    start_count <= 0;
                    done <= 0;
                end
                START: begin
                    if (tick) cnt <= cnt + 1;
                    trig <= 1;
                end
                COUNT: begin
                    trig <= 0;
                    start_count <= 1;
                end
                CALC: begin
                    start_count <= 0;
                    done <= 1;
                end
            endcase
        end
    end
endmodule
`timescale 1ns / 1ps

module fsm_exam (
    input clk,
    input reset,
    input [2:0] sw,
    output [2:0] led
);

    parameter [2:0] IDLE = 3'b000, LED01 = 3'b001, LED02 = 3'b010, LED03 = 3'b100, LED04 = 3'b111;

    reg [2:0] r_led;
    reg [2:0] state, next;

    assign led = r_led;

    // 
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= 0;
            //next  <= 0;
        end else begin
            // 상태관리, 현재상태를 next로 바꿔라
            state <= next;
        end
    end

    // next combinational logic
    // 다음 상태로 가기 위한 로직
    always @(*) begin
        next = state;
        case (state)  // 현재상태
            IDLE: begin
                // 다음 상태로 가기 위한 조건
                if (sw == 3'b001) begin
                    next = LED01;
                end else if (sw == 3'b010) begin
                    next = LED02;
                end else begin
                    next = state;
                end
            end
            LED01: begin
                if (sw == 3'b010) begin
                    next = LED02;
                end
            end
            LED02: begin
                if (sw == 3'b100) begin
                    next = LED03;
                end
            end
            LED03: begin
                if (sw == 3'b000) begin
                    next = IDLE;
                end else if (sw == 3'b111)begin
                    next = LED04;
                end else if (sw == 3'b001) begin
                    next = LED01;
                end else begin
                    next = state;
                end
            end

            /*
             LED02: begin
                if (sw == 3'b110) begin
                    next = LED01;
                end else if (sw == 3'b111) begin
                    next = IDLE;
                end else begin
                    next = state;
                end
            end*/


            LED04: begin
                if (sw == 3'b100) begin
                    next = LED03;
                end
            end
            default: next = state;
            /*
            LED02: begin
                if (sw == 3'b110) begin
                    next = LED01;
                end else if (sw == 3'b111) begin
                    next = IDLE;
                end else begin
                    next = state;
                end
            end
            default: next = state;*/
        endcase
    end

    // output combinational logic
    always @(*) begin
        case (state)
            IDLE: begin
                r_led = 3'b000;
            end
            LED01: begin
                r_led = 3'b001;
            end
            LED03: begin
                r_led = 3'b100;
            end
            LED04: begin
                r_led = 3'b111;
            end
            default: r_led = 3'b000;
        endcase
    end

endmodule

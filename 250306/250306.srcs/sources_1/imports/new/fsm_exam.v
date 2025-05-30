`timescale 1ns / 1ps

module fsm_exam (
    input clk,
    input reset,
    input [2:0] sw,
    output [2:0] led    
);

    parameter [2:0] IDLE = 3'b000, ST1 = 3'b001, ST2 = 3'b010, ST3 = 3'b100, ST4 = 3'b111;

    reg [2:0] r_led;
    reg [2:0] state, next;

    assign led = r_led;

    // state 저장
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
        // next = state;
        case (state)  // 현재상태
            IDLE: begin
                // 다음 상태로 가기 위한 조건
                if (sw == 3'b001) begin
                    next = ST1;
                end else if (sw == 3'b010) begin
                    next = ST2;
                end else begin
                    next = state;
                end
            end
            ST1: begin
                if (sw == 3'b010) begin
                    next = ST2;
                end else begin
                    next = state;
                end 
            end
            ST2: begin
                if (sw == 3'b100) begin
                    next = ST3;
                end else begin
                    next = state;
                end
            end
            ST3: begin
                if (sw == 3'b111) begin
                    next = ST4;
                end else if (sw == 3'b000) begin
                    next = IDLE;
                end else if (sw == 3'b001) begin
                    next = ST1;
                end else begin
                    next = state;
                end
            end
            ST4: begin
                if (sw == 3'b100) begin
                    next = ST3;
                end else begin
                    next = state;
                end
            end
            default: next = state;
            //default: next = IDLE; // [수정] 기본 상태를 명확하게 IDLE로 설정
            
        endcase
    end

    // output combinational logic
    always @(*) begin
        //r_led = 3'b000; // [수정] latch 방지를 위해 기본값을 설정
        case (state)
            IDLE: begin
                if (sw == 3'b001) begin
                    r_led = 3'b001; // mealy
                end else if (sw == 3'b010) begin
                    r_led = 3'b010;
                end else begin
                    r_led = 3'b000;
                end
            end
            ST1: begin
                if (sw == 3'b010) begin
                    r_led = 3'b010; // mealy
                end else begin
                    r_led = 3'b001;
                end
            end
            ST2: begin
                if (sw == 3'b100) begin
                    r_led = 3'b100; // mealy
                end else begin
                    r_led = 3'b010;
                end
            end
            ST3: begin
                if (sw == 3'b000) begin
                    r_led = 3'b000; // mealy
                end else if (sw == 3'b111) begin
                    r_led = 3'b111;
                end else if (sw == 3'b001) begin
                    r_led = 3'b001;
                end else begin
                    r_led = 3'b100;
                end
            end
            ST4: begin
                if (sw == 3'b100) begin
                    r_led = 3'b100; // mealy
                end else begin
                    r_led = 3'b111;                 
                end
            end
            default: r_led = 3'b000;
        endcase
    end

endmodule

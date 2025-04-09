`timescale 1ns / 1ps

module msec_counter(
    input clk_100k, 
    input reset,
    output reg [6:0] o_msec,  // 0 ~ 99 (10ms 단위)
    output reg tick         // 1초(100 × 10ms)마다 1클럭 펄스 발생
);
    reg [9:0] count; // 0 ~ 999: 1000 사이클 = 10ms × 100 = 1초
    always @(posedge clk_100k or posedge reset) begin
        if (reset) begin
            count <= 0;
            o_msec <= 0;
            tick <= 0;
        end else begin
            tick <= 0;
            if (count == 999) begin
                count <= 0;
                if (o_msec == 99) begin
                    o_msec <= 0;
                    tick <= 1;  // 1초 경과
                end else begin
                    o_msec <= o_msec + 1;
                end
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule

`timescale 1ns / 1ps
module Top_Upcounter (
    input clk,
    input reset,
    output [3:0] seg_comm,
    output [7:0] seg
);

    wire [13:0] w_count;

    fnd_controller U_fnd_cntl (
        .clk(clk),
        .reset(reset),
        .bcd(w_count),
        .seg(seg),
        .seg_comm(seg_comm)
    );

    counter_10000 U_counter_10000 (
        .clk(clk),
        .reset(reset),
        .count(w_count)
    );

endmodule


module counter_10000 (
    input clk,
    input reset,
    output [13:0] count
);
    //reg [$clog2(10000)-1:0] r_counter;
    reg [13:0] r_counter;
    assign count = r_counter;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            r_counter <= 0;
        end else begin
            if (r_counter == 10000 - 1) begin
                r_counter <= 0;
            end else begin
                r_counter <= r_counter + 1;
            end
            
        end
    end

endmodule

`timescale 1ns / 1ps

module seq_det_mealy (
    input clk,
    input rst,
    input din_bit,
    output dout_bit
);

  reg [2:0] state_reg, next_state;

  parameter start     = 3'b000;
  parameter rd0_once  = 3'b001;
  parameter rd1_once  = 3'b010;
  parameter rd0_twice = 3'b011;
  parameter rd1_twice = 3'b100;

  always @(state_reg or din_bit) begin
    case(state_reg)
      start: 
        if (din_bit == 0) next_state = rd0_once;
        else if (din_bit == 1) next_state = rd1_once;
        else next_state = start;
      
      rd0_once:
        if (din_bit == 0) next_state = rd0_twice;
        else if (din_bit == 1) next_state = rd1_once;
        else next_state = start;
      
      rd0_twice:
        if (din_bit == 0) next_state = rd0_twice;
        else if (din_bit == 1) next_state = rd1_once;
        else next_state = start;
      
      rd1_once:
        if (din_bit == 0) next_state = rd0_once;
        else if (din_bit == 1) next_state = rd1_twice;
        else next_state = start;
      
      rd1_twice:
        if (din_bit == 0) next_state = rd0_once;
        else if (din_bit == 1) next_state = rd1_twice;
        else next_state = start;
      
      default:
        next_state = start;
    endcase
  end

  // 상태 레지스터를 위한 always 순차회로 블록
  always @(posedge clk or posedge rst) begin
    if (rst == 1) state_reg <= start;
    else state_reg <= next_state;
  end

  // 출력값 결정
  assign dout_bit = (((state_reg == rd0_twice) && (din_bit == 0)) ||
                     ((state_reg == rd1_twice) && (din_bit == 1))) ? 1 : 0;

endmodule

//send_tx_btn.v
`timescale 1ns / 1ps

module send_tx_btn (
    input  clk,
    input  rst,
    input  btn_start,
    output tx
);
    // FSM 상태 정의
    parameter S_IDLE  = 0, S_SEND  = 1, S_WAIT_RISE = 2, S_WAIT_FALL = 3;
    
    wire w_start, w_tx_done;
    reg [7:0] send_tx_data_reg, send_tx_data_next;
    reg [1:0] state, next;
    reg [3:0] count_reg, count_next;
    reg start_uart;

    btn_debounce U_Start_btn (
        .clk  (clk),
        .reset(rst),
        .i_btn(btn_start),
        .o_btn(w_start)
    );

    uart U_UART (
        .clk       (clk),
        .rst       (rst),
        .btn_start (start_uart),
        .tx_data_in(send_tx_data_reg),
        .tx_done   (w_tx_done),
        .tx        (tx)
    );


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state             <= S_IDLE;
            send_tx_data_reg  <= 8'h30;
            count_reg         <= 0;
        end else begin
            state             <= next;
            send_tx_data_reg  <= send_tx_data_next;
            count_reg         <= count_next;
        end
    end

    always @(*) begin
        next              = state;
        send_tx_data_next = send_tx_data_reg;
        count_next        = count_reg;
        start_uart        = 1'b0;
        case (state)
            S_IDLE: begin
                if (w_start) begin
                    next = S_SEND;
                    count_next = 0;
                end
            end
            S_SEND: begin
                start_uart = 1'b1;  
                next = S_WAIT_RISE;
            end
            S_WAIT_RISE: begin
                if (w_tx_done == 1'b1) begin
                    next = S_WAIT_FALL;
                end
            end
            S_WAIT_FALL: begin
                if (w_tx_done == 1'b0) begin
                    if (send_tx_data_reg == "z") begin
                        send_tx_data_next = "0";
                    end else begin
                        send_tx_data_next = send_tx_data_reg + 1;
                    end
                    count_next = count_reg + 1;
                    if (count_reg == 4'd15) begin
                        next = S_IDLE;
                    end else begin
                        next = S_SEND;
                    end
                end
            end

        endcase
    end

endmodule


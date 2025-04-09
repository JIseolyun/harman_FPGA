`timescale 1ns / 1ps

module UART_FIFO_SENSOR(
    input         clk,          // 시스템 클록 (예: 100MHz)
    input         reset,        // 비동기 리셋
    // HC-SR04 센서
    input         sensor_echo,  // 에코 신호
    output        sensor_trig,  // 트리거 신호
    // 물리 버튼 (옵션)
    input         btn_start,    // 거리 측정용 버튼
    // UART
    input         uart_rx,      // PC -> FPGA 수신
    output        uart_tx,      // FPGA -> PC 송신
    // 7‑세그먼트 디스플레이
    output [7:0]  seg_out,
    output [3:0]  seg_comm
);

    //-------------------------------------------
    // 1. 센서 측정 (top_sensor) 인스턴스화
    //    - 내부적으로 sensor_cu, fnd_controller, btn_debounce, tick_1us 포함
    //-------------------------------------------
    wire [15:0] w_distance;    // 센서에서 측정된 거리 (cm)
    wire        w_start_tick;  // 센서 트리거 펄스
    wire        w_sensor_start; // 버튼 또는 UART 명령으로부터 센서 동작 요청

    top_sensor u_top_sensor (
        .clk         (clk),
        .reset       (reset),
        .start_trigger(w_sensor_start),  // 센서 측정 시작 트리거
        .data        (sensor_echo),
        .start_tick  (w_start_tick),     // 내부에서 생성되는 트리거 펄스 (HC-SR04용)
        .seg_out     (seg_out),
        .seg_comm    (seg_comm)
    );

    // top_sensor 내부에서 sensor_cu.o_data가 거리(16비트)로 계산된다고 가정
    // 아래와 같이 연결했다고 가정 (직접 코드 수정 필요할 수 있음)
    // assign w_distance = sensor_inst.sensor_cu_inst.o_data;  <-- 실제 연결
    // 여기서는 top_sensor에 수정해서 o_data를 꺼내오도록 가정
    // 예: top_sensor에 wire [15:0] w_o_data를 output으로 연결

    // 아래는 top_sensor에 새로 추가된 output이라고 가정
    wire [15:0] w_o_data_sensor;
    assign w_distance = w_o_data_sensor;

    //-------------------------------------------
    // 2. UART RX → 's'/'S' 명령 수신
    //-------------------------------------------
    wire [7:0] w_rx_data;
    wire       w_rx_done;

    // 간단한 UART RX (9600 or 115200 등) - 아래 tick_9600hz는 예시
    // 실제 클록(예: 100MHz)에 맞춰 BAUD_COUNT 수정
    uart_rx u_uart_rx (
        .clk     (clk),
        .reset   (reset),
        .tick    (w_rx_tick),   // 아래에서 생성
        .rx      (uart_rx),
        .rx_done (w_rx_done),
        .o_data  (w_rx_data)
    );

    // 9600 보드레이트용 tick 생성
    tick_9600hz u_tick_9600 (
        .clk     (clk),
        .reset   (reset),
        .tick    (w_rx_tick)
    );

    // 's' 또는 'S' 수신 시 센서 동작 플래그
    reg r_uart_sensor_trigger;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_uart_sensor_trigger <= 1'b0;
        end else begin
            if (w_rx_done && (w_rx_data == 8'h73 || w_rx_data == 8'h53))
                r_uart_sensor_trigger <= 1'b1;
            else
                r_uart_sensor_trigger <= 1'b0;
        end
    end

    //-------------------------------------------
    // 3. 물리 버튼 & UART 명령 OR 연산 → 센서 시작
    //-------------------------------------------
    assign w_sensor_start = btn_start | r_uart_sensor_trigger;

    //-------------------------------------------
    // 4. 센서 거리 -> FIFO_TX -> UART_TX
    //    측정 완료 시점에 거리값을 FIFO에 적재(ASCII 변환 포함)
    //-------------------------------------------
    // (1) 센서 측정이 완료되었다고 가정하는 신호를 만들어야 함
    //     예: sensor_cu가 에코 신호가 끝날 때 IDLE로 돌아오면 완료로 볼 수 있음
    //     여기서는 간단히 w_sensor_start가 들어온 후 일정 시간이 지난 시점 등으로 가정
    // (2) 측정된 w_distance를 ASCII 문자열로 변환하여 FIFO에 기록
    //-------------------------------------------

    // 간단한 완료 플래그: 센서 측정 트리거 후 일정 시간 뒤(에코가 끝났다고 가정)
    // 실제로는 sensor_cu 내부의 상태머신에서 "DATA -> IDLE"로 바뀔 때 등 정확한 완료 신호를 만들어 연결하는 것이 바람직함
    reg [23:0] r_count;
    reg        r_done;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_count <= 0;
            r_done  <= 1'b0;
        end else begin
            if (w_sensor_start) begin
                r_count <= 0;
                r_done  <= 1'b0;
            end else if (r_count < 24'd5_000_000) begin // 예: 약 50ms 정도 후 완료로 가정
                r_count <= r_count + 1;
                if (r_count == 24'd5_000_000 - 1)
                    r_done <= 1'b1;  // 측정 완료
            end
        end
    end

    // 거리값을 ASCII로 변환
    wire [7:0] w_ascii0, w_ascii1, w_ascii2, w_ascii3, w_ascii4; // 최대 5자리
    dist_to_ascii u_dist2ascii (
        .distance (w_distance),
        .ascii0   (w_ascii0),
        .ascii1   (w_ascii1),
        .ascii2   (w_ascii2),
        .ascii3   (w_ascii3),
        .ascii4   (w_ascii4)
    );

    // FIFO_TX에 쓰기 제어
    reg [2:0]  r_send_state;
    reg [2:0]  r_send_next;
    reg [7:0]  r_data_in;
    reg        r_wr;
    wire       w_full, w_empty;
    wire [7:0] w_fifo_rdata;
    wire       w_rd;

    localparam S_IDLE = 0, S_WRITE0 = 1, S_WRITE1 = 2, 
               S_WRITE2 = 3, S_WRITE3 = 4, S_WRITE4 = 5, S_DONE = 6;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_send_state <= S_IDLE;
        end else begin
            r_send_state <= r_send_next;
        end
    end

    always @(*) begin
        r_send_next = r_send_state;
        case(r_send_state)
            S_IDLE:   if (r_done)      r_send_next = S_WRITE0;
            S_WRITE0: r_send_next = S_WRITE1;
            S_WRITE1: r_send_next = S_WRITE2;
            S_WRITE2: r_send_next = S_WRITE3;
            S_WRITE3: r_send_next = S_WRITE4;
            S_WRITE4: r_send_next = S_DONE;
            S_DONE:   r_send_next = S_IDLE;
        endcase
    end

    // FIFO 쓰기 로직
    always @(*) begin
        r_data_in = 8'h00;
        r_wr      = 1'b0;
        case(r_send_state)
            S_WRITE0: begin
                r_data_in = w_ascii0; // 천의 자리
                r_wr      = 1'b1;
            end
            S_WRITE1: begin
                r_data_in = w_ascii1; // 백의 자리
                r_wr      = 1'b1;
            end
            S_WRITE2: begin
                r_data_in = w_ascii2; // 십의 자리
                r_wr      = 1'b1;
            end
            S_WRITE3: begin
                r_data_in = w_ascii3; // 일의 자리
                r_wr      = 1'b1;
            end
            S_WRITE4: begin
                r_data_in = w_ascii4; // 줄바꿈 등 (여기선 '\n' 가정)
                r_wr      = 1'b1;
            end
        endcase
    end

    fifo u_fifo_tx (
        .clk   (clk),
        .reset (reset),
        .wdata (r_data_in),
        .wr    (r_wr & ~w_full),
        .rd    (w_rd),
        .rdata (w_fifo_rdata),
        .empty (w_empty),
        .full  (w_full)
    );

    //-------------------------------------------
    // 5. UART_TX
    //    - FIFO에서 데이터를 꺼내 직렬 전송
    //-------------------------------------------
    wire w_tx_done;
    reg  r_tx_start;

    // FIFO에 데이터가 있으면 UART_TX가 읽도록
    // (UART_TX가 한 바이트를 전송 시작할 때 RD=1, 전송이 완료될 때까지는 RD=0)
    // 간단한 상태: FIFO empty가 아니면 start_trigger를 1회 펄스로 준다
    // 실제로는 더 정교한 제어 필요 (tx_done 시점 확인 등)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_tx_start <= 1'b0;
        end else begin
            if (~w_empty && w_tx_done)  // 보낼 데이터가 있고, 이전 전송이 끝났다면
                r_tx_start <= 1'b1;
            else
                r_tx_start <= 1'b0;
        end
    end

    // UART_TX에 데이터를 주기 위해 FIFO에서 RD
    assign w_rd = (r_tx_start == 1'b1);

    uart_tx u_uart_tx (
        .clk          (clk),
        .reset        (reset),
        .tick         (w_rx_tick), // 같은 baud tick 사용 가능
        .data_in      (w_fifo_rdata),
        .start_trigger(r_tx_start),
        .o_tx         (uart_tx),
        .tx_done      (w_tx_done)
    );

    //-------------------------------------------
    // 6. 센서 트리거 출력 연결
    //    (top_sensor 내부에서 start_tick을 sensor_trig로 할당)
    //-------------------------------------------
    assign sensor_trig = w_start_tick;



endmodule

    module dist_to_ascii(
    input  [15:0] distance,  // 최대 9999cm 가정
    output [7:0] ascii0,     // 천의 자리
    output [7:0] ascii1,     // 백의 자리
    output [7:0] ascii2,     // 십의 자리
    output [7:0] ascii3,     // 일의 자리
    output [7:0] ascii4      // 줄바꿈 등
    );
    wire [3:0] d0, d1, d2, d3;
    // BCD 분리
    assign d0 = (distance / 1000) % 10;
    assign d1 = (distance / 100)  % 10;
    assign d2 = (distance / 10)   % 10;
    assign d3 = distance % 10;

    // ASCII 변환 ('0' + BCD)
    assign ascii0 = 8'h30 + d0;  // 천
    assign ascii1 = 8'h30 + d1;  // 백
    assign ascii2 = 8'h30 + d2;  // 십
    assign ascii3 = 8'h30 + d3;  // 일
    // 마지막 문자: 줄바꿈(0x0A), 캐리지리턴(0x0D) 등
    assign ascii4 = 8'h0A;       // '\n'
endmodule
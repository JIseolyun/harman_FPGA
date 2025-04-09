`timescale 1ns / 1ps
// tb_0to9.sv

// 인터페이스: DataPath & ControlUnit의 신호 연결
interface dp_intf;
    logic clk;
    logic reset;
    logic ASrcMuxSel;
    logic AEn;
    logic ALt10;
    logic OutBuf;
    logic [7:0] outPort;
endinterface

// Transaction 클래스: DUT 출력(출력 버퍼 활성 시 outPort 값)을 캡처
class dp_transaction;
    int cycle;              // 캡처된 클럭 사이클 번호
    int unsigned out_value; // 캡처된 outPort 값

    function new(int cycle, int unsigned out_value);
        this.cycle = cycle;
        this.out_value = out_value;
    endfunction
endclass

// Driver 클래스: 인터페이스를 모니터링하여 OutBuf가 1일 때 transaction 생성
class driver;
    virtual dp_intf dp_if;
    mailbox#(dp_transaction) drv2env_mbox;

    function new(mailbox#(dp_transaction) mbox, virtual dp_intf dp_if);
        this.drv2env_mbox = mbox;
        this.dp_if = dp_if;
    endfunction

    task run();
        int cycle_count = 0;
        forever begin
            @(posedge dp_if.clk);
            cycle_count++;
            // OutBuf가 활성화된 클럭 사이클이면 outPort 값을 캡처
            if (dp_if.OutBuf) begin
                dp_transaction trans = new(cycle_count, dp_if.outPort);
                drv2env_mbox.put(trans);
            end
        end
    endtask
endclass

// Environment 클래스: driver 인스턴스 생성 및 transaction 수집/출력
class environment;
    driver drv;
    mailbox#(dp_transaction) drv2env_mbox;

    function new(virtual dp_intf dp_if);
        drv2env_mbox = new();
        drv = new(drv2env_mbox, dp_if);
    endfunction

    task run();
        fork
            drv.run();
            // driver로부터 transaction을 받아 출력함
            forever begin
                dp_transaction trans;
                drv2env_mbox.get(trans);
                $display("Cycle: %0d, outPort = %0d", trans.cycle, trans.out_value);
            end
        join_none
    endtask
endclass

// 테스트벤치 최상위 모듈: DUT과 환경 연결, 클럭/리셋 생성
module tb_0to9();
    environment env;    // Environment 인스턴스
    dp_intf dp_if();    // 인터페이스 인스턴스 생성

    // DataPath와 ControlUnit 인스턴스화 (각 모듈은 별도 파일에 정의되어 있어야 함)
    DataPath datapath (
        .clk(dp_if.clk),
        .reset(dp_if.reset),
        .ASrcMuxSel(dp_if.ASrcMuxSel),
        .AEn(dp_if.AEn),
        .ALt10(dp_if.ALt10),
        .OutBuf(dp_if.OutBuf),
        .outPort(dp_if.outPort)
    );

    ControlUnit controlunit (
        .clk(dp_if.clk),
        .reset(dp_if.reset),
        .ASrcMuxSel(dp_if.ASrcMuxSel),
        .AEn(dp_if.AEn),
        .ALt10(dp_if.ALt10),
        .OutBuf(dp_if.OutBuf)
    );

    // 클럭 생성 (주기: 10ns)
    initial begin
        dp_if.clk = 0;
        forever #5 dp_if.clk = ~dp_if.clk;
    end

    // 리셋 생성: 20ns 동안 reset 후 해제
    initial begin
        dp_if.reset = 1;
        #20 dp_if.reset = 0;
    end

    // 환경 동작 시작
    initial begin
        env = new(dp_if);
        env.run();
    end

    // 시뮬레이션 종료 (예: 300ns 후)
    initial begin
        #300;
        $finish;
    end
endmodule

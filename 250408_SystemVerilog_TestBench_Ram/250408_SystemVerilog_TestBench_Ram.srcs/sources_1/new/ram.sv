`timescale 1ns / 1ps
// ram.sv
module ram(
    // 포트 선언을 인터페이스를 이용
    ram_intf intf
);
    logic [7:0] mem[0:2**5-1]; // 2**5 = 2의 5승

    initial begin
        foreach (mem[i]) mem[i] = 0;
    end
    
    // we = writeEn
    always_ff @( posedge intf.clk ) begin
        if (intf.we) mem[intf.addr] <= intf.wData;
    end

    assign intf.rData = mem[intf.addr];
endmodule

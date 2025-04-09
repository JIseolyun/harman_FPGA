//tb_alu.v
`timescale 1ns / 1ps

module tb_alu ();
    reg [3:0] a, b;
    reg  [1:0] op;
    wire [3:0] result;

    alu dut (
        .a(a),
        .b(b),
        .op(op),
        .result(result)
    );

    task test_alu;
        input [3:0] test_a;
        input [3:0] test_b;
        input [1:0] test_op;
        input [3:0] expected;

        begin
            a  = test_a;
            b  = test_b;
            op = test_op;

            #10;

            if (result === expected) begin
                $display("PASS: a=%h, b=%h, op=%b -> result=%h", test_a,
                         test_b, test_op, result);
            end else begin
                $display("FAIL: a=%h, b=%h, op=%b -> result=%h (expected %h)",
                         test_a, test_b, test_op, result, expected);
            end
        end
    endtask

    initial begin
        $display("Starting ALU Test...");
        $monitor("Time=%0t | a=%h | b=%h | op=%b | result=%h", $time, a, b, op,
                 result);
        test_alu(4'h3, 4'h5, 2'b00, 4'h8);
        test_alu(4'h7, 4'h2, 2'b01, 4'h5);
        test_alu(4'hF, 4'hA, 2'b10, 4'hA);
        test_alu(4'hC, 4'h3, 2'b11, 4'hF);
        $display("ALU Test Completed.");
        $finish;
    end
endmodule

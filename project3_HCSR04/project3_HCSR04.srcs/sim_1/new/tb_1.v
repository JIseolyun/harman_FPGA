`timescale 1ns / 1ps

module tb_us_controller();
    //input -> reg
    //output -> wire
    reg clk;
    reg rst;
    reg start;
    reg echo;
    wire trigger;
    wire [31:0] echo_time_count;
    wire done;
    

    us_controller DUT (
        .clk(clk),
        .rst(rst),
        .start(start),
        .echo(echo),
        .trigger(trigger),
        .echo_time_count(echo_time_count),
        .done(done)
    );
    initial clk = 0;
    always #10 clk = ~clk;

    //초기 시나리오
    initial begin
        rst = 0;
        start = 0;
        echo = 0;
        #100;
        rst = 1;

        #200;
        start = 1;
        #100;
        start = 0;
        
        #2000;
        echo = 1; 
        
        #3000;
        echo = 0; 

        #1000;
        $stop;
    end


endmodule

`timescale 1ns/1ps

module tb_testeoA;

    reg clk = 0;
    wire led_data;

    ws2812_fastled uut (
        .clk(clk),
        .led_data(led_data)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("Letra_A.vcd");
        $dumpvars(0, tb_testeoA);

        #9000000;

        $finish;
    end

endmodule
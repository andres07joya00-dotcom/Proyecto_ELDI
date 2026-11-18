`timescale 1ns/1ps

module tb_ws2812_fastled;

    reg clk = 0;
    wire led_data;

    ws2812_fastled uut (
        .clk(clk),
        .led_data(led_data)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("ws2812_fastled.vcd");
        $dumpvars(0, tb_ws2812_fastled);

        #9000000;

        $finish;
    end

endmodule
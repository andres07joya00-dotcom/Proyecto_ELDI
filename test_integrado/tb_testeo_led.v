`timescale 1ns / 1ps

module tb_test_74HCT245;

    reg clk;
    wire TEST_OUT;

    test_74HCT245 #(
        .MAX_COUNT(4) 
    ) uut (
        .clk(clk),
        .TEST_OUT(TEST_OUT)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
      
        $dumpfile("simulacion.vcd");
        $dumpvars(0, tb_test_74HCT245);

        #200;
        $finish;
    end

endmodule
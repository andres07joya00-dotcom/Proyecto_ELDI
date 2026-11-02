`timescale 1ns / 1ps

module tb_ws2812b;

    reg clk;
    wire TEST_OUT;

    // Instanciamos el controlador
    ws2812b_matrix uut (
        .clk(clk),
        .TEST_OUT(TEST_OUT)
    );

    // Generador de reloj a 100 MHz (Periodo = 10 ns)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("simulacion_ws2812b.vcd");
        $dumpvars(0, tb_ws2812b);

        // Simulamos el tiempo suficiente para ver la transmisión del primer píxel (24 bits)
        #60000;
        $finish;
    end

endmodule
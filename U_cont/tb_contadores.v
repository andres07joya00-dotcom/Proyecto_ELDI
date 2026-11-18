`timescale 1ns/1ps

module tb_contadores;

    reg CLK    = 1'b0;
    reg Estado = 1'b0;

    wire [14:0] Contador_reinicio;
    wire [6:0]  Contador_tiempo_bit;
    wire [4:0]  Indice_bit;
    wire [7:0]  Indice_pixel;

    wire Bandera_fin_reinicio;
    wire Bandera_fin_bit;
    wire Bandera_fin_pixel;
    wire Bandera_fin_Cuadro;
    wire Bandera_fin_columna;

    contadores dut (
        .CLK                  (CLK),
        .Estado               (Estado),
        .Contador_reinicio    (Contador_reinicio),
        .Contador_tiempo_bit  (Contador_tiempo_bit),
        .Indice_bit           (Indice_bit),
        .Indice_pixel         (Indice_pixel),
        .Bandera_fin_reinicio (Bandera_fin_reinicio),
        .Bandera_fin_bit      (Bandera_fin_bit),
        .Bandera_fin_pixel    (Bandera_fin_pixel),
        .Bandera_fin_Cuadro   (Bandera_fin_Cuadro),
        .Bandera_fin_columna  (Bandera_fin_columna)
    );

    // Reloj de 100 MHz
    always #5 CLK = ~CLK;

    initial begin
        $dumpfile("contadores.vcd");
        $dumpvars(1, tb_contadores);

        // Prueba 1: Reinicio completo de 280 us.
        Estado = 1'b0;
        repeat (28000) @(negedge CLK);

        // Prueba 2: Enviar un cuadro completo de 256 píxeles.
        Estado = 1'b1;
        repeat (256 * 24 * 125) @(negedge CLK);

        // Prueba 3: Avanzar 10 bits del siguiente píxel e interrumpirlo.
        repeat (10 * 125) @(negedge CLK);
        Estado = 1'b0;
        repeat (28000) @(negedge CLK);

        // Prueba 4: Volver a envío y avanzar un píxel más.
        Estado = 1'b1;
        repeat (24 * 125) @(negedge CLK);

        $finish;
    end

endmodule
`timescale 1ns/1ps

module tb_contadores;

    parameter integer PRUEBA = 0;

    reg CLK    = 1'b0;
    reg Estado = 1'b0;

    wire [14:0] Contador_reinicio;
    wire [6:0]  Contador_tiempo_bit;
    wire [4:0]  Indice_bit;
    wire [7:0]  Indice_pixel;

    wire Bandera_fin_reinicio;
    wire Bandera_fin_bit;
    wire Bandera_fin_pixel;
    wire Bandera_fin_columna;
    wire Bandera_fin_Cuadro;

    integer Inicio;
    integer Fin;

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
        .Bandera_fin_columna  (Bandera_fin_columna),
        .Bandera_fin_Cuadro   (Bandera_fin_Cuadro)
    );

    // Reloj de 100 MHz.
    always #5 CLK = ~CLK;

    // Estímulos.
    initial begin

        // Reinicio completo.
        repeat (28000) @(negedge CLK);
        Estado = 1'b1;

        // Prueba independiente de interrupción.
        if (PRUEBA == 6) begin

            // Diez bits completos y 37 ciclos del siguiente bit.
            repeat (1287) @(negedge CLK);
            Estado = 1'b0;

            // Reinicio parcial de cinco ciclos.
            repeat (5) @(negedge CLK);
            Estado = 1'b1;

        end

    end

    // Selección de la ventana de ondas.
    initial begin

        case (PRUEBA)

            0: begin
                Inicio = 0;
                Fin    = 7960040;
                $dumpfile("U_cont_0_completo.vcd");
            end

            1: begin
                Inicio = 279960;
                Fin    = 280040;
                $dumpfile("U_cont_1_reinicio.vcd");
            end

            2: begin
                Inicio = 281210;
                Fin    = 281270;
                $dumpfile("U_cont_2_bit.vcd");
            end

            3: begin
                Inicio = 309960;
                Fin    = 310030;
                $dumpfile("U_cont_3_pixel.vcd");
            end

            4: begin
                Inicio = 519960;
                Fin    = 520030;
                $dumpfile("U_cont_4_columna.vcd");
            end

            5: begin
                Inicio = 7959960;
                Fin    = 7960040;
                $dumpfile("U_cont_5_cuadro.vcd");
            end

            6: begin
                Inicio = 292830;
                Fin    = 292970;
                $dumpfile("U_cont_6_interrupcion.vcd");
            end

            default: begin
                $display("PRUEBA debe estar entre 0 y 6");
                $finish;
            end

        endcase

        #(Inicio);
        $dumpvars(0, dut);

        #(Fin - Inicio);
        $finish;

    end

endmodule
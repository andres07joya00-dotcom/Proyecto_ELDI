`timescale 1ns/1ps

module tb_desplazamiento;

    parameter integer PRUEBA = 0;

    reg CLK = 1'b0;
    reg Estado = 1'b0;

    reg Bandera_fin_Cuadro  = 1'b0;
    reg Bandera_fin_columna = 1'b0;

    reg [23:0] FRASE = {
        6'd7,
        6'd14,
        6'd11,
        6'd0
    };

    wire [5:0] Codigo_caracter;
    wire [2:0] Bit_glifo;
    wire En_Glifo;

    integer i;
    integer j;
    integer Inicio;
    integer Fin;

    desplazamiento #(
        .N_CHARS(4),
        .Cuadros_por_paso(3)
    ) dut (
        .CLK                 (CLK),
        .Estado              (Estado),
        .Bandera_fin_Cuadro   (Bandera_fin_Cuadro),
        .Bandera_fin_columna  (Bandera_fin_columna),
        .FRASE               (FRASE),
        .Codigo_caracter     (Codigo_caracter),
        .Bit_glifo           (Bit_glifo),
        .En_Glifo            (En_Glifo)
    );

    always #5 CLK = ~CLK;

    task pulso_columna;
        begin
            @(negedge CLK);
            Bandera_fin_columna = 1'b1;

            @(negedge CLK);
            Bandera_fin_columna = 1'b0;
        end
    endtask

    task pulso_cuadro;
        begin
            @(negedge CLK);
            Bandera_fin_Cuadro = 1'b1;

            @(negedge CLK);
            Bandera_fin_Cuadro = 1'b0;
        end
    endtask

    // Estímulos del recorrido completo.
    initial begin

        repeat (3) @(negedge CLK);

        for (i = 0; i < 216; i = i + 1) begin

            // Cargar la posición inicial del cuadro.
            Estado = 1'b0;
            repeat (2) @(negedge CLK);

            // Recorrer las 32 columnas.
            Estado = 1'b1;

            for (j = 0; j < 32; j = j + 1)
                pulso_columna();

            // Señalar el final del cuadro.
            Estado = 1'b0;
            pulso_cuadro();

        end

    end

    // Selección de la ventana de ondas.
    initial begin

        case (PRUEBA)

            0: begin
                Inicio = 0;
                Fin    = 146950;
                $dumpfile("U_scroll_0_completo.vcd");
            end

            1: begin
                Inicio = 650;
                Fin    = 2110;
                $dumpfile("U_scroll_1_tres_cuadros.vcd");
            end

            2: begin
                Inicio = 73480;
                Fin    = 74160;
                $dumpfile("U_scroll_2_HOLA.vcd");
            end

            3: begin
                Inicio = 146240;
                Fin    = 146950;
                $dumpfile("U_scroll_3_retorno.vcd");
            end

            default: begin
                $display("PRUEBA debe estar entre 0 y 3");
                $finish;
            end

        endcase

        #(Inicio);
        $dumpvars(0, dut);

        #(Fin - Inicio);
        $finish;

    end

endmodule
`timescale 1ns/1ps

module tb_mapeo_matriz;

    parameter integer PRUEBA = 0;

    reg  [7:0] Indice_pixel;
    wire [4:0] Columna;
    wire [2:0] Fila;

    integer i;
    integer Inicio;
    integer Fin;

    mapeo_matriz dut (
        .Indice_pixel (Indice_pixel),
        .Columna      (Columna),
        .Fila         (Fila)
    );

    initial begin

        case (PRUEBA)

            0: begin
                Inicio = 0;
                Fin    = 255;
                $dumpfile("U_map_0_completo.vcd");
            end

            1: begin
                Inicio = 0;
                Fin    = 15;
                $dumpfile("U_map_1_par_impar.vcd");
            end

            2: begin
                Inicio = 6;
                Fin    = 17;
                $dumpfile("U_map_2_transiciones.vcd");
            end

            3: begin
                Inicio = 240;
                Fin    = 255;
                $dumpfile("U_map_3_final.vcd");
            end

            default: begin
                $display("Selecciona una PRUEBA entre 0 y 3.");
                $finish;
            end

        endcase

        // Incluye las entradas, las salidas y Fila_directa del módulo.
        $dumpvars(0, dut);

        for (i = Inicio; i <= Fin; i = i + 1) begin
            Indice_pixel = i[7:0];
            #10;
        end

        $finish;
    end

endmodule
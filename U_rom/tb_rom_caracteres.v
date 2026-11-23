`timescale 1ns/1ps

module tb_rom_caracteres;

    parameter integer PRUEBA = 0;

    reg  [5:0] caracter;
    reg  [2:0] fila;
    wire [7:0] pixeles;

    integer c;
    integer Inicio;
    integer Fin;

    rom_caracteres dut (
        .caracter (caracter),
        .fila     (fila),
        .pixeles  (pixeles)
    );

    task mostrar_caracter;

        input [5:0] codigo;
        integer f;

        begin

            caracter = codigo;

            for (f = 0; f < 8; f = f + 1) begin
                fila = f[2:0];
                #10;
            end

        end

    endtask

    initial begin

        case (PRUEBA)

            0: begin
                Inicio = 0;
                Fin    = 63;
                $dumpfile("U_rom_0_completo.vcd");
            end

            1: begin
                Inicio = 0;
                Fin    = 0;
                $dumpfile("U_rom_1_A.vcd");
            end

            2: begin
                Inicio = 0;
                Fin    = 0;
                $dumpfile("U_rom_2_HOLA.vcd");
            end

            3: begin
                Inicio = 26;
                Fin    = 31;
                $dumpfile("U_rom_3_signos.vcd");
            end

            4: begin
                Inicio = 32;
                Fin    = 41;
                $dumpfile("U_rom_4_digitos.vcd");
            end

            5: begin
                Inicio = 42;
                Fin    = 49;
                $dumpfile("U_rom_5_emojis.vcd");
            end

            6: begin
                Inicio = 50;
                Fin    = 63;
                $dumpfile("U_rom_6_no_definidos.vcd");
            end

            default: begin
                $display("PRUEBA debe estar entre 0 y 6");
                $finish;
            end

        endcase

        $dumpvars(0, dut);

        if (PRUEBA == 2) begin

            mostrar_caracter(6'd7);   // H
            mostrar_caracter(6'd14);  // O
            mostrar_caracter(6'd11);  // L
            mostrar_caracter(6'd0);   // A

        end else begin

            for (c = Inicio; c <= Fin; c = c + 1)
                mostrar_caracter(c[5:0]);

        end

        $finish;

    end

endmodule
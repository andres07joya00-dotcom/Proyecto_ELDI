`timescale 1ns/1ps

module tb_rom_caracteres;

    reg  [4:0] caracter;
    reg  [2:0] fila;
    wire [7:0] pixeles;

    integer c;
    integer f;

    // Instancia del circuito bajo prueba
    rom_caracteres dut (
        .caracter(caracter),
        .fila(fila),
        .pixeles(pixeles)
    );

    initial begin

        // Crear archivo para GTKWave
        $dumpfile("ondas.vcd");
        $dumpvars(0, tb_rom_caracteres);


        caracter = 5'd0;
        fila     = 3'd0;

        // Esperar el inicio de la simulacion
        #10;

        // Recorrer los caracteres A-Z
        for (c = 0; c < 26; c = c + 1) begin

            caracter = c;

            $display("");
            $display("Caracter codigo decimal = %0d", c);

            // Recorrer las ocho filas de cada caracter
            for (f = 0; f < 8; f = f + 1) begin

                fila = f;

                // Esperar estabilizacion de la logica combinacional
                #10;

                $display(
                    "Fila %0d: %08b",
                    f,
                    pixeles
                );

            end
        end

        // Probar el espacio
        caracter = 5'd26;
        fila = 3'd0;
        #10;

        $display("");
        $display("Espacio, codigo 26: %08b", pixeles);

        // Probar un codigo no implementado
        caracter = 5'd27;
        fila = 3'd0;
        #10;

        if (pixeles !== 8'b00000000) begin
            $display("ERROR: codigo invalido no produce cero");
            $fatal(1);
        end else begin
            $display("OK: codigo invalido produce cero");
        end


        $finish;

    end

endmodule


`timescale 1ns/1ps

module tb_uart_frase;

    parameter integer PRUEBA = 0;

    localparam integer CPB = 868;

    reg CLK = 1'b0;
    reg Estado = 1'b0;
    reg UART_RX = 1'b1;

    wire [23:0] Frase;

    integer Fin;

    uart_frase #(
        .N_CHARS(4),
        .FRASE_INICIAL({6'd7, 6'd14, 6'd11, 6'd0})
    ) dut (
        .CLK     (CLK),
        .Estado  (Estado),
        .UART_RX (UART_RX),
        .Frase   (Frase)
    );

    always #5 CLK = ~CLK;

    task enviar_byte;

        input [7:0] valor;
        integer b;

        begin

            UART_RX = 1'b0;
            repeat (CPB) @(negedge CLK);

            for (b = 0; b < 8; b = b + 1) begin
                UART_RX = valor[b];
                repeat (CPB) @(negedge CLK);
            end

            UART_RX = 1'b1;
            repeat (2 * CPB) @(negedge CLK);

        end

    endtask

    initial begin

        repeat (2) @(negedge CLK);

        case (PRUEBA)

            0: begin
                enviar_byte(8'h68);  // h

                Estado = 1'b1;
                enviar_byte(8'h39);  // 9
                enviar_byte(8'h40);  // @

                Estado = 1'b0;
                enviar_byte(8'h08);  // Backspace
                enviar_byte(8'h23);  // #
            end

            1: begin
                enviar_byte(8'h41);  // A
                enviar_byte(8'h5A);  // Z
                enviar_byte(8'h61);  // a
                enviar_byte(8'h7A);  // z
            end

            2: begin
                enviar_byte(8'h30);  // 0
                enviar_byte(8'h39);  // 9
            end

            3: begin
                enviar_byte(8'h20);  // Espacio
                enviar_byte(8'h2D);  // -
                enviar_byte(8'h2E);  // .
                enviar_byte(8'h21);  // !
                enviar_byte(8'h3F);  // ?
                enviar_byte(8'h3A);  // :
            end

            4: begin
                enviar_byte(8'h40);  // Corazón
                enviar_byte(8'h28);  // Carita feliz
                enviar_byte(8'h29);  // Carita triste
                enviar_byte(8'h2A);  // Estrella
                enviar_byte(8'h7E);  // Nota musical
                enviar_byte(8'h3E);  // Flecha derecha
                enviar_byte(8'h3C);  // Flecha izquierda
                enviar_byte(8'h2B);  // Sol
            end

            5: begin
                enviar_byte(8'h08);  // Backspace
                enviar_byte(8'h7F);  // Delete
                enviar_byte(8'h23);  // #
            end

        endcase

    end

    initial begin

        case (PRUEBA)

            0: begin
                Fin = 477520;
                $dumpfile("U_frase_0_edicion.vcd");
            end

            1: begin
                Fin = 382040;
                $dumpfile("U_frase_1_letras.vcd");
            end

            2: begin
                Fin = 191080;
                $dumpfile("U_frase_2_digitos.vcd");
            end

            3: begin
                Fin = 573000;
                $dumpfile("U_frase_3_signos.vcd");
            end

            4: begin
                Fin = 763960;
                $dumpfile("U_frase_4_emojis.vcd");
            end

            5: begin
                Fin = 286560;
                $dumpfile("U_frase_5_borrado.vcd");
            end

            default: begin
                $display("PRUEBA debe estar entre 0 y 5");
                $finish;
            end

        endcase

        $dumpvars(0, dut);

        #(Fin);
        $finish;

    end

endmodule
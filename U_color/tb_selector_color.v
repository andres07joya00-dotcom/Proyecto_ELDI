`timescale 1ns/1ps

module tb_selector_color;

    parameter integer PRUEBA = 0;

    reg CLK = 1'b0;
    reg Estado = 1'b0;
    reg [2:0] Interruptores = 3'd0;

    wire [23:0] Color;

    integer i;
    integer Inicio;
    integer Fin;

    selector_color #(
        .Brillo(8'h40)
    ) dut (
        .CLK           (CLK),
        .Estado        (Estado),
        .Interruptores (Interruptores),
        .Color         (Color)
    );

    always #5 CLK = ~CLK;

    initial begin

        case (PRUEBA)

            0: begin
                #20;

                for (i = 0; i < 8; i = i + 1) begin
                    Interruptores = i[2:0];
                    #40;
                end
            end

            1: begin
                #20;
                Interruptores = 3'd1;
            end

            2: begin
                #20;
                Estado = 1'b1;

                #10;
                Interruptores = 3'd1;

                #40;
                Estado = 1'b0;
            end

        endcase

    end

    initial begin

        case (PRUEBA)

            0: begin
                Inicio = 0;
                Fin = 360;
                $dumpfile("U_color_0_colores.vcd");
            end

            1: begin
                Inicio = 10;
                Fin = 70;
                $dumpfile("U_color_1_sincronizacion.vcd");
            end

            2: begin
                Inicio = 10;
                Fin = 100;
                $dumpfile("U_color_2_retencion.vcd");
            end

            default: begin
                $display("PRUEBA debe estar entre 0 y 2");
                $finish;
            end

        endcase

        #(Inicio);
        $dumpvars(0, dut);

        #(Fin - Inicio);
        $finish;

    end

endmodule
`timescale 1ns/1ps

module tb_uart_rx;

    parameter integer PRUEBA = 0;

    localparam integer CPB = 868;

    reg CLK = 1'b0;
    reg RX = 1'b1;

    wire [7:0] Dato;
    wire Dato_valido;

    integer Fin;

    uart_rx #(
        .Clks_por_bit(CPB)
    ) dut (
        .CLK         (CLK),
        .RX          (RX),
        .Dato        (Dato),
        .Dato_valido (Dato_valido)
    );

    always #5 CLK = ~CLK;

    task enviar_byte;

        input [7:0] valor;
        integer b;

        begin

            // Bit de inicio.
            RX = 1'b0;
            repeat (CPB) @(negedge CLK);

            // Ocho bits, LSB primero.
            for (b = 0; b < 8; b = b + 1) begin
                RX = valor[b];
                repeat (CPB) @(negedge CLK);
            end

            // Parada y un bit adicional de reposo.
            RX = 1'b1;
            repeat (2 * CPB) @(negedge CLK);

        end

    endtask

    initial begin

        repeat (2) @(negedge CLK);

        case (PRUEBA)

            0: begin
                enviar_byte(8'hA5);
            end

            1: begin
                // Pulso breve que termina antes de medio bit.
                RX = 1'b0;
                repeat (10) @(negedge CLK);

                RX = 1'b1;
                repeat (500) @(negedge CLK);

                enviar_byte(8'h3C);
            end

            2: begin
                enviar_byte(8'h3C);
                enviar_byte(8'hC3);
            end

        endcase

    end

    initial begin

        case (PRUEBA)

            0: begin
                Fin = 96000;
                $dumpfile("U_rx_0_byte_A5.vcd");
            end

            1: begin
                Fin = 101000;
                $dumpfile("U_rx_1_inicio_corto.vcd");
            end

            2: begin
                Fin = 192000;
                $dumpfile("U_rx_2_dos_bytes.vcd");
            end

            default: begin
                $display("PRUEBA debe estar entre 0 y 2");
                $finish;
            end

        endcase

        $dumpvars(0, dut);

        #(Fin);
        $finish;

    end

endmodule
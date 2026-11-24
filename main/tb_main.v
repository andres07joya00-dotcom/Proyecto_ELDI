`timescale 1ns/1ps

module tb_main;

    parameter integer PRUEBA = 0;

    localparam integer CPB = 868;

    reg CLK = 1'b0;
    reg [2:0] Interruptores = 3'd0;
    reg UART_RX = 1'b1;

    wire Datos_LED;

    integer Inicio;
    integer Fin;

    main dut (
        .CLK           (CLK),
        .Interruptores (Interruptores),
        .UART_RX       (UART_RX),
        .Datos_LED     (Datos_LED)
    );

    // Ajuste exclusivo de esta simulación.
    defparam dut.u_scroll.Cuadros_por_paso = 1;

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

        if (PRUEBA == 5) begin

            repeat (2) @(negedge CLK);

            enviar_byte(8'h68);  // h
            enviar_byte(8'h39);  // 9
            enviar_byte(8'h40);  // @
            enviar_byte(8'h08);  // Backspace
            enviar_byte(8'h23);  // #

        end

    end

    initial begin

        case (PRUEBA)

            0: begin
                Inicio = 0;
                Fin = 8240100;
                $dumpfile("Main_0_cuadro.vcd");
            end

            1: begin
                Inicio = 279960;
                Fin = 280070;
                $dumpfile("Main_1_inicio.vcd");
            end

            2: begin
                Inicio = 280000;
                Fin = 282600;
                $dumpfile("Main_2_bit_cero.vcd");
            end

            3: begin
                Inicio = 47519950;
                Fin = 47522800;
                $dumpfile("Main_3_bit_uno.vcd");
            end

            4: begin
                Inicio = 7959950;
                Fin = 7960060;
                $dumpfile("Main_4_fin_cuadro.vcd");
            end

            5: begin
                Inicio = 0;
                Fin = 477520;
                $dumpfile("Main_5_UART.vcd");
            end

            default: begin
                $display("PRUEBA debe estar entre 0 y 5");
                $finish;
            end

        endcase

        #(Inicio);
        $dumpvars(0, dut);

        #(Fin - Inicio);
        $finish;

    end

endmodule
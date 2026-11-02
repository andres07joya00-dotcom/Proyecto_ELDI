module ws2812b_matrix (
    input wire clk,          // Reloj de 100 MHz de la Nexys A7
    output reg TEST_OUT = 0  // Salida hacia A1 del 74HCT245
);

    // Estados de la máquina de estados
    localparam STATE_IDLE  = 2'd0,
               STATE_BIT   = 2'd1,
               STATE_RESET = 2'd2;

    reg [1:0] state = STATE_IDLE;
    reg [6:0] counter = 0;       // Contador para los tiempos del bit (0 a 124 ciclos)
    reg [12:0] reset_cnt = 0;    // Contador para el tiempo de Reset (0 a 5000 ciclos)
    
    reg [7:0] pixel_index = 0;   // 0 a 255 píxeles
    reg [4:0] bit_index = 23;    // Bit 23 a 0 dentro de cada píxel
    reg [23:0] current_color;

    always @(posedge clk) begin
        case (state)
            STATE_IDLE: begin
                pixel_index <= 0;
                bit_index   <= 23;
                counter     <= 0;
                state       <= STATE_BIT;
            end

            STATE_BIT: begin
                // Carga de color: Píxel 0 en Blanco (Verde=FF, Rojo=FF, Azul=FF), resto apagado (000000)
                current_color = (pixel_index == 8'd0) ? 24'hFFFFFF : 24'h000000;

                // Generación de onda según el bit a transmitir
                if (current_color[bit_index] == 1'b1) begin
                    // Bit 1: 80 ciclos ALTO (0.8 us), restantes BAJO (0.45 us)
                    TEST_OUT <= (counter < 80) ? 1'b1 : 1'b0;
                end else begin
                    // Bit 0: 40 ciclos ALTO (0.4 us), restantes BAJO (0.85 us)
                    TEST_OUT <= (counter < 40) ? 1'b1 : 1'b0;
                end

                // Avance de contador de tiempo por bit (125 ciclos = 1.25 us)
                if (counter == 124) begin
                    counter <= 0;
                    if (bit_index == 0) begin
                        bit_index <= 23;
                        if (pixel_index == 255) begin
                            pixel_index <= 0;
                            reset_cnt   <= 0;
                            state       <= STATE_RESET; // Termina envío de los 256 píxeles
                        end else begin
                            pixel_index <= pixel_index + 1'b1;
                        end
                    end else begin
                        bit_index <= bit_index - 1'b1;
                    end
                end else begin
                    counter <= counter + 1'b1;
                end
            end

            STATE_RESET: begin
                TEST_OUT <= 1'b0; // Mantener la línea en BAJO
                if (reset_cnt == 5000) begin // 50 us transcurridos
                    reset_cnt <= 0;
                    state     <= STATE_BIT;  // Vuelve a iniciar ráfaga de datos
                end else begin
                    reset_cnt <= reset_cnt + 1'b1;
                end
            end
        endcase
    end

endmodule
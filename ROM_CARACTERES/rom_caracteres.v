`timescale 1ns/1ps

module rom_caracteres (
    input  wire [4:0] caracter,
    input  wire [2:0] fila,
    output reg  [7:0] pixeles
);

    always @(*) begin

        // Estado predeterminado
        pixeles = 8'b00000000;

        case (caracter)

            // A
            5'd0: begin
                case (fila)
                    3'd0: pixeles = 8'b00111100;
                    3'd1: pixeles = 8'b01100110;
                    3'd2: pixeles = 8'b11000011;
                    3'd3: pixeles = 8'b11000011;
                    3'd4: pixeles = 8'b11111111;
                    3'd5: pixeles = 8'b11000011;
                    3'd6: pixeles = 8'b11000011;
                    3'd7: pixeles = 8'b11000011;
                endcase
            end

            // B
            5'd1: begin
                case (fila)
                    3'd0: pixeles = 8'b11111100;
                    3'd1: pixeles = 8'b11000110;
                    3'd2: pixeles = 8'b11000110;
                    3'd3: pixeles = 8'b11111100;
                    3'd4: pixeles = 8'b11000110;
                    3'd5: pixeles = 8'b11000110;
                    3'd6: pixeles = 8'b11000110;
                    3'd7: pixeles = 8'b11111100;
                endcase
            end

            // C
            5'd2: begin
                case (fila)
                    3'd0: pixeles = 8'b00111110;
                    3'd1: pixeles = 8'b01100000;
                    3'd2: pixeles = 8'b11000000;
                    3'd3: pixeles = 8'b11000000;
                    3'd4: pixeles = 8'b11000000;
                    3'd5: pixeles = 8'b11000000;
                    3'd6: pixeles = 8'b01100000;
                    3'd7: pixeles = 8'b00111110;
                endcase
            end

            // D
            5'd3: begin
                case (fila)
                    3'd0: pixeles = 8'b11111000;
                    3'd1: pixeles = 8'b11001100;
                    3'd2: pixeles = 8'b11000110;
                    3'd3: pixeles = 8'b11000110;
                    3'd4: pixeles = 8'b11000110;
                    3'd5: pixeles = 8'b11000110;
                    3'd6: pixeles = 8'b11001100;
                    3'd7: pixeles = 8'b11111000;
                endcase
            end

            // E
            5'd4: begin
                case (fila)
                    3'd0: pixeles = 8'b11111111;
                    3'd1: pixeles = 8'b11000000;
                    3'd2: pixeles = 8'b11000000;
                    3'd3: pixeles = 8'b11111100;
                    3'd4: pixeles = 8'b11000000;
                    3'd5: pixeles = 8'b11000000;
                    3'd6: pixeles = 8'b11000000;
                    3'd7: pixeles = 8'b11111111;
                endcase
            end

            // F
            5'd5: begin
                case (fila)
                    3'd0: pixeles = 8'b11111111;
                    3'd1: pixeles = 8'b11000000;
                    3'd2: pixeles = 8'b11000000;
                    3'd3: pixeles = 8'b11111100;
                    3'd4: pixeles = 8'b11000000;
                    3'd5: pixeles = 8'b11000000;
                    3'd6: pixeles = 8'b11000000;
                    3'd7: pixeles = 8'b11000000;
                endcase
            end

            // G
            5'd6: begin
                case (fila)
                    3'd0: pixeles = 8'b00111110;
                    3'd1: pixeles = 8'b01100000;
                    3'd2: pixeles = 8'b11000000;
                    3'd3: pixeles = 8'b11001111;
                    3'd4: pixeles = 8'b11000110;
                    3'd5: pixeles = 8'b11000110;
                    3'd6: pixeles = 8'b01100110;
                    3'd7: pixeles = 8'b00111110;
                endcase
            end

            // H
            5'd7: begin
                case (fila)
                    3'd0: pixeles = 8'b11000011;
                    3'd1: pixeles = 8'b11000011;
                    3'd2: pixeles = 8'b11000011;
                    3'd3: pixeles = 8'b11111111;
                    3'd4: pixeles = 8'b11111111;
                    3'd5: pixeles = 8'b11000011;
                    3'd6: pixeles = 8'b11000011;
                    3'd7: pixeles = 8'b11000011;
                endcase
            end

            // I
            5'd8: begin
                case (fila)
                    3'd0: pixeles = 8'b01111110;
                    3'd1: pixeles = 8'b00011000;
                    3'd2: pixeles = 8'b00011000;
                    3'd3: pixeles = 8'b00011000;
                    3'd4: pixeles = 8'b00011000;
                    3'd5: pixeles = 8'b00011000;
                    3'd6: pixeles = 8'b00011000;
                    3'd7: pixeles = 8'b01111110;
                endcase
            end

            // J
            5'd9: begin
                case (fila)
                    3'd0: pixeles = 8'b00011111;
                    3'd1: pixeles = 8'b00000110;
                    3'd2: pixeles = 8'b00000110;
                    3'd3: pixeles = 8'b00000110;
                    3'd4: pixeles = 8'b11000110;
                    3'd5: pixeles = 8'b11000110;
                    3'd6: pixeles = 8'b01101100;
                    3'd7: pixeles = 8'b00111000;
                endcase
            end

            // K
            5'd10: begin
                case (fila)
                    3'd0: pixeles = 8'b11000110;
                    3'd1: pixeles = 8'b11001100;
                    3'd2: pixeles = 8'b11011000;
                    3'd3: pixeles = 8'b11110000;
                    3'd4: pixeles = 8'b11110000;
                    3'd5: pixeles = 8'b11011000;
                    3'd6: pixeles = 8'b11001100;
                    3'd7: pixeles = 8'b11000110;
                endcase
            end

            // L
            5'd11: begin
                case (fila)
                    3'd0: pixeles = 8'b11000000;
                    3'd1: pixeles = 8'b11000000;
                    3'd2: pixeles = 8'b11000000;
                    3'd3: pixeles = 8'b11000000;
                    3'd4: pixeles = 8'b11000000;
                    3'd5: pixeles = 8'b11000000;
                    3'd6: pixeles = 8'b11000000;
                    3'd7: pixeles = 8'b11111111;
                endcase
            end

            // M
            5'd12: begin
                case (fila)
                    3'd0: pixeles = 8'b11000011;
                    3'd1: pixeles = 8'b11100111;
                    3'd2: pixeles = 8'b11111111;
                    3'd3: pixeles = 8'b11011011;
                    3'd4: pixeles = 8'b11000011;
                    3'd5: pixeles = 8'b11000011;
                    3'd6: pixeles = 8'b11000011;
                    3'd7: pixeles = 8'b11000011;
                endcase
            end

            // N
            5'd13: begin
                case (fila)
                    3'd0: pixeles = 8'b11000011;
                    3'd1: pixeles = 8'b11100011;
                    3'd2: pixeles = 8'b11110011;
                    3'd3: pixeles = 8'b11011011;
                    3'd4: pixeles = 8'b11001111;
                    3'd5: pixeles = 8'b11000111;
                    3'd6: pixeles = 8'b11000011;
                    3'd7: pixeles = 8'b11000011;
                endcase
            end

            // O
            5'd14: begin
                case (fila)
                    3'd0: pixeles = 8'b00111100;
                    3'd1: pixeles = 8'b01100110;
                    3'd2: pixeles = 8'b11000011;
                    3'd3: pixeles = 8'b11000011;
                    3'd4: pixeles = 8'b11000011;
                    3'd5: pixeles = 8'b11000011;
                    3'd6: pixeles = 8'b01100110;
                    3'd7: pixeles = 8'b00111100;
                endcase
            end

            // P
            5'd15: begin
                case (fila)
                    3'd0: pixeles = 8'b11111100;
                    3'd1: pixeles = 8'b11000110;
                    3'd2: pixeles = 8'b11000110;
                    3'd3: pixeles = 8'b11111100;
                    3'd4: pixeles = 8'b11000000;
                    3'd5: pixeles = 8'b11000000;
                    3'd6: pixeles = 8'b11000000;
                    3'd7: pixeles = 8'b11000000;
                endcase
            end

            // Q
            5'd16: begin
                case (fila)
                    3'd0: pixeles = 8'b00111100;
                    3'd1: pixeles = 8'b01100110;
                    3'd2: pixeles = 8'b11000011;
                    3'd3: pixeles = 8'b11000011;
                    3'd4: pixeles = 8'b11001011;
                    3'd5: pixeles = 8'b11000111;
                    3'd6: pixeles = 8'b01100110;
                    3'd7: pixeles = 8'b00111101;
                endcase
            end

            // R
            5'd17: begin
                case (fila)
                    3'd0: pixeles = 8'b11111100;
                    3'd1: pixeles = 8'b11000110;
                    3'd2: pixeles = 8'b11000110;
                    3'd3: pixeles = 8'b11111100;
                    3'd4: pixeles = 8'b11011000;
                    3'd5: pixeles = 8'b11001100;
                    3'd6: pixeles = 8'b11000110;
                    3'd7: pixeles = 8'b11000110;
                endcase
            end

            // S
            5'd18: begin
                case (fila)
                    3'd0: pixeles = 8'b00111110;
                    3'd1: pixeles = 8'b01100000;
                    3'd2: pixeles = 8'b11000000;
                    3'd3: pixeles = 8'b01111100;
                    3'd4: pixeles = 8'b00000110;
                    3'd5: pixeles = 8'b00000110;
                    3'd6: pixeles = 8'b11000110;
                    3'd7: pixeles = 8'b01111100;
                endcase
            end

            // T
            5'd19: begin
                case (fila)
                    3'd0: pixeles = 8'b11111111;
                    3'd1: pixeles = 8'b00011000;
                    3'd2: pixeles = 8'b00011000;
                    3'd3: pixeles = 8'b00011000;
                    3'd4: pixeles = 8'b00011000;
                    3'd5: pixeles = 8'b00011000;
                    3'd6: pixeles = 8'b00011000;
                    3'd7: pixeles = 8'b00011000;
                endcase
            end

            // U
            5'd20: begin
                case (fila)
                    3'd0: pixeles = 8'b11000011;
                    3'd1: pixeles = 8'b11000011;
                    3'd2: pixeles = 8'b11000011;
                    3'd3: pixeles = 8'b11000011;
                    3'd4: pixeles = 8'b11000011;
                    3'd5: pixeles = 8'b11000011;
                    3'd6: pixeles = 8'b01100110;
                    3'd7: pixeles = 8'b00111100;
                endcase
            end

            // V
            5'd21: begin
                case (fila)
                    3'd0: pixeles = 8'b11000011;
                    3'd1: pixeles = 8'b11000011;
                    3'd2: pixeles = 8'b11000011;
                    3'd3: pixeles = 8'b11000011;
                    3'd4: pixeles = 8'b01100110;
                    3'd5: pixeles = 8'b01100110;
                    3'd6: pixeles = 8'b00111100;
                    3'd7: pixeles = 8'b00011000;
                endcase
            end

            // W
            5'd22: begin
                case (fila)
                    3'd0: pixeles = 8'b11000011;
                    3'd1: pixeles = 8'b11000011;
                    3'd2: pixeles = 8'b11000011;
                    3'd3: pixeles = 8'b11011011;
                    3'd4: pixeles = 8'b11011011;
                    3'd5: pixeles = 8'b11111111;
                    3'd6: pixeles = 8'b11100111;
                    3'd7: pixeles = 8'b11000011;
                endcase
            end

            // X
            5'd23: begin
                case (fila)
                    3'd0: pixeles = 8'b11000011;
                    3'd1: pixeles = 8'b01100110;
                    3'd2: pixeles = 8'b00111100;
                    3'd3: pixeles = 8'b00011000;
                    3'd4: pixeles = 8'b00011000;
                    3'd5: pixeles = 8'b00111100;
                    3'd6: pixeles = 8'b01100110;
                    3'd7: pixeles = 8'b11000011;
                endcase
            end

            // Y
            5'd24: begin
                case (fila)
                    3'd0: pixeles = 8'b11000011;
                    3'd1: pixeles = 8'b01100110;
                    3'd2: pixeles = 8'b00111100;
                    3'd3: pixeles = 8'b00011000;
                    3'd4: pixeles = 8'b00011000;
                    3'd5: pixeles = 8'b00011000;
                    3'd6: pixeles = 8'b00011000;
                    3'd7: pixeles = 8'b00011000;
                endcase
            end

            // Z
            5'd25: begin
                case (fila)
                    3'd0: pixeles = 8'b11111111;
                    3'd1: pixeles = 8'b00000110;
                    3'd2: pixeles = 8'b00001100;
                    3'd3: pixeles = 8'b00011000;
                    3'd4: pixeles = 8'b00110000;
                    3'd5: pixeles = 8'b01100000;
                    3'd6: pixeles = 8'b11000000;
                    3'd7: pixeles = 8'b11111111;
                endcase
            end

            // ESPACIO
            5'd26: pixeles = 8'b00000000;

            // Cualquier código no definido: apagado
            default: pixeles = 8'b00000000;

        endcase
    end

endmodule

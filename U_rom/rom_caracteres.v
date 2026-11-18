`timescale 1ns/1ps

module rom_caracteres (
    input  wire [5:0] caracter,
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

                        
            5'd27: begin
                case (fila)
                    3'd0: pixeles = 8'b00000000;
                    3'd1: pixeles = 8'b00000000;
                    3'd2: pixeles = 8'b00000000;
                    3'd3: pixeles = 8'b01111110;
                    3'd4: pixeles = 8'b01111110;
                    3'd5: pixeles = 8'b00000000;
                    3'd6: pixeles = 8'b00000000;
                    3'd7: pixeles = 8'b00000000;
                endcase
            end
            
                        // . (28)
            6'd28: begin
                case (fila)
                    3'd6: pixeles = 8'b00011000;
                    3'd7: pixeles = 8'b00011000;
                    default: pixeles = 8'b00000000;
                endcase
            end

            // ! (29)
            6'd29: begin
                case (fila)
                    3'd0: pixeles = 8'b00011000;
                    3'd1: pixeles = 8'b00011000;
                    3'd2: pixeles = 8'b00011000;
                    3'd3: pixeles = 8'b00011000;
                    3'd4: pixeles = 8'b00011000;
                    3'd5: pixeles = 8'b00011000;
                    3'd6: pixeles = 8'b00000000;
                    3'd7: pixeles = 8'b00011000;
                endcase
            end

            // ? (30)
            6'd30: begin
                case (fila)
                    3'd0: pixeles = 8'b00111100;
                    3'd1: pixeles = 8'b01100110;
                    3'd2: pixeles = 8'b00000110;
                    3'd3: pixeles = 8'b00001100;
                    3'd4: pixeles = 8'b00011000;
                    3'd5: pixeles = 8'b00000000;
                    3'd6: pixeles = 8'b00011000;
                    3'd7: pixeles = 8'b00011000;
                endcase
            end

            // : (31)
            6'd31: begin
                case (fila)
                    3'd2: pixeles = 8'b00011000;
                    3'd3: pixeles = 8'b00011000;
                    3'd5: pixeles = 8'b00011000;
                    3'd6: pixeles = 8'b00011000;
                    default: pixeles = 8'b00000000;
                endcase
            end

            // ---------------- DIGITOS ----------------

            // 0 (32)
            6'd32: begin
                case (fila)
                    3'd0: pixeles = 8'b00111100;
                    3'd1: pixeles = 8'b01100110;
                    3'd2: pixeles = 8'b11000111;
                    3'd3: pixeles = 8'b11001011;
                    3'd4: pixeles = 8'b11010011;
                    3'd5: pixeles = 8'b11100011;
                    3'd6: pixeles = 8'b01100110;
                    3'd7: pixeles = 8'b00111100;
                endcase
            end

            // 1 (33)
            6'd33: begin
                case (fila)
                    3'd0: pixeles = 8'b00011000;
                    3'd1: pixeles = 8'b00111000;
                    3'd2: pixeles = 8'b01111000;
                    3'd3: pixeles = 8'b00011000;
                    3'd4: pixeles = 8'b00011000;
                    3'd5: pixeles = 8'b00011000;
                    3'd6: pixeles = 8'b00011000;
                    3'd7: pixeles = 8'b01111110;
                endcase
            end

            // 2 (34)
            6'd34: begin
                case (fila)
                    3'd0: pixeles = 8'b00111100;
                    3'd1: pixeles = 8'b01100110;
                    3'd2: pixeles = 8'b00000110;
                    3'd3: pixeles = 8'b00001100;
                    3'd4: pixeles = 8'b00011000;
                    3'd5: pixeles = 8'b00110000;
                    3'd6: pixeles = 8'b01100000;
                    3'd7: pixeles = 8'b01111110;
                endcase
            end

            // 3 (35)
            6'd35: begin
                case (fila)
                    3'd0: pixeles = 8'b00111100;
                    3'd1: pixeles = 8'b01100110;
                    3'd2: pixeles = 8'b00000110;
                    3'd3: pixeles = 8'b00011100;
                    3'd4: pixeles = 8'b00000110;
                    3'd5: pixeles = 8'b00000110;
                    3'd6: pixeles = 8'b01100110;
                    3'd7: pixeles = 8'b00111100;
                endcase
            end

            // 4 (36)
            6'd36: begin
                case (fila)
                    3'd0: pixeles = 8'b00001100;
                    3'd1: pixeles = 8'b00011100;
                    3'd2: pixeles = 8'b00111100;
                    3'd3: pixeles = 8'b01101100;
                    3'd4: pixeles = 8'b11001100;
                    3'd5: pixeles = 8'b11111111;
                    3'd6: pixeles = 8'b00001100;
                    3'd7: pixeles = 8'b00001100;
                endcase
            end

            // 5 (37)
            6'd37: begin
                case (fila)
                    3'd0: pixeles = 8'b01111110;
                    3'd1: pixeles = 8'b01100000;
                    3'd2: pixeles = 8'b01100000;
                    3'd3: pixeles = 8'b01111100;
                    3'd4: pixeles = 8'b00000110;
                    3'd5: pixeles = 8'b00000110;
                    3'd6: pixeles = 8'b01100110;
                    3'd7: pixeles = 8'b00111100;
                endcase
            end

            // 6 (38)
            6'd38: begin
                case (fila)
                    3'd0: pixeles = 8'b00011100;
                    3'd1: pixeles = 8'b00110000;
                    3'd2: pixeles = 8'b01100000;
                    3'd3: pixeles = 8'b01111100;
                    3'd4: pixeles = 8'b01100110;
                    3'd5: pixeles = 8'b01100110;
                    3'd6: pixeles = 8'b01100110;
                    3'd7: pixeles = 8'b00111100;
                endcase
            end

            // 7 (39)
            6'd39: begin
                case (fila)
                    3'd0: pixeles = 8'b01111110;
                    3'd1: pixeles = 8'b00000110;
                    3'd2: pixeles = 8'b00001100;
                    3'd3: pixeles = 8'b00011000;
                    3'd4: pixeles = 8'b00110000;
                    3'd5: pixeles = 8'b00110000;
                    3'd6: pixeles = 8'b00110000;
                    3'd7: pixeles = 8'b00110000;
                endcase
            end

            // 8 (40)
            6'd40: begin
                case (fila)
                    3'd0: pixeles = 8'b00111100;
                    3'd1: pixeles = 8'b01100110;
                    3'd2: pixeles = 8'b01100110;
                    3'd3: pixeles = 8'b00111100;
                    3'd4: pixeles = 8'b01100110;
                    3'd5: pixeles = 8'b01100110;
                    3'd6: pixeles = 8'b01100110;
                    3'd7: pixeles = 8'b00111100;
                endcase
            end

            // 9 (41)
            6'd41: begin
                case (fila)
                    3'd0: pixeles = 8'b00111100;
                    3'd1: pixeles = 8'b01100110;
                    3'd2: pixeles = 8'b01100110;
                    3'd3: pixeles = 8'b00111110;
                    3'd4: pixeles = 8'b00000110;
                    3'd5: pixeles = 8'b00000110;
                    3'd6: pixeles = 8'b00001100;
                    3'd7: pixeles = 8'b00111000;
                endcase
            end

            // ---------------- EMOJIS ----------------

            // CORAZON (42)
            6'd42: begin
                case (fila)
                    3'd0: pixeles = 8'b00000000;
                    3'd1: pixeles = 8'b01100110;
                    3'd2: pixeles = 8'b11111111;
                    3'd3: pixeles = 8'b11111111;
                    3'd4: pixeles = 8'b11111111;
                    3'd5: pixeles = 8'b01111110;
                    3'd6: pixeles = 8'b00111100;
                    3'd7: pixeles = 8'b00011000;
                endcase
            end

            // CARITA FELIZ (43)
            6'd43: begin
                case (fila)
                    3'd0: pixeles = 8'b00111100;
                    3'd1: pixeles = 8'b01000010;
                    3'd2: pixeles = 8'b10100101;
                    3'd3: pixeles = 8'b10000001;
                    3'd4: pixeles = 8'b10100101;
                    3'd5: pixeles = 8'b10011001;
                    3'd6: pixeles = 8'b01000010;
                    3'd7: pixeles = 8'b00111100;
                endcase
            end

            // CARITA TRISTE (44)
            6'd44: begin
                case (fila)
                    3'd0: pixeles = 8'b00111100;
                    3'd1: pixeles = 8'b01000010;
                    3'd2: pixeles = 8'b10100101;
                    3'd3: pixeles = 8'b10000001;
                    3'd4: pixeles = 8'b10011001;
                    3'd5: pixeles = 8'b10100101;
                    3'd6: pixeles = 8'b01000010;
                    3'd7: pixeles = 8'b00111100;
                endcase
            end

            // ESTRELLA (45)
            6'd45: begin
                case (fila)
                    3'd0: pixeles = 8'b00011000;
                    3'd1: pixeles = 8'b00011000;
                    3'd2: pixeles = 8'b11111111;
                    3'd3: pixeles = 8'b01111110;
                    3'd4: pixeles = 8'b00111100;
                    3'd5: pixeles = 8'b00111100;
                    3'd6: pixeles = 8'b01100110;
                    3'd7: pixeles = 8'b11000011;
                endcase
            end

            // NOTA MUSICAL (46)
            6'd46: begin
                case (fila)
                    3'd0: pixeles = 8'b00011111;
                    3'd1: pixeles = 8'b00011001;
                    3'd2: pixeles = 8'b00011001;
                    3'd3: pixeles = 8'b00011000;
                    3'd4: pixeles = 8'b00011000;
                    3'd5: pixeles = 8'b01111000;
                    3'd6: pixeles = 8'b11111000;
                    3'd7: pixeles = 8'b01110000;
                endcase
            end

            // FLECHA DERECHA (47)
            6'd47: begin
                case (fila)
                    3'd0: pixeles = 8'b00001000;
                    3'd1: pixeles = 8'b00001100;
                    3'd2: pixeles = 8'b00001110;
                    3'd3: pixeles = 8'b11111111;
                    3'd4: pixeles = 8'b11111111;
                    3'd5: pixeles = 8'b00001110;
                    3'd6: pixeles = 8'b00001100;
                    3'd7: pixeles = 8'b00001000;
                endcase
            end

            // FLECHA IZQUIERDA (48)
            6'd48: begin
                case (fila)
                    3'd0: pixeles = 8'b00010000;
                    3'd1: pixeles = 8'b00110000;
                    3'd2: pixeles = 8'b01110000;
                    3'd3: pixeles = 8'b11111111;
                    3'd4: pixeles = 8'b11111111;
                    3'd5: pixeles = 8'b01110000;
                    3'd6: pixeles = 8'b00110000;
                    3'd7: pixeles = 8'b00010000;
                endcase
            end

            // SOL (49)
            6'd49: begin
                case (fila)
                    3'd0: pixeles = 8'b10011001;
                    3'd1: pixeles = 8'b01011010;
                    3'd2: pixeles = 8'b00111100;
                    3'd3: pixeles = 8'b11111111;
                    3'd4: pixeles = 8'b11111111;
                    3'd5: pixeles = 8'b00111100;
                    3'd6: pixeles = 8'b01011010;
                    3'd7: pixeles = 8'b10011001;
                endcase
            end
            
            default: pixeles = 8'b00000000;

        endcase
    end

endmodule
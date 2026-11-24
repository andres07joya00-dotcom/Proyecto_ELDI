module uart_frase #(
    parameter integer N_CHARS = 16,
    parameter [6*N_CHARS-1:0] FRASE_INICIAL = {6*N_CHARS{1'b0}}
)(
    input  wire                 CLK,
    input  wire                 Estado,      
    input  wire                 UART_RX,
    output reg  [6*N_CHARS-1:0] Frase = FRASE_INICIAL
);

    localparam [5:0] Codigo_espacio = 6'd26;

    wire [7:0] Dato;
    wire       Dato_valido;

    uart_rx u_rx (
        .CLK         (CLK),
        .RX          (UART_RX),
        .Dato        (Dato),
        .Dato_valido (Dato_valido)
    );

   
    function [6:0] Traducir;
        input [7:0] Ascii;
        reg   [7:0] Resta;
        begin
            if (Ascii >= 8'h41 && Ascii <= 8'h5A) begin          // A-Z
                Resta    = Ascii - 8'h41;
                Traducir = {1'b1, Resta[5:0]};
            end
            else if (Ascii >= 8'h61 && Ascii <= 8'h7A) begin     // a-z
                Resta    = Ascii - 8'h61;
                Traducir = {1'b1, Resta[5:0]};
            end
            else if (Ascii >= 8'h30 && Ascii <= 8'h39) begin     // 0-9
                Resta    = Ascii - 8'h30 + 8'd32;
                Traducir = {1'b1, Resta[5:0]};
            end
            else begin
                case (Ascii)
                    8'h20: Traducir = {1'b1, 6'd26};   // espacio
                    8'h2D: Traducir = {1'b1, 6'd27};   // -
                    8'h2E: Traducir = {1'b1, 6'd28};   // .
                    8'h21: Traducir = {1'b1, 6'd29};   // !
                    8'h3F: Traducir = {1'b1, 6'd30};   // ?
                    8'h3A: Traducir = {1'b1, 6'd31};   // :
                    8'h40: Traducir = {1'b1, 6'd42};   // @ corazón
                    8'h28: Traducir = {1'b1, 6'd43};   // ( carita feliz
                    8'h29: Traducir = {1'b1, 6'd44};   // ) carita triste
                    8'h2A: Traducir = {1'b1, 6'd45};   // * estrella
                    8'h7E: Traducir = {1'b1, 6'd46};   // ~ nota musical
                    8'h3E: Traducir = {1'b1, 6'd47};   // > flecha derecha
                    8'h3C: Traducir = {1'b1, 6'd48};   // < flecha izquierda
                    8'h2B: Traducir = {1'b1, 6'd49};   // + sol
                    default: Traducir = 7'd0;          // se ignora
                endcase
            end
        end
    endfunction

    wire [6:0] Traduccion = Traducir(Dato);

    
    wire Bandera_caracter = Dato_valido & Traduccion[6];
    wire Bandera_borrar   = Dato_valido & ((Dato == 8'h08) | (Dato == 8'h7F)); 

   
    wire [6*N_CHARS-1:0] D_Frase =
        Bandera_caracter ? {Frase[6*N_CHARS-7:0], Traduccion[5:0]} :  
        Bandera_borrar   ? {Codigo_espacio, Frase[6*N_CHARS-1:6]}  :
                           Frase;

    always @(posedge CLK)
        Frase <= D_Frase;

endmodule
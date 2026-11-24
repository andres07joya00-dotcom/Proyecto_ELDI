module desplazamiento #(
    parameter integer N_CHARS = 10,
    parameter integer Cuadros_por_paso = 12
)(
    input  wire       CLK,
    input  wire       Estado,              // 0 = RESET, 1 = SEND
    input  wire       Bandera_fin_Cuadro,
    input  wire       Bandera_fin_columna,
    input  wire [6*N_CHARS-1:0] FRASE,

    output wire [5:0] Codigo_caracter,      // Hacia la ROM
    output wire [2:0] Bit_glifo,
    output wire       En_Glifo
);

    // Cuatro celdas vacías iniciales: 36 columnas.
    localparam integer N_PAD = 4;
    localparam integer NP = N_CHARS + N_PAD;
    wire [6*NP-1:0] FRASE_PAD = {{N_PAD{6'd26}}, FRASE};

    // Registros
    reg [7:0] Contador_Cuadros = 8'd0;
    reg [5:0] Inicio_indice   = 6'd0;
    reg [3:0] Inicio_subcol   = 4'd0;
    reg [5:0] Actual_indice   = 6'd0;
    reg [3:0] Actual_subcol   = 4'd0;

    // Banderas
    wire Bandera_Cuadros_completos = (Contador_Cuadros == Cuadros_por_paso - 1);
    wire Bandera_fin_paso          = Bandera_fin_Cuadro & Bandera_Cuadros_completos;
    wire Bandera_inicio_en_espacio = (Inicio_subcol == 4'd8);
    wire Bandera_fin_texto         = Bandera_inicio_en_espacio & (Inicio_indice == NP - 1);
    wire Bandera_actual_en_espacio = (Actual_subcol == 4'd8);
    wire Bandera_actual_valido     = (Actual_indice < NP);

    // Entradas D de los registros, según el esquemático.
    wire [7:0] D =
        (~Bandera_fin_Cuadro)      ? Contador_Cuadros :
        (Bandera_Cuadros_completos) ? 8'd0 :
                                     (Contador_Cuadros + 1'b1);

    wire [3:0] D1 =
        (~Bandera_fin_paso)         ? Inicio_subcol :
        (Bandera_inicio_en_espacio) ? 4'd0 :
                                      (Inicio_subcol + 1'b1);

    wire [5:0] D2 =
        (~Bandera_fin_paso)         ? Inicio_indice :
        (Bandera_fin_texto)         ? 6'd0 :
        (Bandera_inicio_en_espacio) ? (Inicio_indice + 1'b1) :
                                      Inicio_indice;

    wire [5:0] D3 =
        (~Estado)                  ? Inicio_indice :
        (~Bandera_fin_columna)     ? Actual_indice :
        (Bandera_actual_en_espacio) ? (Actual_indice + 1'b1) :
                                      Actual_indice;

    wire [3:0] D4 =
        (~Estado)                  ? Inicio_subcol :
        (~Bandera_fin_columna)     ? Actual_subcol :
        (Bandera_actual_en_espacio) ? 4'd0 :
                                      (Actual_subcol + 1'b1);

    // Salidas combinacionales
    assign Codigo_caracter = Bandera_actual_valido ? FRASE_PAD[6*(NP-1-Actual_indice) +: 6] : 6'd26;
    assign Bit_glifo       = ~Actual_subcol[2:0];  // 7 - subcolumna, dentro del glifo
    assign En_Glifo        = Bandera_actual_valido & ~Bandera_actual_en_espacio;

    always @(posedge CLK) begin
        Contador_Cuadros <= D;
        Inicio_subcol   <= D1;
        Inicio_indice   <= D2;
        Actual_indice   <= D3;
        Actual_subcol   <= D4;
    end

endmodule

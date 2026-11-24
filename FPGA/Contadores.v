module contadores(
    input  wire        CLK,
    input  wire        Estado,  // 0 = reinicio, 1 = envío

    output reg  [14:0] Contador_reinicio   = 15'd0,
    output reg  [6:0]  Contador_tiempo_bit = 7'd0,
    output reg  [4:0]  Indice_bit         = 5'd23,
    output reg  [7:0]  Indice_pixel       = 8'd0,

    output wire        Bandera_fin_reinicio,
    output wire        Bandera_fin_bit,
    output wire        Bandera_fin_pixel,
    output wire        Bandera_fin_Cuadro,
    output wire        Bandera_fin_columna
);

    localparam integer Periodo_bit     = 125;
    localparam integer Tiempo_reinicio = 28000;

    // Banderas
    assign Bandera_fin_reinicio = (Contador_reinicio == Tiempo_reinicio - 1);
    assign Bandera_fin_bit      = (Contador_tiempo_bit == Periodo_bit - 1);
    assign Bandera_fin_pixel    = Bandera_fin_bit & (Indice_bit == 5'd0);
    assign Bandera_fin_Cuadro   = Bandera_fin_pixel & (Indice_pixel == 8'd255);
    assign Bandera_fin_columna  = Bandera_fin_pixel & (Indice_pixel[2:0] == 3'd7);

    // Entradas D de los registros
    wire [14:0] D_Contador_reinicio =
        (~Estado & ~Bandera_fin_reinicio) ? (Contador_reinicio + 1'b1) :
                                            15'd0;

    wire [6:0] D_Contador_tiempo_bit =
        (Estado & ~Bandera_fin_bit) ? (Contador_tiempo_bit + 1'b1) :
                                       7'd0;

    wire [4:0] D_Indice_bit =
        (~Estado)                                            ? 5'd23 :
        (Estado & Bandera_fin_bit & (Indice_bit != 5'd0))    ? (Indice_bit - 1'b1) :
        (Estado & Bandera_fin_pixel)                         ? 5'd23 :
                                                               Indice_bit;

    wire [7:0] D_Indice_pixel =
        (~Estado)                                                ? 8'd0 :
        (Estado & Bandera_fin_pixel & (Indice_pixel != 8'd255)) ? (Indice_pixel + 1'b1) :
        (Estado & Bandera_fin_Cuadro)                             ? 8'd0 :
                                                                  Indice_pixel;

    // Registros
    always @(posedge CLK) begin
        Contador_reinicio   <= D_Contador_reinicio;
        Contador_tiempo_bit <= D_Contador_tiempo_bit;
        Indice_bit         <= D_Indice_bit;
        Indice_pixel       <= D_Indice_pixel;
    end

endmodule
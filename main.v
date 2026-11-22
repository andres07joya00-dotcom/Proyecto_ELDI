module main (
    input  wire       CLK,              
    input  wire [2:0] Interruptores,
    input  wire       UART_RX,     
    output reg        Datos_LED = 1'b0
);

    // Parámetros de la señal 
    localparam integer Tiempo_alto_bit_0 = 25;
    localparam integer Tiempo_alto_bit_1 = 88;

    localparam REINICIO = 1'b0;
    localparam ENVIO    = 1'b1;

    
    localparam integer N_CHARS = 32;

   
    localparam [6*N_CHARS-1:0] FRASE_INICIAL = {
        6'd7, 6'd14, 6'd11, 6'd0,          
        {(N_CHARS-4){6'd26}}               
    };
    
    reg Estado = REINICIO;

    wire [6*N_CHARS-1:0] FRASE;

    uart_frase #(
        .N_CHARS       (N_CHARS),
        .FRASE_INICIAL (FRASE_INICIAL)
    ) u_frase (
        .CLK     (CLK),
        .Estado  (Estado),
        .UART_RX (UART_RX),
        .Frase   (FRASE)
    );

    // Registro de estado

    // Contadores y banderas
    wire [14:0] Contador_reinicio;
    wire [6:0]  Contador_tiempo_bit;
    wire [4:0]  Indice_bit;
    wire [7:0]  Indice_pixel;

    wire Bandera_fin_reinicio;
    wire Bandera_fin_bit;
    wire Bandera_fin_pixel;
    wire Bandera_fin_Cuadro;
    wire Bandera_fin_columna;

    contadores u_cont (
        .CLK                  (CLK),
        .Estado               (Estado),
        .Contador_reinicio    (Contador_reinicio),
        .Contador_tiempo_bit  (Contador_tiempo_bit),
        .Indice_bit           (Indice_bit),
        .Indice_pixel         (Indice_pixel),
        .Bandera_fin_reinicio (Bandera_fin_reinicio),
        .Bandera_fin_bit      (Bandera_fin_bit),
        .Bandera_fin_pixel    (Bandera_fin_pixel),
        .Bandera_fin_Cuadro   (Bandera_fin_Cuadro),
        .Bandera_fin_columna  (Bandera_fin_columna)
    );

    // Coordenadas del píxel en la matriz
    wire [4:0] Columna;
    wire [2:0] Fila;

    mapeo_matriz u_map (
        .Indice_pixel (Indice_pixel),
        .Columna      (Columna),
        .Fila         (Fila)
    );

    // Desplazamiento y lectura de la ROM
    wire [5:0] Codigo_caracter;
    wire [2:0] Bit_glifo;
    wire       En_Glifo;
    wire [7:0] Pixeles_fila;

    desplazamiento #(
        .N_CHARS          (N_CHARS),
        .Cuadros_por_paso (12)
    ) u_scroll (
        .CLK                 (CLK),
        .Estado              (Estado),
        .Bandera_fin_Cuadro  (Bandera_fin_Cuadro),
        .Bandera_fin_columna (Bandera_fin_columna),
        .FRASE               (FRASE),
        .Codigo_caracter     (Codigo_caracter),
        .Bit_glifo           (Bit_glifo),
        .En_Glifo            (En_Glifo)
    );

    rom_caracteres u_rom (
        .caracter (Codigo_caracter),
        .fila     (Fila),
        .pixeles  (Pixeles_fila)
    );

    // Selector de color con los switches
    wire [23:0] Color_elegido;

    selector_color #(.Brillo(8'h40)) u_color (
        .CLK           (CLK),
        .Estado        (Estado),
        .Interruptores (Interruptores),
        .Color         (Color_elegido)
    );

    
    wire        Pixel_encendido = En_Glifo & Pixeles_fila[Bit_glifo];
    wire [23:0] Color_pixel     = Pixel_encendido ? Color_elegido : 24'h000000;
    wire        Bit_actual      = Color_pixel[Indice_bit];

   
    wire D_Estado =
        (~Estado & Bandera_fin_reinicio) | (Estado & ~Bandera_fin_Cuadro);

    wire D_Datos_LED =
        (Estado == ENVIO)
            ? (Bit_actual ? (Contador_tiempo_bit < Tiempo_alto_bit_1)
                          : (Contador_tiempo_bit < Tiempo_alto_bit_0))
            : 1'b0;

    always @(posedge CLK) begin
        Estado    <= D_Estado;
        Datos_LED <= D_Datos_LED;
    end

endmodule
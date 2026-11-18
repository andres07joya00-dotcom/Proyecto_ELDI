module mapeo_matriz (
    input  wire [7:0] Indice_pixel,
    output wire [4:0] Columna,
    output wire [2:0] Fila
);

    wire [2:0] Fila_directa = Indice_pixel[2:0];

    assign Columna = Indice_pixel[7:3];
    assign Fila    = Columna[0] ? ~Fila_directa : Fila_directa;

endmodule
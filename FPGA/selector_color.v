module selector_color #(
    parameter [7:0] Brillo = 8'h40          
)(
    input  wire        CLK,
    input  wire        Estado,              
    input  wire [2:0]  Interruptores,       

    output reg  [23:0] Color = 24'h000040   // formato GRB
);

   
    reg [2:0] Interruptores_etapa1 = 3'd0;
    reg [2:0] Interruptores_etapa2 = 3'd0;

    // Tabla de colores 
    wire [23:0] Color_elegido =
        (Interruptores_etapa2 == 3'd0) ? {Brillo,    8'h00,  8'h00 } :   // verde
        (Interruptores_etapa2 == 3'd1) ? {8'h00,     Brillo, 8'h00 } :   // rojo
        (Interruptores_etapa2 == 3'd2) ? {8'h00,     8'h00,  Brillo} :   // azul
        (Interruptores_etapa2 == 3'd3) ? {Brillo,    Brillo, 8'h00 } :   // amarillo
        (Interruptores_etapa2 == 3'd4) ? {Brillo,    8'h00,  Brillo} :   // cian
        (Interruptores_etapa2 == 3'd5) ? {8'h00,     Brillo, Brillo} :   // magenta
        (Interruptores_etapa2 == 3'd6) ? {Brillo,    Brillo, Brillo} :   // blanco
                                         {Brillo>>2, Brillo, 8'h00 };    // naranja

   
    wire [23:0] D_Color = (~Estado) ? Color_elegido : Color;

    always @(posedge CLK) begin
        Interruptores_etapa1 <= Interruptores;
        Interruptores_etapa2 <= Interruptores_etapa1;
        Color                <= D_Color;
    end

endmodule
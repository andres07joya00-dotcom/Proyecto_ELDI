module uart_rx #(
    parameter integer Clks_por_bit = 868      
)(
    input  wire       CLK,
    input  wire       RX,
    output reg  [7:0] Dato        = 8'd0,
    output reg        Dato_valido = 1'b0      
);

    localparam INACTIVO = 2'd0;
    localparam INICIO   = 2'd1;
    localparam DATOS    = 2'd2;
    localparam PARADA   = 2'd3;

    
    reg RX_etapa1 = 1'b1;
    reg RX_etapa2 = 1'b1;

    reg [1:0] Estado_rx = INACTIVO;
    reg [9:0] Contador  = 10'd0;
    reg [2:0] Indice    = 3'd0;

    always @(posedge CLK) begin
        RX_etapa1   <= RX;
        RX_etapa2   <= RX_etapa1;
        Dato_valido <= 1'b0;

        case (Estado_rx)

            INACTIVO: begin
                Contador <= 10'd0;
                Indice   <= 3'd0;
                if (RX_etapa2 == 1'b0)
                    Estado_rx <= INICIO;
            end

            
            INICIO: begin
                if (Contador == (Clks_por_bit/2) - 1) begin
                    Contador <= 10'd0;
                    if (RX_etapa2 == 1'b0) Estado_rx <= DATOS;
                    else                   Estado_rx <= INACTIVO;
                end else
                    Contador <= Contador + 1'b1;
            end

           
            DATOS: begin
                if (Contador == Clks_por_bit - 1) begin
                    Contador     <= 10'd0;
                    Dato[Indice] <= RX_etapa2;
                    if (Indice == 3'd7) begin
                        Indice    <= 3'd0;
                        Estado_rx <= PARADA;
                    end else
                        Indice <= Indice + 1'b1;
                end else
                    Contador <= Contador + 1'b1;
            end

            PARADA: begin
                if (Contador == Clks_por_bit - 1) begin
                    Dato_valido <= 1'b1;
                    Estado_rx   <= INACTIVO;
                    Contador    <= 10'd0;
                end else
                    Contador <= Contador + 1'b1;
            end

        endcase
    end

endmodule

`timescale 1ns/1ps

module tb_desplazamiento;

    reg CLK = 0;
    reg Estado = 0;
    reg Bandera_fin_Cuadro = 0;
    reg Bandera_fin_columna = 0;

    reg [23:0] FRASE = {
        6'd7,
        6'd14,
        6'd11,
        6'd0
    };

    wire [5:0] Codigo_caracter;
    wire [2:0] Bit_glifo;
    wire En_Glifo;

    desplazamiento #(
        .N_CHARS(4),
        .Cuadros_por_paso(3)
    ) uut (
        .CLK(CLK),
        .Estado(Estado),
        .Bandera_fin_Cuadro(Bandera_fin_Cuadro),
        .Bandera_fin_columna(Bandera_fin_columna),
        .FRASE(FRASE),
        .Codigo_caracter(Codigo_caracter),
        .Bit_glifo(Bit_glifo),
        .En_Glifo(En_Glifo)
    );

    always #5 CLK = ~CLK;

    task pulso_columna;
        begin
            @(negedge CLK);
            Bandera_fin_columna = 1;
            @(negedge CLK);
            Bandera_fin_columna = 0;
        end
    endtask

    task pulso_cuadro;
        begin
            @(negedge CLK);
            Bandera_fin_Cuadro = 1;
            @(negedge CLK);
            Bandera_fin_Cuadro = 0;
        end
    endtask

integer i;
integer j;

initial begin
    $dumpfile("desplazamiento.vcd");
    $dumpvars(0, tb_desplazamiento);

    repeat (3) @(negedge CLK);

    for (i = 0; i < 30; i = i + 1) begin
        Estado = 0;
        repeat (2) @(negedge CLK);

        Estado = 1;

        for (j = 0; j < 32; j = j + 1) begin
            pulso_columna();
        end

        Estado = 0;
        pulso_cuadro();
    end

    repeat (5) @(negedge CLK);

    $finish;
end

endmodule

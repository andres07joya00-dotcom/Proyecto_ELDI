`timescale 1ns/1ps

module tb_mapeo_matriz;

    reg  [7:0] Indice_pixel;
    wire [4:0] Columna;
    wire [2:0] Fila;

    integer i;

    mapeo_matriz dut (
        .Indice_pixel (Indice_pixel),
        .Columna      (Columna),
        .Fila         (Fila)
    );

    initial begin
        $dumpfile("mapeo_matriz.vcd");
        $dumpvars(1, tb_mapeo_matriz);

        for (i = 0; i < 256; i = i + 1) begin
            Indice_pixel = i[7:0];
            #10;
        end

        $finish;
    end

endmodule
module test_74HCT245 #(
    
    parameter MAX_COUNT = 49999999
)(
    input wire clk,
    output wire TEST_OUT
);

    reg [25:0] contador = 0;
    reg estado = 0;

    always @(posedge clk) begin
        if (contador == MAX_COUNT) begin
            contador <= 0;
            estado <= ~estado;
        end
        else begin
            contador <= contador + 1'b1;
        end
    end

    assign TEST_OUT = estado;

endmodule
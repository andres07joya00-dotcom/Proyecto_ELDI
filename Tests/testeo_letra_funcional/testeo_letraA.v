module ws2812_fastled(
    input wire clk, 
    output reg led_data = 1'b0
);


    localparam integer T0H = 25; 
    localparam integer T1H = 88; 
    localparam integer BIT_PERIOD = 125; 
    localparam integer RESET_TIME = 28000;

    localparam [1:0] BLOCK = 2'd0; // Bloque 8x8 (0 = izquierdo)
    localparam [23:0] COLOR = 24'h001000; // Verde tenue (Formato GRB)


    localparam RESET = 1'b0;
    localparam SEND = 1'b1;


    reg state = RESET;
    reg [14:0] reset_counter = 15'd0;
    reg [6:0] bit_counter = 7'd0;
    reg [4:0] bit_index = 5'd23;
    reg [8:0] pixel_index = 9'd0;

    reg [7:0] font_row;

    always @(*) begin
        case (row)
            3'd0: font_row = 8'b00011000;
            3'd1: font_row = 8'b00100100;
            3'd2: font_row = 8'b01000010;
            3'd3: font_row = 8'b01000010;
            3'd4: font_row = 8'b01111110;
            3'd5: font_row = 8'b01000010;
            3'd6: font_row = 8'b01000010;
            3'd7: font_row = 8'b00000000;
            default: font_row = 8'b00000000;
        endcase
    end


    wire [4:0] col = pixel_index[7:3];
    wire [2:0] r_raw = pixel_index[2:0];
    wire [2:0] row = col[0] ? ~r_raw : r_raw; // Inversión en columnas impares

    wire [2:0] lcol = col[2:0];
    wire in_block = (col[4:3] == BLOCK);

    wire pixel_on = in_block & font_row[~lcol];
    wire [23:0] pixel_color = pixel_on ? COLOR : 24'h000000;
    wire current_bit = pixel_color[bit_index];


    wire flag_end_reset = (reset_counter == RESET_TIME - 1);
    wire flag_end_bit_t = (bit_counter == BIT_PERIOD - 1);
    wire flag_end_bit_i = flag_end_bit_t & (bit_index == 5'd0);
    wire flag_end_pixel = flag_end_bit_i & (pixel_index == 9'd255);

 

    wire next_state = (~state & flag_end_reset) | (state & ~flag_end_pixel);


    wire [14:0] next_reset_counter = (state == RESET & ~flag_end_reset) ? (reset_counter + 1'b1) : 15'd0;


    wire [6:0] next_bit_counter = (state == SEND & ~flag_end_bit_t) ? (bit_counter + 1'b1) : 7'd0;


    wire [4:0] next_bit_index = (state == RESET) ? 5'd23 :
                                (state == SEND & flag_end_bit_t & (bit_index != 5'd0)) ? (bit_index - 1'b1) :
                                (state == SEND & flag_end_bit_i) ? 5'd23 : 
                                bit_index;

  
    wire [8:0] next_pixel_index = (state == RESET) ? 9'd0 :
                                 (state == SEND & flag_end_bit_i & (pixel_index != 9'd255)) ? (pixel_index + 1'b1) :
                                 (state == SEND & flag_end_pixel) ? 9'd0 : 
                                 pixel_index;


    wire next_led_data = (state == SEND) ? (current_bit ? (bit_counter < T1H) : (bit_counter < T0H)) : 1'b0;

    always @(posedge clk) begin
        state <= next_state;
        reset_counter <= next_reset_counter;
        bit_counter <= next_bit_counter;
        bit_index <= next_bit_index;
        pixel_index <= next_pixel_index;
        led_data <= next_led_data;
    end

endmodule
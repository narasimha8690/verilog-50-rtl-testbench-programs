module mux_8x1 (
    input wire [7:0] in,   
    input wire [2:0] sel,    
    output reg y);

always @(*) begin
    case (sel)
        3'b000: y = in[0];
        3'b001: y = in[1];
        3'b010: y = in[2];
        3'b011: y = in[3];
        3'b100: y = in[4];
        3'b101: y = in[5];
        3'b110: y = in[6];
        3'b111: y = in[7];
        default: y = 1'b0;
    endcase
end
endmodule

//Test Bench

`timescale 1ns / 1ps

module tb_mux_8x1;

reg [7:0] in;
reg [2:0] sel;
wire y;

mux_8x1 uut (
    .in(in),
    .sel(sel),
    .y(y)
);

initial begin
    $monitor("%0t\t%b\t%b\t%b", $time, sel, in, y);

  
    in = 8'b10101010;

    sel = 3'b000; #10;
    sel = 3'b001; #10;
    sel = 3'b010; #10;
    sel = 3'b011; #10;
    sel = 3'b100; #10;
    sel = 3'b101; #10;
    sel = 3'b110; #10;
    sel = 3'b111; #10;

    in = 8'b11001100;
    sel = 3'b000; #10;
    sel = 3'b100; #10;
    sel = 3'b111; #10;

    $finish;
end
endmodule

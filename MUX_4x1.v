module mux_4x1 (
    input wire [1:0] sel,
    input wire a, b, c, d,
    output reg y);

always @(*) begin
    case (sel)
        2'b00: y = a;
        2'b01: y = b;
        2'b10: y = c;
        2'b11: y = d;
        default: y = 1'b0;
    endcase
end
endmodule

//Test Bench

`timescale 1ns / 1ps

module tb_mux_4x1;

reg [1:0] sel;
reg a, b, c, d;
wire y;

mux_4x1 uut (
    .sel(sel),
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .y(y));

initial begin

    $monitor("%0t\t%b   %b %b %b %b | %b", $time, sel, a, b, c, d, y);

    a = 0; b = 1; c = 0; d = 1;

    sel = 2'b00; #10;
    sel = 2'b01; #10;
    sel = 2'b10; #10;
    sel = 2'b11; #10;

    a = 1; b = 0; c = 1; d = 0;

    sel = 2'b00; #10;
    sel = 2'b01; #10;
    sel = 2'b10; #10;
    sel = 2'b11; #10;

    $finish;
end
endmodule

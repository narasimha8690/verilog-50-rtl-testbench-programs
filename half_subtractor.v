module half_subtractor (
    input  a,
    input  b,
    output diff,
    output borrow);

assign diff   = a ^ b;
assign borrow = ~a & b;
endmodule

//Test Bench

module tb_half_subtractor;

reg a, b;
wire diff, borrow;

half_subtractor uut (
    .a(a),
    .b(b),
    .diff(diff),
    .borrow(borrow));

initial begin

    $monitor("%0t\t %b %b |  %b     %b", $time, a, b, diff, borrow);

    a = 0; b = 0; #10;
    a = 0; b = 1; #10;
    a = 1; b = 0; #10;
    a = 1; b = 1; #10;

    $finish;
end
endmodule

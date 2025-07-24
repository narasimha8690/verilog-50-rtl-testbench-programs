module full_adder (
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout);

assign sum  = a ^ b ^ cin;
assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

//Test Bench

`timescale 1ns / 1ps

module tb_full_adder;

reg a, b, cin;
wire sum, cout;

full_adder uut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout));

initial begin
    $monitor("%0t\t %b %b  %b   |  %b   %b", $time, a, b, cin, sum, cout);

    a = 0; b = 0; cin = 0; #10;
    a = 0; b = 0; cin = 1; #10;
    a = 0; b = 1; cin = 0; #10;
    a = 0; b = 1; cin = 1; #10;
    a = 1; b = 0; cin = 0; #10;
    a = 1; b = 0; cin = 1; #10;
    a = 1; b = 1; cin = 0; #10;
    a = 1; b = 1; cin = 1; #10;

    $finish;
end
endmodule

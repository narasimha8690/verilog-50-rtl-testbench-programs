module half_adder (
    input  a,
    input  b,
    output sum,
    output carry);

assign sum   = a ^ b;
assign carry = a & b;
endmodule

//Test Bench

module tb_half_adder;

reg a, b;
wire sum, carry;

half_adder uut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry));

initial begin

    $monitor("%0t\t %b %b |  %b    %b", $time, a, b, sum, carry);

    a = 0; b = 0; #10;
    a = 0; b = 1; #10;
    a = 1; b = 0; #10;
    a = 1; b = 1; #10;

    $finish;
end
endmodule

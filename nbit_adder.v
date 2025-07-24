module nbit_adder #(parameter N = 8)(
    input  wire [N-1:0] a,
    input  wire [N-1:0] b,
    output wire [N-1:0] sum,
    output wire         carry_out);

assign {carry_out, sum} = a + b;
endmodule

//Test Bench

module tb_nbit_adder;

parameter N = 8;

reg  [N-1:0] a, b;
wire [N-1:0] sum;
wire carry_out;

nbit_adder #(N) uut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry_out(carry_out));

initial begin
    $monitor("%0t\t%b\t+\t%b\t=\t%b\t%b", $time, a, b, sum, carry_out);
    a = 8'b00001111; b = 8'b00000001; #10;
    a = 8'b10101010; b = 8'b01010101; #10;
    a = 8'b11111111; b = 8'b00000001; #10;
    a = 8'b10000000; b = 8'b10000000; #10;
    a = 8'b00000000; b = 8'b00000000; #10;

    $finish;
end
endmodule

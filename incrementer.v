module incrementer (
    input  [3:0] a,
    output [3:0] result);

assign result = a + 1;
endmodule

//Test Bench

module tb_incrementer;

reg  [3:0] a;
wire [3:0] result;

incrementer uut (
    .a(a),
    .result(result));

initial begin
    $monitor("%0t\t%b | %b", $time, a, result);

    a = 4'b0000; #10;
    a = 4'b0001; #10;
    a = 4'b0111; #10;
    a = 4'b1000; #10;
    a = 4'b1111; #10;

    $finish;
end
endmodule

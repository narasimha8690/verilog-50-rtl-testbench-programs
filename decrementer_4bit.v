module decrementer_4bit (
    input  [3:0] in,
    output [3:0] out
);

assign out = in - 1;

endmodule

//Test Bench

module tb_decrementer_4bit;

reg  [3:0] in;
wire [3:0] out;

decrementer_4bit uut (
    .in(in),
    .out(out));

initial begin
    $monitor("%0t\t %b\t %b", $time, in, out);

    in = 4'b0000; #10;
    in = 4'b0001; #10;
    in = 4'b0010; #10;
    in = 4'b0100; #10;
    in = 4'b1111; #10;

    $finish;
end
endmodule

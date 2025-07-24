module full_subtractor (
    input  a,
    input  b,
    input  bin,
    output diff,
    output bout);

assign diff = a ^ b ^ bin;
assign bout = (~a & b) | (~(a ^ b) & bin);
endmodule

//Test Bench

module tb_full_subtractor;

reg a, b, bin;
wire diff, bout;

full_subtractor uut (
    .a(a),
    .b(b),
    .bin(bin),
    .diff(diff),
    .bout(bout));

initial begin
    $monitor("%0t\t %b %b  %b   |  %b    %b", $time, a, b, bin, diff, bout);

    a = 0; b = 0; bin = 0; #10;
    a = 0; b = 0; bin = 1; #10;
    a = 0; b = 1; bin = 0; #10;
    a = 0; b = 1; bin = 1; #10;
    a = 1; b = 0; bin = 0; #10;
    a = 1; b = 0; bin = 1; #10;
    a = 1; b = 1; bin = 0; #10;
    a = 1; b = 1; bin = 1; #10;

    $finish;
end
endmodule

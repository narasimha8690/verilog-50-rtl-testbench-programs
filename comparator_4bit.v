module comparator_4bit (
    input  [3:0] a,
    input  [3:0] b,
    output       a_gt_b,
    output       a_lt_b,
    output       a_eq_b);

assign a_gt_b = (a > b);
assign a_lt_b = (a < b);
assign a_eq_b = (a == b);
endmodule

//Test Bench

module tb_comparator_4bit;

reg  [3:0] a, b;
wire a_gt_b, a_lt_b, a_eq_b;

comparator_4bit uut (
    .a(a),
    .b(b),
    .a_gt_b(a_gt_b),
    .a_lt_b(a_lt_b),
    .a_eq_b(a_eq_b));

initial begin
    $display("Time\t a\t b\t a>b\t a<b\t a==b");
    $monitor("%0t\t %b\t %b\t  %b\t  %b\t   %b", $time, a, b, a_gt_b, a_lt_b, a_eq_b);

    a = 4'b0000; b = 4'b0000; #10;
    a = 4'b0101; b = 4'b0011; #10;
    a = 4'b0011; b = 4'b0101; #10;
    a = 4'b1111; b = 4'b1111; #10;
    a = 4'b1000; b = 4'b0111; #10;
    a = 4'b0100; b = 4'b0100; #10;

    $finish;
end
endmodule

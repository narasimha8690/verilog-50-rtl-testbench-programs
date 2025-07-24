module magnitude_comparator (
    input  [3:0] A,
    input  [3:0] B,
    output       A_gt_B,
    output       A_eq_B,
    output       A_lt_B);

assign A_gt_B = (A > B) ? 1'b1 : 1'b0;
assign A_eq_B = (A == B) ? 1'b1 : 1'b0;
assign A_lt_B = (A < B) ? 1'b1 : 1'b0;
endmodule

//Test Bench

module tb_magnitude_comparator;

reg  [3:0] A, B;
wire A_gt_B, A_eq_B, A_lt_B;

magnitude_comparator uut (
    .A(A),
    .B(B),
    .A_gt_B(A_gt_B),
    .A_eq_B(A_eq_B),
    .A_lt_B(A_lt_B));

initial begin
  
    $monitor("%0t\t%4b %4b |  %b    %b    %b", $time, A, B, A_gt_B, A_eq_B, A_lt_B);

    A = 4'b0000; B = 4'b0000; #10;
    A = 4'b0010; B = 4'b0001; #10;
    A = 4'b0100; B = 4'b0100; #10;
    A = 4'b0111; B = 4'b1000; #10;
    A = 4'b1111; B = 4'b1110; #10;
    A = 4'b0001; B = 4'b0010; #10;

    $finish;
end
endmodule

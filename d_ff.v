module d_ff (
    input wire clk,
    input wire rst_n, 
    input wire d,
    output reg q);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        q <= 0;
    else
        q <= d;
end
endmodule

//Test Bench

module tb_d_ff;

reg clk;
reg rst_n;
reg d;
wire q;

// Instantiate the D Flip-Flop
d_ff uut (
    .clk(clk),
    .rst_n(rst_n),
    .d(d),
    .q(q));

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    $monitor("Time = %0t | d = %b | q = %b", $time, d, q);

    rst_n = 0; d = 0;
    #12;              
    rst_n = 1;

    d = 1; #10;
    d = 0; #10;
    d = 1; #10;
    d = 1; #10;
    d = 0; #10;

    $finish;
end

endmodule

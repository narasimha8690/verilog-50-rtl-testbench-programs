module async_counter_4bit (
    input  wire clk,  
    input  wire rst_n,   
    output reg [3:0] q );

always @(negedge clk or negedge rst_n) begin
    if (!rst_n)
        q <= 4'b0000;
    else
        q <= q + 1'b1;
end
endmodule

//Test Bench

module tb_async_counter_4bit;

reg clk;
reg rst_n;
wire [3:0] q;
async_counter_4bit uut (
    .clk(clk),
    .rst_n(rst_n),
    .q(q));

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    $monitor("Time: %0t | q = %b", $time, q);

    rst_n = 0;
    #12;
    rst_n = 1;

    #100;
    $finish;
end
endmodule

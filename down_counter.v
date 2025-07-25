module down_counter (
    input wire clk,
    input wire rst_n,    
    output reg [3:0] count);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        count <= 4'b1111;        
    else
        count <= count - 1;     
end
endmodule

//Test Bench

module tb_down_counter;

reg clk;
reg rst_n;
wire [3:0] count;
down_counter uut (
    .clk(clk),
    .rst_n(rst_n),
    .count(count));

initial begin
    clk = 0;
    forever #5 clk = ~clk;  
end

initial begin
    $monitor("Time: %0t | count = %b", $time, count);
    
    rst_n = 0;
    #12;
    rst_n = 1;

    #100;
    $finish;
end

endmodule

module up_down_counter (
    input wire clk,
    input wire rst_n,    
    input wire up_down,   
    output reg [3:0] count);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        count <= 4'b0000;
    else if (up_down)
        count <= count + 1;
    else
        count <= count - 1;
end
endmodule

//Test Bench

module tb_up_down_counter;

reg clk;
reg rst_n;
reg up_down;
wire [3:0] count;
up_down_counter uut (
    .clk(clk),
    .rst_n(rst_n),
    .up_down(up_down),
    .count(count));

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    $monitor("Time = %0t | up_down = %b | count = %b", $time, up_down, count);
    
    rst_n = 0;
    up_down = 1;
    #12;

    rst_n = 1;        
    #40;

    up_down = 0;     
    #60;

    up_down = 1;     
    #60;
    $finish;
end
endmodule

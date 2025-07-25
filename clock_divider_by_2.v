module clock_divider_by_2 (
    input wire clk_in,     
    input wire rst_n,    
    output reg clk_out );

always @(posedge clk_in or negedge rst_n) begin
    if (!rst_n)
        clk_out <= 0;
    else
        clk_out <= ~clk_out;
end
endmodule

//Test Bench

module tb_clock_divider_by_2;

reg clk_in;
reg rst_n;
wire clk_out;

clock_divider_by_2 uut (
    .clk_in(clk_in),
    .rst_n(rst_n),
    .clk_out(clk_out));
initial begin
    clk_in = 0;
    forever #5 clk_in = ~clk_in;
end
initial begin
    $monitor("Time: %0t | clk_in = %b | clk_out = %b", $time, clk_in, clk_out);
    
    rst_n = 0;
    #12;
    rst_n = 1;

    #100;
    $finish;
end

endmodule

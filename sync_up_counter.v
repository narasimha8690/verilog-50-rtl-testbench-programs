module up_counter (
    input wire clk,
    input wire rst,     
    output reg [3:0] count);

always @(posedge clk) begin
    if (rst)
        count <= 4'b0000;
    else
        count <= count + 1;
end
endmodule

//Test Bench

module tb_up_counter;
    reg clk;
    reg rst;
    wire [3:0] count;
    up_counter uut (
        .clk(clk),
        .rst(rst),
        .count(count));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

        rst = 1;       
        #10;
        rst = 0;       

        #100;

        rst = 1;       
        #10;
        rst = 0;

        #50;
        $finish;
    end
endmodule

module jk_ff (
    input wire clk,    
    input wire rst_n,   
    input wire j,       
    input wire k,       
    output reg q,     
    output wire qbar    );
assign qbar = ~q;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        q <= 0;
    else begin
        case ({j, k})
            2'b00: q <= q;     
            2'b01: q <= 0;     
            2'b10: q <= 1;      
            2'b11: q <= ~q;     
        endcase
    end
end
endmodule

//Test Bench

module tb_jk_ff;

reg clk;
reg rst_n;
reg j, k;
wire q, qbar;

jk_ff uut (
    .clk(clk),
    .rst_n(rst_n),
    .j(j),
    .k(k),
    .q(q),
    .qbar(qbar));

always #5 clk = ~clk;

initial begin
    $monitor("Time=%0t | J=%b K=%b | Q=%b Qbar=%b", $time, j, k, q, qbar);
    clk = 0;
    rst_n = 0;
    j = 0; k = 0;
    #10;
    
    rst_n = 1;

    #10 j = 0; k = 0;
    #10;

    #10 j = 0; k = 1;
    #10;

    #10 j = 1; k = 0;
    #10;

    #10 j = 1; k = 1;
    #10;

    #10 j = 1; k = 1;
    #10;

    $finish;
end
endmodule

module sr_ff (
    input wire S,    
    input wire R,     
    input wire clk,
    output reg Q,
    output wire Q_bar);

assign Q_bar = ~Q;
always @(posedge clk) begin
    case ({S, R})
        2'b00: Q <= Q;       
        2'b01: Q <= 0;        
        2'b10: Q <= 1;        
        2'b11: Q <= 1'bx;     
    endcase
end
endmodule

//Test Bench

module tb_sr_ff;

reg S, R, clk;
wire Q, Q_bar;

sr_ff dut (
    .S(S),
    .R(R),
    .clk(clk),
    .Q(Q),
    .Q_bar(Q_bar));

always #5 clk = ~clk;
initial begin
    clk = 0;
    S = 0; R = 0;
    
    #10; S = 1; R = 0;  
    #10; S = 0; R = 1;   
    #10; S = 0; R = 0;   
    #10; S = 1; R = 1;   
    #10;

    $finish;
end
endmodule

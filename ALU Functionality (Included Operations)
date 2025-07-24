module alu_8bit (
    input  [7:0] a,
    input  [7:0] b,
    input  [2:0] sel,
    output reg [7:0] result
);

always @(*) begin
    case (sel)
        3'b000: result = a + b;          
        3'b001: result = a - b;          
        3'b010: result = a & b;          
        3'b011: result = a | b;          
        3'b100: result = a ^ b;          
        3'b101: result = ~a;             
        3'b110: result = a << 1;         
        3'b111: result = a >> 1;         
        default: result = 8'd0;
    endcase
end
endmodule

//test bench

module tb_alu_8bit;
reg [7:0] a, b;
reg [2:0] sel;
wire [7:0] result;

alu_8bit uut (
    .a(a),
    .b(b),
    .sel(sel),
    .result(result));

initial begin
    $display("Time\t a\t b\t sel\t result");
    $monitor("%0t\t %h\t %h\t %b\t %h", $time, a, b, sel, result);

    a = 8'h0A; b = 8'h03; sel = 3'b000; #10; 
    a = 8'h0A; b = 8'h03; sel = 3'b001; #10; 
    a = 8'h0A; b = 8'h03; sel = 3'b010; #10; 
    a = 8'h0A; b = 8'h03; sel = 3'b011; #10; 
    a = 8'h0A; b = 8'h03; sel = 3'b100; #10; 
    a = 8'h0A; b = 8'h03; sel = 3'b101; #10; 
    a = 8'h0A; b = 8'h03; sel = 3'b110; #10; 
    a = 8'h0A; b = 8'h03; sel = 3'b111; #10; 

    $finish;
end
endmodule

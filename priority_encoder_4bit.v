module priority_encoder_4bit (
    input  wire [3:0] in,
    output reg  [1:0] out,
    output reg   valid);

always @(*) begin
    valid = 1'b1;
    casez (in)
        4'b1???: begin out = 2'b11; end
        4'b01??: begin out = 2'b10; end
        4'b001?: begin out = 2'b01; end 
        4'b0001: begin out = 2'b00; end 
        default: begin
            out = 2'b00;
            valid = 1'b0;
        end
    endcase
end
endmodule

//Test Bench

module tb_priority_encoder_4bit;

reg  [3:0] in;
wire [1:0] out;
wire       valid;

priority_encoder_4bit uut (
    .in(in),
    .out(out),
    .valid(valid));

initial begin
  
    $monitor("%0t\t%b\t%02b\t%b", $time, in, out, valid);

    in = 4'b0000; #10;
    in = 4'b0001; #10;
    in = 4'b0010; #10;
    in = 4'b0100; #10;
    in = 4'b1000; #10;
    in = 4'b1010; #10;
    in = 4'b1111; #10;

    $finish;
end
endmodule

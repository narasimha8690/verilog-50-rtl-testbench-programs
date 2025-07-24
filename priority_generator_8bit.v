module priority_generator_8bit (
    input  wire [7:0] in,
    output reg  [2:0] out,
    output reg        valid);

always @(*) begin
    valid = 1'b1;
    casez (in)
        8'b1???????: out = 3'b111;
        8'b01??????: out = 3'b110;
        8'b001?????: out = 3'b101;
        8'b0001????: out = 3'b100;
        8'b00001???: out = 3'b011;
        8'b000001??: out = 3'b010;
        8'b0000001?: out = 3'b001;
        8'b00000001: out = 3'b000;
        default: begin
            out   = 3'b000;
            valid = 1'b0;
        end
    endcase
end

endmodule

//Test Bench

module tb_priority_generator_8bit;

reg  [7:0] in;
wire [2:0] out;
wire       valid;

priority_generator_8bit uut (
    .in(in),
    .out(out),
    .valid(valid));

initial begin
    $monitor("%0t\t%b\t%03b\t%b", $time, in, out, valid);

    in = 8'b00000000; #10;
    in = 8'b00000001; #10;
    in = 8'b00000100; #10;
    in = 8'b00011000; #10;
    in = 8'b10000000; #10;
    in = 8'b11110000; #10;
    in = 8'b00101010; #10;

    $finish;
end

endmodule


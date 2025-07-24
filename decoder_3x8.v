module decoder_3x8 (
    input  [2:0] in,
    input        en,
    output reg [7:0] out);

always @(*) begin
    if (en) begin
        case (in)
            3'b000: out = 8'b0000_0001;
            3'b001: out = 8'b0000_0010;
            3'b010: out = 8'b0000_0100;
            3'b011: out = 8'b0000_1000;
            3'b100: out = 8'b0001_0000;
            3'b101: out = 8'b0010_0000;
            3'b110: out = 8'b0100_0000;
            3'b111: out = 8'b1000_0000;
            default: out = 8'b0000_0000;
        endcase
    end else begin
        out = 8'b0000_0000;
    end
end
endmodule

//Test Bench

module tb_decoder_3x8;

reg [2:0] in;
reg en;
wire [7:0] out;

decoder_3x8 uut (
    .in(in),
    .en(en),
    .out(out));

initial begin
    $monitor("%0t\t %b\t %b\t %b", $time, en, in, out);

    en = 1;

    in = 3'b000; #10;
    in = 3'b001; #10;
    in = 3'b010; #10;
    in = 3'b011; #10;
    in = 3'b100; #10;
    in = 3'b101; #10;
    in = 3'b110; #10;
    in = 3'b111; #10;

    en = 0; in = 3'b100; #10;

    $finish;
end
endmodule

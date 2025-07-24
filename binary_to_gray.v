module binary_to_gray (
    input  [7:0] binary,
    output [7:0] gray);

assign gray[7] = binary[7];                 
assign gray[6] = binary[7] ^ binary[6];
assign gray[5] = binary[6] ^ binary[5];
assign gray[4] = binary[5] ^ binary[4];
assign gray[3] = binary[4] ^ binary[3];
assign gray[2] = binary[3] ^ binary[2];
assign gray[1] = binary[2] ^ binary[1];
assign gray[0] = binary[1] ^ binary[0];
endmodule

//Test Bench


module tb_binary_to_gray;

reg  [7:0] binary;
wire [7:0] gray;

binary_to_gray uut (
    .binary(binary),
    .gray(gray));

initial begin
    $display("Time\tBinary\t\tGray");
    $monitor("%0t\t%b\t%b", $time, binary, gray);

    binary = 8'b00000000; #10;
    binary = 8'b00000001; #10;
    binary = 8'b00000010; #10;
    binary = 8'b00000011; #10;
    binary = 8'b00000100; #10;
    binary = 8'b00001010; #10;
    binary = 8'b11111111; #10;

    $finish;
end
endmodule

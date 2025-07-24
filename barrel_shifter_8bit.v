module barrel_shifter_8bit (
    input  [7:0] data_in,
    input  [2:0] shamt,  
    input  [1:0] shift_type,  
    output reg [7:0] data_out
);

always @(*) begin
    case (shift_type)
        2'b00: data_out = data_in << shamt;                  
        2'b01: data_out = data_in >> shamt;                        
        2'b10: data_out = (data_in << shamt) | (data_in >> (8 - shamt)); 
        2'b11: data_out = (data_in >> shamt) | (data_in << (8 - shamt)); 
        default: data_out = data_in;
    endcase
end
endmodule

//test Bench

module tb_barrel_shifter_8bit;

reg  [7:0] data_in;
reg  [2:0] shamt;
reg  [1:0] shift_type;
wire [7:0] data_out;

barrel_shifter_8bit uut (
    .data_in(data_in),
    .shamt(shamt),
    .shift_type(shift_type),
    .data_out(data_out));

initial begin
    $display("Time\t data_in\t shamt\t shift_type\t data_out");
    $monitor("%0t\t %b\t %0d\t %b\t\t %b", $time, data_in, shamt, shift_type, data_out);

    data_in = 8'b10110011;

    shift_type = 2'b00; shamt = 3'd2; #10; -
    shift_type = 2'b01; shamt = 3'd2; #10; 
    shift_type = 2'b10; shamt = 3'd2; #10; 
    shift_type = 2'b11; shamt = 3'd2; #10; 

    shift_type = 2'b00; shamt = 3'd5; #10; 
    shift_type = 2'b10; shamt = 3'd5; #10; 

    $finish;
end
endmodule

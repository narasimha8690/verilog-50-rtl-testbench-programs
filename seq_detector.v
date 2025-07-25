module seq_detector (
    input wire clk,
    input wire rst_n,
    input wire in_bit,
    output reg detected);

typedef enum logic [2:0] {
    S0 = 3'b000,
    S1 = 3'b001,
    S2 = 3'b010,
    S3 = 3'b011,
    S4 = 3'b100
} state_t;

state_t state, next_state;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        state <= S0;
    else
        state <= next_state;
end
always @(*) begin
    case (state)
        S0: next_state = in_bit ? S1 : S0;
        S1: next_state = in_bit ? S1 : S2;
        S2: next_state = in_bit ? S3 : S0;
        S3: next_state = in_bit ? S4 : S2;
        S4: next_state = in_bit ? S1 : S2;  
        default: next_state = S0;
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        detected <= 0;
    else
        detected <= (state == S4);
end
endmodule

//Test Bench

module tb_seq_detector;

reg clk, rst_n, in_bit;
wire detected;

seq_detector uut (
    .clk(clk),
    .rst_n(rst_n),
    .in_bit(in_bit),
    .detected(detected));

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst_n = 0;
    in_bit = 0;
    #12 rst_n = 1;

    repeat(2) @(posedge clk); in_bit = 1;
    repeat(1) @(posedge clk); in_bit = 0;
    repeat(1) @(posedge clk); in_bit = 1;
    repeat(1) @(posedge clk); in_bit = 1;
    
    repeat(1) @(posedge clk); in_bit = 0; 
    repeat(1) @(posedge clk); in_bit = 1;
    repeat(1) @(posedge clk); in_bit = 0;
    repeat(1) @(posedge clk); in_bit = 1;
    repeat(1) @(posedge clk); in_bit = 1;

    #20;
    $finish;
end
endmodule


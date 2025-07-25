module pulse_generator (
    input wire clk,
    input wire rst_n,
    input wire trigger,
    output reg pulse_out);

reg trigger_d;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        trigger_d <= 0;
    else
        trigger_d <= trigger;
end
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        pulse_out <= 0;
    else
        pulse_out <= trigger & ~trigger_d; 
end
endmodule

//Test Bench

module tb_pulse_generator;

reg clk, rst_n, trigger;
wire pulse_out;

pulse_generator uut (
    .clk(clk),
    .rst_n(rst_n),
    .trigger(trigger),
    .pulse_out(pulse_out));

always #5 clk = ~clk;

initial begin
    $monitor("Time=%0t | Trigger=%b | Pulse_out=%b", $time, trigger, pulse_out);

    clk = 0;
    rst_n = 0;
    trigger = 0;
    #12;

    rst_n = 1;

    #10 trigger = 1;
    #10 trigger = 0;
    #20;
    #10 trigger = 1;
    #10 trigger = 0;
    #20;

    $finish;
end
endmodule

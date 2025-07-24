module mux_2x1 (
    input wire a,
    input wire b,
    input wire sel,
    output wire y);
assign y = (sel) ? b : a;
endmodule

//Test Bench

module tb_mux_2x1;

reg a, b, sel;
wire y;

mux_2x1 uut (
    .a(a),
    .b(b),
    .sel(sel),
    .y(y));

initial begin
    $display("Time\tsel a b | y");
    $monitor("%0t\t%b   %b %b | %b", $time, sel, a, b, y);

    // Apply test inputs
    sel = 0; a = 0; b = 0; #10;
    sel = 0; a = 1; b = 0; #10;
    sel = 1; a = 0; b = 1; #10;
    sel = 1; a = 1; b = 1; #10;

    $finish;
end
endmodule

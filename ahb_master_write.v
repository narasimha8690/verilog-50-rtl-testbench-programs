module ahb_master (
    input wire HCLK,
    input wire HRESETn,
    output reg HREADY,
    output reg HWRITE,
    output reg [1:0] HTRANS,
    output reg [31:0] HADDR,
    output reg [31:0] HWDATA);

always @(posedge HCLK or negedge HRESETn) begin
    if (!HRESETn) begin
        HWRITE <= 0;
        HTRANS <= 2'b00;
        HADDR  <= 32'd0;
        HWDATA <= 32'd0;
        HREADY <= 1;
    end else begin
        HTRANS <= 2'b10;         
        HWRITE <= 1'b1;
        HADDR  <= 32'h00000004;
        HWDATA <= 32'hDEADBEEF;
        HREADY <= 1;
    end
end
endmodule

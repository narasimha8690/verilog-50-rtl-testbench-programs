module apb2ahb_bridge (
    input  wire        PCLK,
    input  wire        PRESETn,
    input  wire        PSEL,
    input  wire        PENABLE,
    input  wire        PWRITE,
    input  wire [31:0] PADDR,
    input  wire [31:0] PWDATA,
    output reg  [31:0] PRDATA,
    output reg         PREADY,
    input  wire        HCLK,
    input  wire        HRESETn,
    output reg  [31:0] HADDR,
    output reg  [31:0] HWDATA,
    input  wire [31:0] HRDATA,
    output reg         HWRITE,
    output reg  [1:0]  HTRANS,
    input  wire        HREADY,
    output reg         HSEL);

    typedef enum logic [1:0] {
        IDLE  = 2'b00,
        SETUP = 2'b01,
        ACCESS = 2'b10
    } state_t;

    state_t current_state, next_state;
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    always @(*) begin
        case (current_state)
            IDLE:    next_state = (PSEL && !PENABLE) ? SETUP  : IDLE;
            SETUP:   next_state = (PSEL && PENABLE)  ? ACCESS : SETUP;
            ACCESS:  next_state = (!PSEL || !PENABLE)? IDLE   : ACCESS;
            default: next_state = IDLE;
        endcase
    end
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            HADDR   <= 32'd0;
            HWDATA  <= 32'd0;
            HWRITE  <= 1'b0;
            HTRANS  <= 2'b00;
            HSEL    <= 1'b0;
            PRDATA  <= 32'd0;
            PREADY  <= 1'b0;
        end else begin
            case (next_state)
                SETUP: begin
                    HADDR   <= PADDR;
                    HWDATA  <= PWDATA;
                    HWRITE  <= PWRITE;
                    HTRANS  <= 2'b10; 
                    HSEL    <= 1'b1;
                    PREADY  <= 1'b0;
                end
                ACCESS: begin
                    if (HREADY) begin
                        if (!PWRITE)
                            PRDATA <= HRDATA;
                        PREADY <= 1'b1;
                        HSEL   <= 1'b0;
                        HTRANS <= 2'b00; 
                    end else begin
                        PREADY <= 1'b0;
                    end
                end
                default: begin
                    HTRANS <= 2'b00;
                    HSEL   <= 1'b0;
                    PREADY <= 1'b0;
                end
            endcase
        end
    end

endmodule

module ahb2apb_bridge (
    input  wire        HCLK,
    input  wire        HRESETn,
    input  wire [31:0] HADDR,
    input  wire [31:0] HWDATA,
    output reg  [31:0] HRDATA,
    input  wire        HWRITE,
    input  wire [1:0]  HTRANS,
    input  wire        HSEL,
    input  wire        HREADY,
    output reg         HREADYOUT,
    output reg         PSEL,
    output reg         PENABLE,
    output reg         PWRITE,
    output reg  [31:0] PADDR,
    output reg  [31:0] PWDATA,
    input  wire [31:0] PRDATA,
    input  wire        PREADY);
    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        SETUP   = 2'b01,
        ACCESS  = 2'b10
    } state_t;

    state_t current_state, next_state;
    always @(posedge HCLK or negedge HRESETn) begin
        if (!HRESETn)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (HSEL && HREADY && HTRANS[1]) 
                    next_state = SETUP;
                else
                    next_state = IDLE;
            end
            SETUP: begin
                next_state = ACCESS;
            end
            ACCESS: begin
                if (PREADY)
                    next_state = IDLE;
                else
                    next_state = ACCESS;
            end
            default: next_state = IDLE;
        endcase
    end
    always @(posedge HCLK or negedge HRESETn) begin
        if (!HRESETn) begin
            PSEL       <= 1'b0;
            PENABLE    <= 1'b0;
            PWRITE     <= 1'b0;
            PADDR      <= 32'd0;
            PWDATA     <= 32'd0;
            HRDATA     <= 32'd0;
            HREADYOUT  <= 1'b1;
        end else begin
            case (next_state)
                IDLE: begin
                    PSEL      <= 1'b0;
                    PENABLE   <= 1'b0;
                    HREADYOUT <= 1'b1;
                end
                SETUP: begin
                    PSEL      <= 1'b1;
                    PENABLE   <= 1'b0;
                    PADDR     <= HADDR;
                    PWDATA    <= HWDATA;
                    PWRITE    <= HWRITE;
                    HREADYOUT <= 1'b0; 
                end
                ACCESS: begin
                    PENABLE   <= 1'b1;
                    if (PREADY) begin
                        HREADYOUT <= 1'b1;
                        if (!PWRITE)
                            HRDATA <= PRDATA;
                    end else begin
                        HREADYOUT <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule

module gearbox_rx (
    input [63:0] serdes_data,
    input serdes_valid, slip,
    input clk,
    output [65:0] block_data,
    output block_valid
);

reg [127:0] a_buffer;
reg [127:0] positionA;
reg [127:0] positionB;

always @(posedge clk) begin
    if !(serdes_valid) begin
        positionA <= 128'b0;
        positionB <= 128'b1;
    end
    else if (serdes_valid)&&(slip) begin
        //a_buffer <= {a_buffer[63:0], serdes_data};
    end
    else if (serdes_valid)&&(!slip) begin
        a_buffer <= {a_buffer[63:0], serdes_data};
        positionA <= positionA + 2;
        positionB <= positionB + 2;
        if (a_buffer[(positionA)]^a_buffer[(positionB)]) begin
            
        end
    end

    if ((a_buffer[(slip_count+1+64)]^a_buffer[slip_count+64])) begin //could also do some variation of (128 - slip count)
        block_valid <= 1;
        block_valid <= 0;
    end
    if (slip) begin
        slip_count <= slip_count + 1;
    end

end

endmodule
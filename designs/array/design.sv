// =======================================================================
// Design Name: 64-bit Conventional Array Multiplier (Baseline)
// Description: Standard combinational shift-and-add array multiplier
//              used as an architectural baseline for performance benchmarking.
// =======================================================================

module array_multiplier_64bit (
    input  logic [63:0]  multiplicand, // Input A
    input  logic [63:0]  multiplier,   // Input B
    output logic [127:0] final_product // 128-bit output result
);

    always @* begin
        // Initialize the product to zero
        final_product = 128'b0;
        
        // Generate and accumulate partial products
        for (int i = 0; i < 64; i = i + 1) begin
            if (multiplier[i]) begin
                final_product = final_product + ({64'b0, multiplicand} << i);
            end
        end
    end

endmodule
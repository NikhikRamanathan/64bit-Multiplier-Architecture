module dadda_multiplier_64bit (
    input  logic [63:0] multiplicand,
    input  logic [63:0] multiplier,
    output logic [127:0] final_product
);
    logic [127:0] pp [63:0];
    
    always_comb begin
        for (int i = 0; i < 64; i++) begin
            pp[i] = (multiplier[i]) ? ({64'b0, multiplicand} << i) : 128'b0;
        end
        
        final_product = 0;
        for (int i = 0; i < 64; i++) begin
            final_product = final_product + pp[i];
        end
    end
endmodule
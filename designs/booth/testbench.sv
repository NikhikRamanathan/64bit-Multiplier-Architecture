// =======================================================================
// Module Name: testbench
// Description: Functional verification suite for the 64-bit Booth Multiplier.
//              Applies targeted edge-case test vectors and monitors the
//              output for correctness.
// =======================================================================

`timescale 1ns/1ps

module testbench;

    // Testbench stimulus signals
    logic [63:0]  test_input_A;
    logic [63:0]  test_input_B;
    logic [127:0] simulated_product;
    
    // Instantiate the Unit Under Test (UUT)
    booth_multiplier_64bit uut (
        .multiplicand  (test_input_A),
        .multiplier    (test_input_B),
        .final_product (simulated_product)
    );
    
    initial begin
        $dumpfile("booth_power.vcd");
        $dumpvars(0, testbench);

        // Display simulation banner
        $display("// =====================================================");
        $display("//   INITIALIZING FUNCTIONAL VERIFICATION SIMULATION    ");
        $display("// =====================================================");
        
        // Monitor signal activity
        $monitor("Time = %0dns | A = %0d, B = %0d | Product = %0d", 
                 $time, test_input_A, test_input_B, simulated_product);
        
        // ---------------------------------------------------------
        // TEST CASE 1: Standard Positive Integers
        // ---------------------------------------------------------
        test_input_A = 64'd12;
        test_input_B = 64'd5;
        #10;
        if (simulated_product === 128'd60) 
            $display(">> status: [SUCCESS] Test Case 1 Passed.\n");
        else 
            $display(">> status: [FAILURE] Test Case 1 Mismatch. Expected 60.\n");
        
        // ---------------------------------------------------------
        // TEST CASE 2: Zero Identity Property
        // ---------------------------------------------------------
        test_input_A = 64'd987654321;
        test_input_B = 64'd0;
        #10;
        if (simulated_product === 128'd0) 
            $display(">> status: [SUCCESS] Test Case 2 Passed.\n");
        else 
            $display(">> status: [FAILURE] Test Case 2 Mismatch. Expected 0.\n");
        
        // ---------------------------------------------------------
        // TEST CASE 3: 32-bit Data Boundary Scaling
        // ---------------------------------------------------------
        test_input_A = 64'd4294967295; // Max unsigned 32-bit integer
        test_input_B = 64'd10;
        #10;
        if (simulated_product === 128'd42949672950) 
            $display(">> status: [SUCCESS] Test Case 3 Passed.\n");
        else 
            $display(">> status: [FAILURE] Test Case 3 Mismatch.\n");

        // ---------------------------------------------------------
        // TEST CASE 4: Large 64-bit Scale Test
        // ---------------------------------------------------------
        test_input_A = 64'd1000000000; 
        test_input_B = 64'd2000000000;
        #10;
        if (simulated_product === 128'd2000000000000000000) 
            $display(">> status: [SUCCESS] Test Case 4 Passed.\n");
        else 
            $display(">> status: [FAILURE] Test Case 4 Mismatch.\n");
        
        // Wrap up execution
        $display("// =====================================================");
        $display("//             VERIFICATION RUN COMPLETE                ");
        $display("// =====================================================");
        $finish; 
    end

endmodule
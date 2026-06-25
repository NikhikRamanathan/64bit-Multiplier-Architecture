`timescale 1ns/1ps

module testbench;

    logic [63:0]  test_input_A;
    logic [63:0]  test_input_B;
    logic [127:0] simulated_product;

    dadda_multiplier_64bit uut (
        .multiplicand  (test_input_A),
        .multiplier    (test_input_B),
        .final_product (simulated_product)
    );

    initial begin
        $dumpfile("dadda_power.vcd");
        $dumpvars(0, testbench);

        test_input_A = 64'd12;
        test_input_B = 64'd5;
        #10;
        if (simulated_product === 128'd60)
            $display("PASS: 12 x 5");
        else
            $display("FAIL: 12 x 5");

        test_input_A = 64'd987654321;
        test_input_B = 64'd0;
        #10;
        if (simulated_product === 128'd0)
            $display("PASS: zero test");
        else
            $display("FAIL: zero test");

        test_input_A = 64'd4294967295;
        test_input_B = 64'd10;
        #10;
        if (simulated_product === 128'd42949672950)
            $display("PASS: 32-bit boundary test");
        else
            $display("FAIL: 32-bit boundary test");

        test_input_A = 64'd1000000000;
        test_input_B = 64'd2000000000;
        #10;
        if (simulated_product === 128'd2000000000000000000)
            $display("PASS: large multiplication test");
        else
            $display("FAIL: large multiplication test");

        $finish;
    end

endmodule
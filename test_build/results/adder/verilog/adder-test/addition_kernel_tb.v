module addition_kernel_tb;

reg [7:0] input1_0, input1_1, input1_2, input1_3, input1_4, input1_5, input1_6, input1_7;
reg [7:0] input2_0, input2_1, input2_2, input2_3, input2_4, input2_5, input2_6, input2_7;
wire [7:0] output_0, output_1, output_2, output_3, output_4, output_5, output_6, output_7;
reg clk;

addition_kernel u1 (
    .input1_0(input1_0), .input1_1(input1_1), .input1_2(input1_2), .input1_3(input1_3), 
    .input1_4(input1_4), .input1_5(input1_5), .input1_6(input1_6), .input1_7(input1_7), 

    .input2_0(input2_0), .input2_1(input2_1), .input2_2(input2_2), .input2_3(input2_3), 
    .input2_4(input2_4), .input2_5(input2_5), .input2_6(input2_6), .input2_7(input2_7), 

    .output_0(output_0), .output_1(output_1), .output_2(output_2), .output_3(output_3), 
    .output_4(output_4), .output_5(output_5), .output_6(output_6), .output_7(output_7), 

    .clk(clk)
);

initial begin
    // Dumping the waveform for visualization
    $dumpfile("add.vcd");
    $dumpvars(0, addition_kernel_tb);


    clk = 0;
    // Initialize input arrays
    input1_0 = 0; input2_0 = 8;
    input1_1 = 1; input2_1 = 7;
    input1_2 = 2; input2_2 = 6;
    input1_3 = 3; input2_3 = 5;
    input1_4 = 4; input2_4 = 4;
    input1_5 = 5; input2_5 = 3;
    input1_6 = 6; input2_6 = 2;
    input1_7 = 7; input2_7 = 1;

    // Start the test
    #10;
    $display("Starting test...");
    #10;

    // Display results
    $display("input1[0] + input2[0] = %0d", output_0);
    $display("input1[1] + input2[1] = %0d", output_1);
    $display("input1[2] + input2[2] = %0d", output_2);
    $display("input1[3] + input2[3] = %0d", output_3);
    $display("input1[4] + input2[4] = %0d", output_4);
    $display("input1[5] + input2[5] = %0d", output_5);
    $display("input1[6] + input2[6] = %0d", output_6);
    $display("input1[7] + input2[7] = %0d", output_7);

    $finish;
end

always #5 clk = ~clk;

endmodule

`timescale 1ns/1ps

module design_sv2v_tb;

    // Declare the signals that will connect to the module's inputs and outputs
    reg clk;
    reg reset;
    reg [31:0] input1 [31:0];
    reg [31:0] input2 [31:0];
    wire [31:0] output [31:0];
    integer i;

    // Instantiate the module
    design_sv2v uut (
        .clk(clk),
        .reset(reset),
        // Assuming the module has array inputs and outputs. Adjust as needed.
        .input1(input1),
        .input2(input2),
        .output(output)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Testbench stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        #10 reset = 0;

        // Initialize input arrays
        for (i = 0; i < 32; i = i + 1) begin
            input1[i] = i;
            input2[i] = 32 - i;
        end

        // Wait for some clock cycles to let the design process the inputs
        #50;

        // Check the results
        for (i = 0; i < 32; i = i + 1) begin
            if (output[i] !== (input1[i] + input2[i])) begin
                $display("Mismatch at index %d: Expected %d, Got %d", i, (input1[i] + input2[i]), output[i]);
            end
        end

        // Finish the simulation
        #100 $finish;
    end

endmodule

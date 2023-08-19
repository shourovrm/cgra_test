module addition_kernel (
    input [7:0] input1_0, input [7:0] input1_1, input [7:0] input1_2, input [7:0] input1_3, 
    input [7:0] input1_4, input [7:0] input1_5, input [7:0] input1_6, input [7:0] input1_7, 

    input [7:0] input2_0, input [7:0] input2_1, input [7:0] input2_2, input [7:0] input2_3, 
    input [7:0] input2_4, input [7:0] input2_5, input [7:0] input2_6, input [7:0] input2_7, 

    output reg [7:0] output_0, output reg [7:0] output_1, output reg [7:0] output_2, output reg [7:0] output_3, 
    output reg [7:0] output_4, output reg [7:0] output_5, output reg [7:0] output_6, output reg [7:0] output_7, 

    input clk
);

always @(posedge clk) begin
    output_0 <= input1_0 + input2_0;
    output_1 <= input1_1 + input2_1;
    output_2 <= input1_2 + input2_2;
    output_3 <= input1_3 + input2_3;
    output_4 <= input1_4 + input2_4;
    output_5 <= input1_5 + input2_5;
    output_6 <= input1_6 + input2_6;
    output_7 <= input1_7 + input2_7;
end

endmodule

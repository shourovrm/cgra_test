module CGRAKingMeshRTL__99cbcfeeb0999932_tb;

    // Clock and reset signals
    reg clk;
    reg reset;

    // Inputs
    reg [3:0] recv_waddr__en;
    reg [11:0] recv_waddr__msg;
    reg [3:0] recv_wopt__en;
    reg [235:0] recv_wopt__msg;

    // Outputs
    wire [3:0] recv_waddr__rdy;
    wire [3:0] recv_wopt__rdy;

    // Instantiate the design under test (DUT)
    CGRAKingMeshRTL__99cbcfeeb0999932 uut (
        .clk(clk),
        .reset(reset),
        .recv_waddr__en(recv_waddr__en),
        .recv_waddr__msg(recv_waddr__msg),
        .recv_waddr__rdy(recv_waddr__rdy),
        .recv_wopt__en(recv_wopt__en),
        .recv_wopt__msg(recv_wopt__msg),
        .recv_wopt__rdy(recv_wopt__rdy)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        recv_waddr__en = 0;
        recv_waddr__msg = 0;
        recv_wopt__en = 0;
        recv_wopt__msg = 0;

        // Dumping the waveform for visualization
        $dumpfile("CGRAKingMeshRTL__99cbcfeeb0999932_tb.vcd");
        $dumpvars(0, CGRAKingMeshRTL__99cbcfeeb0999932_tb);

        // Apply reset
        #10 reset = 0;
        #10 reset = 1;
        #10 reset = 0;

        // Apply test vectors
        #10 recv_waddr__en = 4'b0010;
        recv_waddr__msg = 12'h123;
        #10 recv_waddr__en = 0;
        recv_waddr__msg = 0;

        #10 recv_wopt__en = 4'b0100;
        recv_wopt__msg = 236'h456;
        #10 recv_wopt__en = 0;
        recv_wopt__msg = 0;

        //... more sequences as needed

        #100 $finish; // End simulation after some delay
    end

endmodule

module SmartAC_tb;

    // Inputs
    reg SW;
    reg clk;
    reg modein;

    // Outputs
    wire [2:0] mode;
    wire [2:0] fan;
    wire [6:0] disp;

    // Instantiate the SmartAC module
    SmartAC uut (
        .SW(SW),
        .clk(clk),
        .modein(modein),
        .mode(mode),
        .fan(fan),
        .disp(disp)
    );

    // Clock generation
    always #5 clk = ~clk; // 10 ns clock period

    initial begin
        // Initialize Inputs
        clk = 0;
        SW = 0;
        modein = 0;

        // Monitor the outputs
        $monitor("Time: %0t | SW: %b | modein: %b | mode: %b | fan: %b | disp: %b", 
                 $time, SW, modein, mode, fan, disp);

        // Test Case 1: Reset mode (SW=0, modein=0)
        #10;
        SW = 0; modein = 0;
        #10;

        // Test Case 2: Increase mode (SW=1, modein=1)
        SW = 1; modein = 1;
        #10;

        // Test Case 3: Increase mode again
        SW = 1; modein = 1;
        #10;

        // Test Case 4: Decrease mode (SW=1, modein=0)
        SW = 1; modein = 0;
        #10;

        // Test Case 5: Reset mode again
        SW = 0; modein = 0;
        #10;

        // Test Case 6: Test max mode and boundary conditions
        SW = 1; modein = 1;
        #10;
        SW = 1; modein = 1;
        #10;
        SW = 1; modein = 1;
        #10;
        SW = 1; modein = 1;
        #10;  // mode should be at maximum (3'b100)

        // Test Case 7: Attempt to increase mode beyond max
        SW = 1; modein = 1;
        #10;

        // Test Case 8: Decrease mode from max
        SW = 1; modein = 0;
        #10;

        // Test Case 9: Decrease mode to minimum
        SW = 1; modein = 0;
        #10;
        SW = 1; modein = 0;
        #10;
        SW = 1; modein = 0;
        #10;
        SW = 1; modein = 0;
        #10;  // mode should be at minimum (3'b000)

        // Test Case 10: Attempt to decrease mode beyond min
        SW = 1; modein = 0;
        #10;

        // Finish the simulation
        $stop;
    end

endmodule

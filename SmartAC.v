module SmartAC(
    input wire SW,
    input wire clk,
    input wire modein,
    output reg [2:0] mode,
    output reg [2:0] fan,
    output reg [6:0] disp
);

    // Parameters for mode and fan speed limits
    parameter MIN_MODE = 3'b000;
    parameter MAX_MODE = 3'b100;
    parameter FAN_OFF = 3'b000;
    parameter FAN_LOW = 3'b001;
    parameter FAN_MEDIUM = 3'b010;
    parameter FAN_HIGH = 3'b011;

    // Main control logic
    always @(posedge clk) begin
        case ({SW, modein})
            2'b00: mode <= MIN_MODE;  // Reset mode
            2'b01: mode <= MIN_MODE;  // Reset mode
            2'b10: if (mode > MIN_MODE) mode <= mode - 1; // Decrease mode
            2'b11: if (mode < MAX_MODE) mode <= mode + 1; // Increase mode
            default: mode <= MIN_MODE;  // Default mode
        endcase
    end

    // Fan control based on mode
    always @(mode) begin
        case (mode)
            MIN_MODE: fan <= FAN_OFF;
            3'b001: fan <= FAN_LOW;
            3'b010: fan <= FAN_MEDIUM;
            3'b011: fan <= FAN_HIGH;
            3'b100: fan <= FAN_HIGH;
            default: fan <= FAN_OFF;  // Safety off
        endcase
    end

    // 7-segment display logic
    always @(mode) begin
        case (mode)
            3'b000: disp = 7'b111_1001; // Display 1
            3'b001: disp = 7'b010_0100; // Display 2
            3'b010: disp = 7'b011_0000; // Display 3
            3'b011: disp = 7'b001_1001; // Display 4
            3'b100: disp = 7'b001_0010; // Display 5
            default: disp = 7'b011_1111; // Display "-"
        endcase
    end

endmodule

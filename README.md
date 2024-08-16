# SmartAC Module

## Overview

The `SmartAC` module is a Verilog hardware description for a simple smart air conditioning system. It controls the operating mode, fan speed, and displays the current mode on a 7-segment display. The module is designed to be integrated into an FPGA or similar digital hardware for real-time operation.

## Features

- **Mode Control**: The module supports 5 modes, ranging from `000` to `100`. The mode can be increased or decreased based on input signals.
- **Fan Speed Control**: The fan speed is automatically adjusted based on the current mode.
- **7-Segment Display**: The current mode is displayed on a 7-segment display, with support for modes 1 through 5.

## Inputs and Outputs

### Inputs
- `SW` (1-bit, wire): Switch input used to control mode changes.
- `clk` (1-bit, wire): Clock signal used to synchronize operations.
- `modein` (1-bit, wire): Mode input signal used in conjunction with `SW` to adjust modes.

### Outputs
- `mode` (3-bit, reg): Current mode of the AC system. Values range from `000` (minimum) to `100` (maximum).
- `fan` (3-bit, reg): Fan speed control signal. Values can be `FAN_OFF`, `FAN_LOW`, `FAN_MEDIUM`, or `FAN_HIGH`.
- `disp` (7-bit, reg): 7-segment display output that shows the current mode.

## Parameters

- `MIN_MODE`: Minimum operating mode, set to `3'b000`.
- `MAX_MODE`: Maximum operating mode, set to `3'b100`.
- `FAN_OFF`: Fan off state, set to `3'b000`.
- `FAN_LOW`: Low fan speed, set to `3'b001`.
- `FAN_MEDIUM`: Medium fan speed, set to `3'b010`.
- `FAN_HIGH`: High fan speed, set to `3'b011`.

## Operation

### Mode Control Logic
The mode of the AC system is controlled based on the inputs `SW` and `modein`. Depending on the combination of these inputs:
- When `SW = 0` and `modein = 0`, the mode is reset to the minimum (`MIN_MODE`).
- When `SW = 1` and `modein = 0`, the mode is decreased by one, if it is greater than `MIN_MODE`.
- When `SW = 1` and `modein = 1`, the mode is increased by one, if it is less than `MAX_MODE`.

### Fan Speed Logic
The fan speed is automatically determined based on the current mode:
- Mode `000`: Fan off (`FAN_OFF`).
- Mode `001`: Low speed (`FAN_LOW`).
- Mode `010`: Medium speed (`FAN_MEDIUM`).
- Mode `011` and `100`: High speed (`FAN_HIGH`).

### 7-Segment Display Logic
The `disp` output is a 7-bit signal representing the current mode on a 7-segment display:
- Mode `000`: Displays `1`.
- Mode `001`: Displays `2`.
- Mode `010`: Displays `3`.
- Mode `011`: Displays `4`.
- Mode `100`: Displays `5`.
- Any invalid mode will display `-`.

## Usage

To use this module, instantiate it in your Verilog project and connect the inputs and outputs as needed. Ensure that the `clk` input is properly driven by a clock signal, and `SW` and `modein` are controlled as per your requirements.

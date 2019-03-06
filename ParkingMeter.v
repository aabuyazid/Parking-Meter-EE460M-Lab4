`timescale 1ns / 1ps

module ParkingMeter(
    input clk,
    input u, l, r, d,
    input sw0, sw1,
    output [3:0] an,
    output [6:0] sseg
);

wire SSEGclk, second, half_second;

wire below200; // if high, should start blinking

wire [15:0] adder_value, decrement_value, digits;

wire [27:0] sev_seg_data;

// All clocks used 
Second sec (.clk(clk),.second(second));
HalfSecond half (.clk(clk),.half_second(half_second));
SSEGClkDivider Sclk (.clk(clk),.slow_clk(SSEGclk));

// Missing Incrementer
    
Decrementer dec (.second(second),.half_second(half_second),
    .adder_value(adder_value),.decrement_value(decrement_value),
    .below200(below200));

DisplayController dis (.clk(clk),.meter_data(decrement_value),
    .an(an),.sseg(sseg));
    
 endmodule
 
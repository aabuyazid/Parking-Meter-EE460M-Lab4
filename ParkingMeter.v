`timescale 1ns / 1ps

module ParkingMeter(
    input clk,
    input u, l, r, d,
    input sw0, sw1,
    output dp,
    output [3:0] an,
    output [6:0] sseg
);

wire SSEGclk, second, half_second;

wire below200, isZero; // if high, should start blinking

wire [15:0] curr_time, digits;

wire [27:0] sev_seg_data;

assign dp = 1;

// All clocks used 
Second sec (.clk(clk),.second(second));
HalfSecond half (.clk(clk),.half_second(half_second));

ParkingMeterController con (.clk(clk),.u(u),.l(l),.r(r),.d(d),.sw0(sw0),
    .sw1(sw1),.curr_time(curr_time),.below200(below200),.isZero(isZero));

DisplayController dis (.clk(clk),.second(second),.half_second(half_second),.isZero(isZero),
    .below200(below200),.meter_data(curr_time), .an(an),.sseg(sseg));
    
 endmodule
 
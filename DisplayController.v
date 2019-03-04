`timescale 1ns / 1ps

module DisplayController(
    input clk,
    input [15:0] meter_data,
    output [3:0] an,
    output [6:0] sseg
);

wire [15:0] digits; 

wire [27:0] sev_seg_data;

wire slow_clk, second;

SSEGClkDivider div1 (.clk(clk), .slow_clk(slow_clk));

bin2BCD b1 (.bin_value(fitbit_data),.BCD_value(digits));

hexto7segment left (.x(digits[15:12]),.r(sev_seg_data[27:21]));
hexto7segment mid_left (.x(digits[11:8]),.r(sev_seg_data[20:14]));
hexto7segment mid_right (.x(digits[7:4]),.r(sev_seg_data[13:7]));
hexto7segment right (.x(digits[3:0]),.r(sev_seg_data[6:0]));

ParkingMeterDisplay d1 (.clk(slow_clk), .second(second), .sev_seg_data(sev_seg_data),.an(an),.sseg(sseg));

endmodule

`timescale 1ns / 1ps

module bin2BCD(
    input [15:0] bin_value,
    input is_miles,
    output reg [15:0] BCD_value 
    );
    reg [15:0] temp;

    always @ (*) begin
        temp = bin_value;
        BCD_value [3:0] = temp % 10;
        temp = temp/10;
        BCD_value [7:4] = temp % 10;
        temp = temp/10;
        BCD_value [11:8] = temp % 10;
        temp = temp/10;
        BCD_value [15:12] = temp % 10;
    end    
endmodule

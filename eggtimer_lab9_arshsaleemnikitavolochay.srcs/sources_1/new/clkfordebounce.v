`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2022 02:30:06 AM
// Design Name: 
// Module Name: clkfordebounce
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clkfordebounce(
    input clock_in,enable,
    output reg clock_out
    );
    reg[27:0] counter=28'd0;
    parameter DIVISOR = 28'd750000;
    always @(posedge clock_in)
    begin
        if(enable)
        begin
            counter <= counter + 1;
            if(counter == DIVISOR) 
            begin
                counter <= 0;
                clock_out <= ~clock_out;
            end
        end
    end
endmodule


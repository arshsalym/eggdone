`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2022 11:00:26 PM
// Design Name: 
// Module Name: ClocktoSecond
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


module ClocktoSecond(
    input clk,
    output reg clkOut
    );
    
reg [27:0] counter = 28'd0;
    parameter DIVISOR = 28'd5000000;
    always @(posedge clk)
    begin
        
            counter <= counter + 1;
            if(counter == DIVISOR)
            begin
                counter <= 0;
                clkOut <= ~clkOut;
            end
        
    end    
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2022 06:30:39 PM
// Design Name: 
// Module Name: Cook_Time
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


module Cook_Time(
    input clk,
    input InMin,
    input InSec,
    input cooktime,
    
    output reg [3:0] cook_sec,
    output reg [3:0] cook_tensec,
    output reg [3:0] cook_min,
    output reg [3:0] cook_tenmin
    );
    
    parameter COUNT_SIZE = 4;
        
        initial cook_sec = 4'b0000;
        initial cook_tensec = 4'b0000;
        initial cook_min = 4'b0000;
        initial cook_tenmin = 4'b0000;
        
        
        always @(posedge clk)
            begin
            if(cooktime)
                begin
                
                if(~InMin & InSec)
                begin
                    cook_min <= cook_min;
                    cook_tenmin <= cook_tenmin;
                    
                    if(~(cook_sec == 4'b1001)) 
                        cook_sec <= cook_sec +1;
                    else if (cook_sec == 4'b1001)
                        if(~(cook_tensec == 4'b0101))
                            begin
                            cook_tensec <= cook_tensec +1;
                            cook_sec = 4'b0000;
                            end
                        else if(cook_tensec == 4'b0101)
                            begin
                            cook_sec = 4'b0000;
                            cook_tensec = 4'b0000;
                            end
                end        
                            
                else if(~InSec & InMin)
                begin
                    cook_sec <= cook_sec;
                    cook_tensec <= cook_tensec;
                    
                    if(~(cook_min == 4'b1001)) 
                        cook_min <= cook_min +1;
                    else if (cook_min == 4'b1001)
                        if(~(cook_tenmin == 4'b0101))
                            begin
                            cook_tenmin <= cook_tenmin +1;
                            cook_min = 4'b0000;
                            end
                        else if(cook_tenmin == 4'b0101)
                            begin
                            cook_min = 4'b0000;
                            cook_tenmin = 4'b0000;
                            end
                end      
                else
                    begin
                    cook_sec <= cook_sec;
                    cook_tensec <= cook_tensec;
                    cook_min <= cook_min;
                    cook_tenmin <= cook_tenmin;
                    end
            end
        end            
endmodule

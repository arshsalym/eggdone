`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2022 02:58:40 PM
// Design Name: 
// Module Name: Master_Controller_NOSSD
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


module Master_Controller_NOSSD(
    input enable,
input reset,
input clk,
input cooktime,
input start,
input InMin,
input InSec,
output reg [3:0] sec,
output reg [3:0] tensec,
output reg [3:0] min,
output reg [3:0] tenmin,
output ENABLE,
output TIMERSTATUS
);

//Output wires for countdown

wire[3:0] cout_sec;
wire[3:0] cout_tensec;
wire[3:0] cout_min;
wire[3:0] cout_tenmin;
wire done;
//Output wires for cooktime

wire[3:0] cook_sec;
wire[3:0] cook_tensec;
wire[3:0] cook_min;
wire[3:0] cook_tenmin;


reg [1:0] refresh = 2'b00;
reg [3:0] x;



Count_Time countdown(.clk(clk), .enable(enable), .reset(reset), .start(start), .load_sec(cook_sec), .load_tensec(cook_tensec), .load_min(cook_min), .load_tenmin(cook_tenmin), .cout_sec(cout_sec), .cout_tensec(cout_tensec), .cout_min(cout_min), .cout_tenmin(cout_tenmin), .done(done), .timerstatus(TIMERSTATUS));
clkfordebounce debclk(.clock_in(clk), .clock_out(dbclk), .enable(1));
Cook_Time cookOuttime(.clk(clk), .InMin(InMin), .InSec(InSec), .cooktime(cooktime), .cook_sec(cook_sec), .cook_tensec(cook_tensec), .cook_min(cook_min), .cook_tenmin(cook_tenmin));

assign ENABLE = enable;

always @(posedge clk)
    begin
    
    if(cooktime)
        begin
        sec <= cook_sec;
        tensec <= cook_tensec;
        min <= cook_min;
        tenmin <= cook_tenmin;
        end
        
    else if (~(cooktime))
        begin
        if (~(reset)) 
            begin
            sec <= cout_sec;
            tensec <= cout_tensec;
            min <= cout_min;
            tenmin <= cout_tenmin;
            end
        else
            begin
            sec <= 0;
            tensec <= 0;
            min <= 0;
            tenmin <= 0;
            end
    end
    end     



endmodule

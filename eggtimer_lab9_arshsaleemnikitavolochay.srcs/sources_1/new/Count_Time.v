`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2022 10:53:47 PM
// Design Name: 
// Module Name: Count_Time
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


module Count_Time(
    input clk,
    input enable,
    input reset,
    input start,
    input [3:0] load_sec,
    input [3:0] load_tensec,
    input [3:0] load_min,
    input [3:0] load_tenmin,
    output reg [3:0] cout_sec,
    output reg [3:0] cout_tensec,
    output reg [3:0] cout_min,
    output reg [3:0] cout_tenmin,
    output reg done,
    output reg timerstatus
    );
    
    parameter COUNT_SIZE = 4;
    
    initial cout_sec = 4'b0000;
    initial cout_tensec = 4'b0000;
    initial cout_min = 4'b0000;
    initial cout_tenmin = 4'b0000;
    
    initial done = 0;
    
    always @(posedge clk)
        begin
        if (~(reset))
        begin
            if(enable & ~start)
                begin
                if(~(cout_sec == 4'b0)) 
                    begin
                    cout_sec <= cout_sec -1;
                    timerstatus = 1;
                    end
                else if (cout_sec == 4'b0)
                    if(~(cout_tensec == 4'b0))
                        begin
                        cout_tensec <= cout_tensec -1;
                        cout_sec = 4'b1001;
                        end
                    else if(cout_tensec == 4'b0)
                            if(~(cout_min == 4'b0))
                            begin
                            cout_min <= cout_min -1;
                            cout_tensec = 4'b0101;
                            cout_sec = 4'b1001;
                            end
                        else if(cout_min == 4'b0)
                            if(~(cout_tenmin == 4'b0))
                                begin
                                cout_tenmin <= cout_tenmin -1;
                                cout_min = 4'b1001;
                                cout_tensec = 4'b0101;
                                cout_sec = 4'b1001;
                                end
                            else if(cout_tenmin == 4'b0)
                                done = 1;            
                end
            else if(enable & start)
                begin
                cout_sec <= load_sec;
                cout_tensec <= load_tensec;
                cout_min <= load_min;
                cout_tenmin <= load_tenmin;    
                done = 0; 
                end
            else
                begin
                cout_sec <= cout_sec;
                timerstatus = 0;
                done = 0; 
                end
            end
        else
            begin
            cout_sec <= 0;
            cout_tensec <= 0;
            cout_min <= 0;
            cout_tenmin <= 0;  
            done = 0;  
            end
       end
endmodule

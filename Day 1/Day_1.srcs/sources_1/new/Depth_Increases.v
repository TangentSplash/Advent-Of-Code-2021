`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Engineer: CJC
// 
// Create Date: 01.12.2021
// Design Name: Depth_Increases
// Module Name: Depth_Increases
// Description: 
//////////////////////////////////////////////////////////////////////////////////


module Depth_Increases(
    input clock,
    input reset,
    input [13:0] depth,
    input new_reading,
    output reg [10:0] num_increases
    );
    
    reg [13:0] V1_curr,V1_next,V2_curr,V2_next;
    wire increase;
    reg [10:0] increases_next;
    
    always @ (posedge clock)
    begin
        if (reset)
        begin
            V1_curr <= 14'hffe;
            V2_curr <= 14'hfff;
            num_increases =11'd0;
        end
        else
        begin
            V1_curr <= V1_next;
            V2_curr <= V2_next;
            num_increases = increases_next;
        end
    end
    
    always @ ( * ) 
        if (new_reading)
        begin
            V1_next = depth;
            V2_next = V1_curr;
        end
        else
        begin
            V1_next = V1_curr;
            V2_next = V2_curr; 
        end
    
    assign increase = (V1_curr > V2_curr);  
    
    always @ (posedge clock)
    begin
        if(reset)
            increases_next = 11'd0;
        else if (new_reading && increase)
            increases_next = num_increases+1'b1;
        else
            increases_next = num_increases;
    end
endmodule

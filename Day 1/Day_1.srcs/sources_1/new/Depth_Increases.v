`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Engineer: CJC
// 
// Create Date: 01.12.2021
// Design Name: Depth_Increases
// Module Name: Depth_Increases
// Description: Hardware to detect an increase between two sliding window sums
//////////////////////////////////////////////////////////////////////////////////


module Depth_Increases(
    input clock,
    input reset,
    input [13:0] depth,
    input new_reading,
    output reg [10:0] num_increases,
    output reg [14:0] V1prev,
    output reg [14:0] V2prev
    );
    
    reg [13:0] A_curr,A_next,B_curr,B_next,C_curr,C_next,D_curr,D_next;
    wire increase;
    reg [10:0] increases_next;
    wire [14:0] V1, V2;
    
    always @ (posedge clock)
    begin
        if (reset)
        begin
            A_curr <= 14'hffc;
            B_curr <= 14'hffd;
            C_curr <= 14'hffe;
            D_curr <= 14'hfff;
            num_increases =11'd0;
            V1prev <= 14'd0;
            V2prev <= 14'd0;
        end
        else
        begin
            A_curr <= A_next;
            B_curr <= B_next;
            C_curr <= C_next;
            D_curr <= D_next;
            num_increases = increases_next;
            V1prev <= V1;
            V2prev <= V2;
        end
    end
    
    always @ ( * ) 
        if (new_reading)
        begin
            A_next = depth;
            B_next = A_curr;
            C_next = B_curr;
            D_next = C_curr;
        end
        else
        begin
            A_next = A_curr;
            B_next = B_curr; 
            C_next = C_curr;
            D_next = D_curr;
        end
    assign V1 = A_curr+B_curr+C_curr;
    assign V2= B_curr + C_curr + D_curr;
    
    assign increase = (V1 > V2);  
    
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

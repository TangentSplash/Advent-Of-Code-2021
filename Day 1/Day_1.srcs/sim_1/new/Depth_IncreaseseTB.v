`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Engineer: CJC
// 
// Create Date: 01.12.2021
// Design Name: Depth_Increases
// Module Name: Depth_Increases Testbench
// Description: 
//////////////////////////////////////////////////////////////////////////////////


module Depth_IncreaseseTB;
    //Inputs
    reg clock, reset; 
    reg [13:0] depth;
    reg new_reading;
    
    //Output
    wire [10:0] num_increases;
    
    //Data
    reg [13:0] measurements [0:2000];
    integer outfile,infile,read;
    reg [10:0] prev_increases;
    
//Instantiate model    
Depth_Increases uut (clock,reset,depth,new_reading,num_increases);

   // Generate clock signal
   initial
     begin
	clock  = 1'b1;
	forever
	  #100 clock  = ~clock ;
     end
   // Generate other input signals
   initial
     // Init and reset
     begin
	reset = 1'b1;
	depth = 13'hfff;
	new_reading=1'b0;
	prev_increases=11'd0;
	
	//Read input into array
	//$readmemh("input.txt",measurements);
	
	infile = $fopen("input.txt","r");
	for (read=0; read<2000; read=read+1)
	begin
	   $fscanf(infile,"%d",measurements[read]);
	end
	$fclose(infile);
	
	//Setup Output File
	outfile = $fopen("output.txt");
	#800
	reset=1'b0;
	depth=measurements[0];
	new_reading=1'b1;
	#200
	new_reading=1'b0;
	#600
	depth=measurements[1];
	new_reading=1'b1;
	#200
	new_reading=1'b0;
	#600
	for (read=2; read<2000; read=read+1)
	begin
	   @ (posedge clock);
	       depth=measurements[read];
	       new_reading=1'b1;
       @ (posedge clock)
	       new_reading=1'b0;  
	       #600
	       if (num_increases>prev_increases)
	       begin
	           prev_increases = num_increases;
	           $fdisplay(outfile,"Depth %d is greater than depth %d. Number of increases is %d",measurements[read-1],measurements[read-2],num_increases);
	           $display("Depth %d is greater than depth %d. Number of increases is %d",measurements[read-1],measurements[read-2],num_increases);  
	       end
	       else
	       begin
	           $fdisplay(outfile,"Depth %d is not greater than depth %d. Number of increases is still %d",measurements[read-1],measurements[read-2],num_increases);
	           $display("Depth %d is not greater than depth %d. Number of increases is still %d",measurements[read-1],measurements[read-2],num_increases); 
	       end
	       @ (negedge clock); 
        end
        new_reading=1'b1;
        #200
        new_reading=1'b0;
        #200
        if (num_increases>prev_increases)
	       begin
	           prev_increases = num_increases;
	           $fdisplay(outfile,"Depth %d is greater than depth %d. Number of increases is %d",measurements[read-1],measurements[read-2],num_increases);
	           $display("Depth %d is greater than depth %d. Number of increases is %d",measurements[read-1],measurements[read-2],num_increases);  
	       end
	       else
	       begin
	           $fdisplay(outfile,"Depth %d is not greater than depth %d. Number of increases is still %d",measurements[read-1],measurements[read-2],num_increases);
	           $display("Depth %d is not greater than depth %d. Number of increases is still %d",measurements[read-1],measurements[read-2],num_increases); 
	       end
       #4000
       $fdisplay(outfile,"The total number of depth increases is %d",num_increases);
       $display("The total number of depth increases is %d",num_increases);
       $fclose(outfile);
       $stop;	
	end
endmodule

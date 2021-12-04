`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Engineer: CJC
// 
// Create Date: 03.12.2021
// Design Name: Binary Diagnostic
// Module Name: Binary_Diagnostic_TB
// Description: Hardware to detect an increase between two sliding window sums
//////////////////////////////////////////////////////////////////////////////////

module Binary_Diagnostic_TB;
	localparam CONSOLE = 1;		// file handle for printing to console

	// Inputs to module under test
	reg clock, reset, is_data;
	reg [11:0] bits;

	// Outputs from module under test
	wire [11:0]most;
	
	
	reg [11:0] stim [0:1000];
	
	// Internal testbench signals
	integer test;
	integer outfile;	// file handle

	// Instantiate the hardware modules
	Binary_Diagnostic Bit0 (.clock(clock),.reset(reset),.data(is_data),.bit(bits[0]),.most(most[0]));
    Binary_Diagnostic Bit1 (.clock(clock),.reset(reset),.data(is_data),.bit(bits[1]),.most(most[1]));
    Binary_Diagnostic Bit2 (.clock(clock),.reset(reset),.data(is_data),.bit(bits[2]),.most(most[2]));
    Binary_Diagnostic Bit3 (.clock(clock),.reset(reset),.data(is_data),.bit(bits[3]),.most(most[3]));
    Binary_Diagnostic Bit4 (.clock(clock),.reset(reset),.data(is_data),.bit(bits[4]),.most(most[4]));
    Binary_Diagnostic Bit5 (.clock(clock),.reset(reset),.data(is_data),.bit(bits[5]),.most(most[5]));
    Binary_Diagnostic Bit6 (.clock(clock),.reset(reset),.data(is_data),.bit(bits[6]),.most(most[6]));
    Binary_Diagnostic Bit7 (.clock(clock),.reset(reset),.data(is_data),.bit(bits[7]),.most(most[7]));
    Binary_Diagnostic Bit8 (.clock(clock),.reset(reset),.data(is_data),.bit(bits[8]),.most(most[8]));
    Binary_Diagnostic Bit9 (.clock(clock),.reset(reset),.data(is_data),.bit(bits[9]),.most(most[9]));
    Binary_Diagnostic Bit10 (.clock(clock),.reset(reset),.data(is_data),.bit(bits[10]),.most(most[10]));
    Binary_Diagnostic Bit11 (.clock(clock),.reset(reset),.data(is_data),.bit(bits[11]),.most(most[11]));
    
	// Generate clock signal at 10 MHz
	initial 
		begin
			clock = 1'b0;  // clock starts at 0
			forever
				#50 clock = ~clock;	// invert clock every 50 ns
		end
	
	// Apply input signals and check results
	initial
		begin
			reset = 1'b1;		// set all inputs to 0 at start
			is_data = 1'b0;
			
			#200
			reset=1'b0;
			is_data=1'b1;
			
			// Read test vectors from file into array
			$readmemb("input.txt", stim);
			
			// Open file for recording results
			outfile = $fopen("BinaryDiagnostics_results.txt");
			
			for (test = 0; test < 1000; test = test + 1)
				begin
					@ (negedge clock);	// wait for negedge of clock, then apply stimulus
					bits=stim[test];
				end
			@(negedge clock)
            is_data=1'b0;

			#200;		// run another 2 clock cycles, then summarise results
            $fdisplay(outfile|CONSOLE, "MCB are %b therfore LCB are %b",most,~most);
            $fdisplay(outfile|CONSOLE, "MCB has value %d and LCB has value %d",most,~most);
            $fdisplay(outfile|CONSOLE, "The answer is therefore %d",(most)*(~most));

			$fclose(outfile);		// close the output file
			$stop;					// stop the simulation	
		end	// end initial block

endmodule

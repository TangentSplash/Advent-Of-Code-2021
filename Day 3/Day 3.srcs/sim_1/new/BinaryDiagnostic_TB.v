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
	localparam NOBITS = 12;
	localparam NOREADINGS = 1000;

	// Inputs to module under test
	reg clock, reset;
	reg [NOBITS-1:0] is_data;
	reg [NOBITS-1:0] bits;

	// Outputs from module under test
	wire [NOBITS-1:0]most;

	// Internal testbench signals
	integer test,i,j,length;
	integer outfile;	// file handle
	reg [NOBITS:0] stim [0:NOREADINGS];
	integer run;   //Run 0 for oxegyn, Run 1 for CO2
	reg [NOBITS-1:0] ans [0:1],bitno;
    genvar k;
	// Instantiate the hardware modules
	for (k=0;k<NOBITS;k=k+1)
	begin: Instantiate
	   Binary_Diagnostic Bit (.clock(clock),.reset(reset),.data(is_data[k]),.bit(bits[k]),.most(most[k]));
	end

    
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
		
		    // Open file for recording results
			outfile = $fopen("BinaryDiagnostics_results.txt");
			
			for (run=0;run<2;run=run+1)
			begin
                reset = 1'b1;		// set all inputs to 0 at start
                is_data = 12'd0;
                
                #200
                reset=1'b0;
                is_data=12'b100000000000;
                //is_data=12'b000000010000;
                bitno=12'd0;
                
                // Read test vectors from file into array
                $readmemb("input.txt", stim);
                //$readmemb("inputtest.txt", stim);
                   
                i=NOBITS-1;
                length=NOREADINGS;
                while (length > 1)
                begin
                    for (test = 0; test < length; test = test + 1)
                        begin
                            @ (negedge clock);	// wait for negedge of clock, then apply stimulus
                            bits=stim[test];
                        end
                    @(negedge clock)
                    bitno=is_data;
                    is_data=12'd0;
        
                    #200;		// run another 2 clock cycles, then summarise results
                    $fdisplay(outfile|CONSOLE, "Run %d, bit %d, Most Common Bit is %b",run,i,most[i]);
                    j=0;
                    for (test=0;test<length;test=test+1)
                    begin
                        if((!run && stim[test][i]==most[i]) || (run && stim[test][i]==!(most[i])))
                        begin
                            stim[j]=stim[test];
                            $fdisplay(1,"%b",stim[j]);
                            j=j+1;
                        end
                    end
                    length=j;
                    i=i-1;
                    is_data=bitno >> 1;
                    $fdisplay(outfile|CONSOLE, "Run %d,%d values remaining",run,length);
                end
                $fdisplay(outfile|CONSOLE, "Finished run %d",run);
                ans[run]=stim[0];
            end
            
            $fdisplay(outfile|CONSOLE, "Oxegyn value is %b, which equals %d",ans[0],ans[0]);
            $fdisplay(outfile|CONSOLE, "C02 value is    %b, which equals %d",ans[1],ans[1]);
            $fdisplay(outfile|CONSOLE, "This means the answer is %d",ans[0]*ans[1]);

			$fclose(outfile);		// close the output file
			$stop;					// stop the simulation	
		end	// end initial block

endmodule

module testbench2();

timeunit 10ns;	// Half clock cycle at 50 MHz
				// This is the amount of time represented by #1
timeprecision 1ns;

// These signals are internal because the processor will be
// instantiated as a submodule in testbench.
logic [9:0] SW;
logic	Clk, Run, Continue;
logic [9:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3;
logic [15:0] PC_val, MDR_val, MAR_val, IR_val,BUS_val;
logic [15:0] R0_val, R1_val,R2_val, R3_val;
	

		slc3_testtop tp(.*);
assign PC_val = tp.slc.PC;
assign MDR_val = tp.slc.MDR;
assign MAR_val = tp.slc.MAR;
assign IR_val = tp.slc.IR;
assign BUS_val = tp.slc.d0.BUS_val;
assign R0_val = tp.slc.d0.register.R0.Data_Out;
assign R1_val = tp.slc.d0.register.R1.Data_Out;
assign R2_val = tp.slc.d0.register.R2.Data_Out;
assign R3_val = tp.slc.d0.register.R3.Data_Out;

	always begin : CLOCK_GENERATION
				
				#1 Clk = ~Clk;
				
			 end
			 
	initial begin : CLOCK_INITIALIZATION
					
					Clk = 0;
			
			end
		
	initial begin:Test
	
	Run = 1;
	Continue = 1;
	
	#2 Run = 0;
			Continue = 0;
	#2 Run = 1;
			Continue = 1;
	#2
		SW = 10'b0000000011;
	#2 Run = 0;
	#2 Run = 1;

	
	end
	
endmodule

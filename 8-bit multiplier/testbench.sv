module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
				// This is the amount of time represented by #1
timeprecision 1ns;

// These signals are internal because the processor will be
// instantiated as a submodule in testbench.
logic Clk = 0;
logic Run, Reset_Load_Clear;
logic [7:0] S;
logic [7:0] Aval, Bval;
logic X;
logic [6:0] AhexL, AhexU, BhexL, BhexU;

// To store expected results
logic [7:0] ans_a, ans_b;

// A counter to count the instances where simulation results
// do not match with expected results
integer ErrorCnt = 0;

// Instantiating the DUT
// Make sure the module and signal names match with those in your design
multiplier multi(.*);

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always #1 Clk = ~Clk;

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin 
	Run = 1;
	Reset_Load_Clear = 1;
	
//ex1: 3x-1
	S = 8'b00000011; // 3


	#2 Reset_Load_Clear = 0; 
	#2 Reset_Load_Clear = 1; 

	#10 S = 8'b00000001; // -1

	#2 Run = 0;

	#2 Run = 1;
	
	ans_a = 8'hff;
	ans_b = 8'hfd;

	if (Aval != ans_a || Bval != ans_b)
		ErrorCnt++;
		

	
	if (ErrorCnt == 0)
		$display("Success!");
	else
		$display("%d error(s) detected. Try again!", ErrorCnt);

end

endmodule

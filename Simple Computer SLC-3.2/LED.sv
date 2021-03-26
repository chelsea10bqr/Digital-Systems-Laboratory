module LED	( input logic Clk,
                        LD_LED,
				  input logic [9:0] IR,
				  output logic [9:0] LED
);
	always_ff @ (posedge Clk)
	begin
	      LED <= 10'h0;
	
		if (LD_LED)
			LED <= IR[9:0];
	
	end
	
endmodule

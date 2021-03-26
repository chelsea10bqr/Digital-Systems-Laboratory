module mux_bus
(
	input  logic [15:0] In_0,
							  In_1,
							  In_2,
							  In_3,
	input  logic [3:0]  S,
	output logic [15:0] Out
);

	always_comb
	begin
	
		case (S)
			4'b0001: Out = In_0;
			4'b0010: Out = In_1;
			4'b0100: Out = In_2;
			4'b1000: Out = In_3;
			default: Out = 16'b0;
		endcase
	
	end

endmodule

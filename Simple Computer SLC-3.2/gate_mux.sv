module gate_mux
(
	input  logic In_0,
					 In_1,
					 In_2,
					 In_3,
	output logic [1:0] Out
);

	always_comb
	begin
	
		case ({ In_3, In_2, In_1, In_0 })
			4'b0001: Out = 2'b00;
			4'b0010: Out = 2'b01;
			4'b0100: Out = 2'b10;
			4'b1000: Out = 2'b11;
			default: Out = 2'bxx;
		endcase
		
	end

endmodule
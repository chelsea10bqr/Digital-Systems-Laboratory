module mux_2 
#(parameter n = 16)
(
					input  logic S,
					input  logic [n-1:0] In_0, In_1,
					output logic [n-1:0]Out
					);
					
		always_comb
			begin
				if (S)
					Out = In_1;
				else
					Out = In_0;
			end
			
endmodule
module mux_4
#(parameter n = 16)
 (
					input  logic [1:0] S,
					input  logic [n-1:0] In_0, In_1, In_2, In_3,
					output logic [n-1:0] Out
					);
					
		always_comb
			begin
				case (S)
					2'b00 :
						Out = In_0;
					2'b01 :
						Out = In_1;
					2'b10 :
						Out = In_2;
					2'b11 :
						Out = In_3;
				endcase		
				
			end
			
endmodule
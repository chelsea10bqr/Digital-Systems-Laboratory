module ALU
 (
					input  logic [15:0] SR1_out,SR2MUX_temp,
					input  logic [1:0]ALUK,
					output logic [15:0] ALU_val
					);

					always_comb
					begin
							case (ALUK)
								2'b00: ALU_val = SR1_out + SR2MUX_temp;
								2'b01: ALU_val = SR1_out & SR2MUX_temp;
								2'b10: ALU_val = ~SR1_out;
								2'b11: ALU_val = SR1_out;
							endcase
					end
					
endmodule
								
							
module register_file
(
	input  logic		  Clk, Reset, LD_REG,
	input  logic [15:0] BUS_val,
	input  logic [2:0]  DR_val,
							  SR1_val,
							  SR2_val,
	output logic [15:0] SR1_Out,
							  SR2_Out
);

	logic [15:0] REG_Out [8];
	
	logic Load0, Load1, Load2, Load3, Load4, Load5, Load6, Load7;

	assign SR1_Out = REG_Out[SR1_val];
	assign SR2_Out = REG_Out[SR2_val];

	reg_16 R0 (.*, .Load(Load0), .Data_In(BUS_val), .Data_Out(REG_Out[0]));
	reg_16 R1 (.*, .Load(Load1), .Data_In(BUS_val), .Data_Out(REG_Out[1]));
	reg_16 R2 (.*, .Load(Load2), .Data_In(BUS_val), .Data_Out(REG_Out[2]));
	reg_16 R3 (.*, .Load(Load3), .Data_In(BUS_val), .Data_Out(REG_Out[3]));
	reg_16 R4 (.*, .Load(Load4), .Data_In(BUS_val), .Data_Out(REG_Out[4]));
	reg_16 R5 (.*, .Load(Load5), .Data_In(BUS_val), .Data_Out(REG_Out[5]));
	reg_16 R6 (.*, .Load(Load6), .Data_In(BUS_val), .Data_Out(REG_Out[6]));
	reg_16 R7 (.*, .Load(Load7), .Data_In(BUS_val), .Data_Out(REG_Out[7]));

	always_comb
	begin
	
		Load0 = 1'b0;
		Load1 = 1'b0;
		Load2 = 1'b0;
		Load3 = 1'b0;
		Load4 = 1'b0;
		Load5 = 1'b0;
		Load6 = 1'b0;
		Load7 = 1'b0;
	
		case (DR_val)
			3'b000: Load0 = LD_REG; 
			3'b001: Load1 = LD_REG;
			3'b010: Load2 = LD_REG;
			3'b011: Load3 = LD_REG;
			3'b100: Load4 = LD_REG;
			3'b101: Load5 = LD_REG;
			3'b110: Load6 = LD_REG;
			3'b111: Load7 = LD_REG;
		endcase
	
	end

endmodule

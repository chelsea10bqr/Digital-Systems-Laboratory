module nzp_ben (
	input logic Clk,Reset,LD_CC,LD_BEN,
	input logic [15:0] BUS_val,
	input logic [2:0] IR_in,
	output logic BEN_val
);
	logic BEN_temp;
	logic [2:0] NZP_temp,NZP_out;
	always_ff @ (posedge Clk) begin
		if(Reset)
			BEN_temp <= 1'b0;
			
		BEN_temp <= (IR_in[2] & NZP_out[2]) | (IR_in[1] & NZP_out[1]) | (IR_in[0] & NZP_out[0]);
			
	end
	
			reg_1 benv(.*,.Load(LD_BEN),.Data_In(BEN_temp),.Data_Out(BEN_val));
	
	always_comb begin
			NZP_temp = 3'b001;
			
			if(BUS_val == 16'h0000) 
				NZP_temp = 3'b100;
			else if(BUS_val[15] == 1'b1) 
				NZP_temp = 3'b010;
		end 
		
	 reg_3 nzpv (.*, .Load(LD_CC),.Data_In(NZP_temp),.Data_Out(NZP_out));
	 
	 
endmodule 

		
	
	
module datapath (input  logic 	Clk, 
												Reset,
											   LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
												GateMDR, GatePC, GateALU,GateMARMUX,
												MIO_EN,SR2MUX, ADDR1MUX, MARMUX, DRMUX, SR1MUX,
							 input logic  [1:0] PCMUX, ADDR2MUX, ALUK,
                      input  logic [15:0] MDR_In,
                      output logic [15:0] IR_Out, PC_Out, MAR_Out, MDR_Out,
							 output logic BEN,
							 output logic [9:0] LED
							 );
							 
					
	 logic [15:0] PCMUX_temp,MDRMUX_temp,SR2MUX_temp,ADDR1MUX_temp, ADDR2MUX_temp;
	 logic [15:0] PC_val,IR_val,MAR_val,MDR_val,BUS_val,ADDR_val,ALU_val;
	 logic [3:0] Gate;
	 logic [2:0] dr_mux,sr1_mux;
	 logic [15:0] SR1_out,SR2_out, SEXT5, SEXT6, SEXT9, SEXT11;
	 logic BEN_val;
	 
	 assign PC_Out = PC_val;
	 assign IR_Out = IR_val;
	 assign MAR_Out = MAR_val;
	 assign MDR_Out = MDR_val;
	 assign BEN = BEN_val;
	 assign Gate = {GateMARMUX, GateALU, GateMDR, GatePC};
	 assign ADDR_val = ADDR1MUX_temp+ADDR2MUX_temp;
	 
	 assign SEXT5 = 16'(signed'(IR_val[4:0]));
	 assign SEXT6 = 16'(signed'(IR_val[5:0]));
	 assign SEXT9 = 16'(signed'(IR_val[8:0]));
	 assign SEXT11 = 16'(signed'(IR_val[10:0]));
	 
	 
	// gate_mux gate (.In_0(GatePC),.In_1(GateMDR), .In_2(GateALU),.In_3(GateMARMUX),.Out(Gate));

	 
	 
	 mux_2 #(3) MUX_DR (.S(DRMUX),.In_0(IR_val[11:9]),.In_1(3'b111),.Out(dr_mux));
	 mux_2 #(3) MUX_SR1 (.S(SR1MUX),.In_0(IR_val[8:6]),.In_1(IR_val[11:9]),.Out(sr1_mux));
	 
	 register_file register (.*, .DR_val(dr_mux),.SR1_val(sr1_mux),.SR2_val(IR_val[2:0]),.SR1_Out(SR1_out),.SR2_Out(SR2_out));
		 
	 mux_2 MUX_SR2(.S(SR2MUX),.In_0(SR2_out), .In_1(SEXT5), .Out(SR2MUX_temp));
	 mux_2 MUX_ADDER1 (.S(ADDR1MUX),.In_0(PC_val),.In_1(SR1_out),.Out(ADDR1MUX_temp));
	 mux_4 MUX_ADDER2 (.S(ADDR2MUX),.In_0(16'h0),.In_1(SEXT6),.In_2(SEXT9),.In_3(SEXT11),.Out(ADDR2MUX_temp));
	 
	 ALU MUX_ALU (.*);
	 
	 nzp_ben NB (.*,.IR_in(IR_val[11:9]),.BEN_val(BEN_val));
	 
	 
	 
	 
	 mux_2 MUX_MDR (.S(MIO_EN),.In_0(BUS_val), .In_1(MDR_In), .Out(MDRMUX_temp));
	 mux_bus MUX_BUS (.In_0(PC_val), .In_1(MDR_val), .In_2(ALU_val), .In_3(ADDER_val),.S(Gate), .Out(BUS_val));
	 mux_4 MUX_PC  (.S(PCMUX ),.In_0(PC_val + 16'h0001), .In_1(ADDR_val), .In_2(BUS_val), .In_3(16'hxxxx), .Out(PCMUX_temp));
	 
	 LED ledset (.*, .IR(IR_val[9:0]));
	 
	 
	 
	 reg_16  PC (
					.Clk, 
					.Reset, 
					.Load(LD_PC),
	            .Data_In(PCMUX_temp), 
					.Data_Out(PC_val)
					);
    reg_16  IR (
					.Clk, 
					.Reset, 
					.Load(LD_IR),
	            .Data_In(BUS_val), 
					.Data_Out(IR_val)
					);
					

					
	 reg_16  MAR (
					.Clk, 
					.Reset, 
					.Load(LD_MAR),
	            .Data_In(BUS_val), 
					.Data_Out(MAR_val)
					);
					
    reg_16  MDR (
					.Clk, 
					.Reset, 
					.Load(LD_MDR),
	            .Data_In(MDRMUX_temp), 
					.Data_Out(MDR_val)
					);

endmodule
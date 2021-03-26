//8 bit multiplier
module multiplier
(
    input   logic           Clk,        	// // Internal
    input   logic           Run,      		// which is key 1
    input   logic           Reset_Load_Clear, // which is key 0.
    input   logic[7:0]      S,         	// slider switches
    
    output  logic           X,  	         // extend bit of A
	 output  logic[7:0]		 Aval,			// the output of RegA and Reg B
	 output  logic[7:0]		 Bval,
	 output  logic[6:0]      AhexU,  	   // Hex values for displaying on the board
    output  logic[6:0]      AhexL,
    output  logic[6:0]      BhexU,
    output  logic[6:0]      BhexL
);


    logic[7:0]     tempA,tempB,Adder,Sum;  //four temporary parameters for 9-bit adders

    logic[6:0]      Ahex0_comb,Ahex1_comb, Bhex0_comb, Bhex1_comb;  // internal wire for hex values
    
	 logic Load, Shift_En, Add, Sub, M, Clear,AddX,Reset, tempX; //declare internal parameter for input/output
	 
    always_ff @(posedge Clk) begin
			Aval <= tempA;                     //assign the result to output register
			Bval <= tempB;
			X <= tempX;
			Reset <= Reset_Load_Clear;         //divide the one key to another key for control unit
			
    end
    
 
    always_ff @(posedge Clk) begin
        AhexL <= Ahex0_comb;               //minimize the interference of delay
        AhexU <= Ahex1_comb;
        BhexL <= Bhex0_comb;
        BhexU <= Bhex1_comb;
    end
	 
	 always_comb begin            
		if (Sub)                      //this is for the subtraction if the 8-th bit is 1
			Adder = ~S;
		else if (~Add)
			Adder = 8'h00;
		else
			Adder = S;
		
		if (Clear)                   //if the clear signal is high, we will clear the X value
			tempX = 1'b0;
		else
			tempX = AddX;
	 end

	 
	 
	 
//define the control unit, which will manage the state machine, and load, clear signal	
	control	control_unit
	( .Clk, .Reset(Reset), .Run, .Reset_Load_Clear,.M(tempB[0]),
	  .Load,.Shift_En, .Add, .Sub, .Clear);
	  
// manage the two 8-bit register, A and B 
   register_unit reg_unit
	( .Clk,.ResetA((~Load)|(~Reset_Load_Clear)| Clear), .ResetB(1'b0), .A_In(tempX), .B_In(tempA[0]), .Ld_A(Add|Sub), 
	 .Ld_B(~Load), .Shift_En,.DA(Sum),.DB(S),.A(tempA),.B(tempB));


	 
// 9-bit adder, and if it does subtraction, then the two's complement +1 will be the sub signal sent to Carry in 
	nine_bit_fa FA9
	(.A9({tempA[7],tempA}),	 .B9({Adder[7],Adder}), .C_in(Sub),	 .Sum,.X(AddX)); 
	
	 
//output the hexvalue for displaying
	 
    HexDriver hex2
    (
        .In0(tempA[3:0]),                      
        .Out0(Ahex0_comb)
    );
    
    HexDriver hex3
    (
        .In0(tempA[7:4]),
        .Out0(Ahex1_comb)
    );
 
    
    HexDriver hex0
    (
        .In0(tempB[3:0]),
        .Out0(Bhex0_comb)
    );
    
    HexDriver hex1
    (
        .In0(tempB[7:4]),
        .Out0(Bhex1_comb)
    );
    
endmodule
	

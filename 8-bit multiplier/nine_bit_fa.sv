module nine_bit_fa
(
    input   logic[8:0] A9, B9,
	 input 	logic		C_in,
    output  logic[7:0]  Sum,
    output  logic     X
);
	
	 logic c1, c2, c3;  //temporary parameter for carry in 
	 full_adder4 fa1(.A4(A9[3:0]), .B4(B9[3:0]), .C_in, .Sum(Sum[3:0]), .C_out(c1));    // we use two 4-bit rca and one 1-bit full adder
	 full_adder4 fa2(.A4(A9[7:4]), .B4(B9[7:4]), .C_in(c1),   .Sum(Sum[7:4]), .C_out(c2));  // to implement 9-bit full adders
	 

	 
	 full_adder  fa3(.A(A9[8]), .B(B9[8]), .C_in(c2), .Sum(X),.C_out(c3));  //get the x
endmodule
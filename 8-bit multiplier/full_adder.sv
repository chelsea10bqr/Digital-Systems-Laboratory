module full_adder
(
    input   logic  A, B, C_in,
    output  logic  Sum, C_out
);

	 assign Sum = A^B^C_in;								//build the one bit adder module based on the formula
	 assign C_out = (A&B)|(A&C_in)|(B&C_in);		

endmodule

module full_adder4
(
    input   logic     [3:0]A4,B4,
	 input 	logic		 		C_in,
    output  logic     [3:0]Sum,
	 output 	logic				C_out
);

	 logic 	 c1,c2,c3;   //temporary parameter for carry in and out.
	 
	 full_adder fa5(.A(A4[0]),.B(B4[0]),.C_in(C_in),.Sum(Sum[0]),.C_out(c1));    //use four bit-adder to get the four-bit adder
	 full_adder fa6(.A(A4[1]), .B(B4[1]), .C_in(c1), .Sum(Sum[1]), .C_out(c2));
	 full_adder fa7(.A(A4[2]), .B(B4[2]), .C_in(c2), .Sum(Sum[2]), .C_out(c3));
	 full_adder fa8(.A(A4[3]), .B(B4[3]), .C_in(c3), .Sum(Sum[3]), .C_out(C_out));
	 
endmodule
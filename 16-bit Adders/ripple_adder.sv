module ripple_adder(
	input  [15:0] A, B,
	input         cin,
	output [15:0] S,
	output        cout
);



    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  logic C1,C2,C3;    // temporary parameter for carry in and out.
	  
	  four_bit_fa d1(.a_4(A[3:0]),.b_4(B[3:0]),.C_IN(cin),.SUM(S[3:0]),.C_OUT(C1));           // use 4x4 hierarchy to build the ripple_adder
	  four_bit_fa d2(.a_4(A[7:4]),.b_4(B[7:4]),.C_IN(C1),.SUM(S[7:4]),.C_OUT(C2));
	  four_bit_fa d3(.a_4(A[11:8]),.b_4(B[11:8]),.C_IN(C2),.SUM(S[11:8]),.C_OUT(C3));
	  four_bit_fa d4(.a_4(A[15:12]),.b_4(B[15:12]),.C_IN(C3),.SUM(S[15:12]),.C_OUT(cout));

     
endmodule


module full_adder(
	input logic a,b,c_in,
	output logic sum,c_out
	
);

	assign sum = a^b^c_in;                       // build the one bit adder module based on the formula
	assign c_out = (a&b)|(b&c_in)|(a&c_in);  
	
endmodule 

module four_bit_fa(                             //build the module for four-bit full adder
	input logic [3:0] a_4,b_4,
	input logic C_IN,
	output logic [3:0] SUM,
	output logic C_OUT
);
	
	logic c1,c2,c3;             // temporary parameter for carry in and out.
	
	full_adder fa0(.a(a_4[0]),.b(b_4[0]),.c_in(C_IN),.sum(SUM[0]),.c_out(c1));      //use four bit-adder to get the four-bit adder
	full_adder fa1(.a(a_4[1]),.b(b_4[1]),.c_in(c1),.sum(SUM[1]),.c_out(c2));
	full_adder fa2(.a(a_4[2]),.b(b_4[2]),.c_in(c2),.sum(SUM[2]),.c_out(c3));
	full_adder fa3(.a(a_4[3]),.b(b_4[3]),.c_in(c3),.sum(SUM[3]),.c_out(C_OUT));
	
endmodule


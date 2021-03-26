module lookahead_adder (
	input  [15:0] A, B,
	input         cin,
	output [15:0] S,
	output        cout
);
    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
		logic c4,c8,c12;          // temporary parameters for carry in and out for each group.
		logic Gg0,Gg4,Gg8,Gg12;   // temporary parameters for group generating signal
		logic Pg0,Pg4,Pg8,Pg12;   // temporary parameters for group propagating signal
		
		always_comb
		begin
		c4 = Gg0 | cin & Pg0;                             
		c8 = Gg4 | Gg0 & Pg4 | cin & Pg0 & Pg4;
		c12 = Gg8 | Gg4 & Pg8 & Pg4 | cin & Pg8 & Pg4 & Pg0;
		end
		
		four_bit_look look4(.a_4(A[3:0]),.b_4(B[3:0]),.C_IN(cin),.SUM(S[3:0]),.Gg(Gg0),.Pg(Pg0));  // use 4x4 hierarchy to build the lookahead_adder
		four_bit_look look8(.a_4(A[7:4]),.b_4(B[7:4]),.C_IN(c4),.SUM(S[7:4]),.Gg(Gg4),.Pg(Pg4));
		four_bit_look look12(.a_4(A[11:8]),.b_4(B[11:8]),.C_IN(c8),.SUM(S[11:8]),.Gg(Gg8),.Pg(Pg8));
		four_bit_look look16(.a_4(A[15:12]),.b_4(B[15:12]),.C_IN(c12),.SUM(S[15:12]),.Gg(Gg12),.Pg(Pg12));
		
endmodule


module four_bit_look(
	input logic [3:0] a_4,b_4,
	input logic C_IN,
	output logic [3:0] SUM,
	output logic Gg,Pg
);

		logic c1,c2,c3;          // temporary parameters for carry in and out
		logic G0,G1,G2,G3;		// temporary parameters for group generating signal
		logic P0,P1,P2,P3;		// temporary parameters for group propagating signal
		
		always_comb
		begin
		P0 = a_4[0] ^ b_4[0];     // Get the P based on the equation P = A & B
		P1 = a_4[1] ^ b_4[1];
		P2 = a_4[2] ^ b_4[2];
		P3 = a_4[3] ^ b_4[3];
		Pg = P0 & P1 & P2 & P3;   // Get the P group value for 4 bits
		
		G0 = a_4[0] & b_4[0];     // Get the G based on the equation G = A ^ B
		G1 = a_4[1] & b_4[1];
		G2 = a_4[2] & b_4[2];
		G3 = a_4[3] & b_4[3];
		Gg = G3 | G2 & P3 | G1 & P3 & P2 | G0 & P3 & P2 & P1; // Get the G group value for 4 bits
		
		c1 = C_IN & P0 | G0;
		c2 = C_IN & P0 & P1 | G0 & P1 | G1;                              //Get the carry in/out based on the formula provided 
		c3 = C_IN & P0 & P1 & P2 | G0 & P1 & P2 | G1 & P2 | G2;
		
		SUM[0] = P0 ^ C_IN;                              // Get the sum   
		SUM[1] = P1 ^ c1;
		SUM[2] = P2 ^ c2;
		SUM[3] = P3 ^ c3;
		
		end

endmodule


		
		
		
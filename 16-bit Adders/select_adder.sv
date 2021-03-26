module select_adder (
	input  [15:0] A, B,
	input         cin,
	output [15:0] S,
	output        cout
);

    /* TODO
     *
     * Insert code here to implement a CSA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
		logic c1,c2,c3;       // temporary parameter for carry in and out.
		
		four_bit_fas select0(.a4(A[3:0]),.b4(B[3:0]),.CIN(1'b0),.sum_s(S[3:0]),.COUT(c1));   // first four-bit only need one four_bit full adder, because it will only have 0 carry in
		four_bit_select select1(.a_4(A[7:4]),.b_4(B[7:4]),.C_IN(c1),.SUM(S[7:4]),.C_OUT(c2));
		four_bit_select select2(.a_4(A[11:8]),.b_4(B[11:8]),.C_IN(c2),.SUM(S[11:8]),.C_OUT(c3));
		four_bit_select select3(.a_4(A[15:12]),.b_4(B[15:12]),.C_IN(c3),.SUM(S[15:12]),.C_OUT(cout));
		
	  
endmodule

module four_bit_select(
	input logic [3:0] a_4,b_4,
	input logic C_IN,
	output logic [3:0] SUM,
	output logic C_OUT
);

		logic [3:0] SUM0,SUM1;          //temeporary paramter to store the two results based on different carry in value
		logic C_OUT0,C_OUT1;
		
		four_bit_fas fa0(.a4(a_4[3:0]),.b4(b_4[3:0]),.CIN(1'b0),.sum_s(SUM0[3:0]),.COUT(C_OUT0));   //carry in is 0
		four_bit_fas fa1(.a4(a_4[3:0]),.b4(b_4[3:0]),.CIN(1'b1),.sum_s(SUM1[3:0]),.COUT(C_OUT1));   //carry in is 1
		
		always_comb
		begin
			if(C_IN == 1'b0) begin                   //work as the Mux, if carry in is 0, we choose the fa0 result
				SUM[3:0] = SUM0[3:0];						// if carry in is 1, we choose the fa1 result
				C_OUT = C_OUT0;
			end else begin
				SUM[3:0] = SUM1[3:0];
				C_OUT = C_OUT1;
			end
		end
	
endmodule

module full_adder_s(                            // one bit adder for select_adder
	input logic a,b,c_in,
	output logic sum,c_out
	
);

	assign sum = a^b^c_in;                         // build the one bit adder module based on the formula
	assign c_out = (a&b)|(b&c_in)|(a&c_in);
	
endmodule 

module four_bit_fas(                              // four_bit adder for select_adder
	input logic [3:0] a4,b4,
	input logic CIN,
	output logic [3:0] sum_s,
	output logic COUT
);
	
	logic c_1,c_2,c_3;        // temporary parameter for carry in and out.
	
	full_adder_s fa4(.a(a4[0]),.b(b4[0]),.c_in(CIN),.sum(sum_s[0]),.c_out(c_1));
	full_adder_s fa5(.a(a4[1]),.b(b4[1]),.c_in(c_1),.sum(sum_s[1]),.c_out(c_2));
	full_adder_s fa6(.a(a4[2]),.b(b4[2]),.c_in(c_2),.sum(sum_s[2]),.c_out(c_3));
	full_adder_s fa7(.a(a4[3]),.b(b4[3]),.c_in(c_3),.sum(sum_s[3]),.c_out(COUT));
	
endmodule
			

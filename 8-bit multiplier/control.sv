module control
(
    input   logic           Clk,        	// internal
    input   logic           Reset,      	// divided input from Run_Load_Clear
    input   logic           Run,      		// From key 1
    input   logic           Reset_Load_Clear, // From key 0
	 input 	logic 			 M,				// LSB for B
    output 	logic 			 Load,         // load signal 
	 output 	logic 			 Shift_En,     //shift enable signal
	 output 	logic 			 Add,          
	 output 	logic 			 Sub,           //do addition or subtraction
	 output	logic				 Clear          //clear XA signal
);
//B1 to I1 are the shift states
// B to I are the add/sub states
    enum logic [4:0] {start, B, C, D, E, F, G, H, I, J, hold, load,clear,clear1, B1, C1, D1, E1, F1, G1, H1, I1}   curr_state, next_state; 
    always_ff @(posedge Clk) begin
        if (~Reset)
				curr_state <= hold;			
        else 
            curr_state <= next_state;
	 end
        
   
	always_comb
    begin
        
		  next_state  = curr_state;	
        unique case (curr_state) 
		  
				start : if(~Run)
								next_state = B;
            B :    next_state = B1;
				B1: 	 next_state = C;
				
				C :    next_state = C1;
				C1: 	 next_state = D;
				
				D :    next_state = D1;
				D1: 	 next_state = E;
				
				E :    next_state = E1;
				E1: 	 next_state = F;
				
				F :    next_state = F1;
				F1: 	 next_state = G;
				
				G :    next_state = G1;
				G1: 	 next_state = H;
				
				H :    next_state = H1;
				H1: 	 next_state = I;
				
				I :    next_state = I1;
				I1: 	 next_state = J;
				
            J :    if (Run) 
                       next_state = hold;
				hold : if (~Reset_Load_Clear)      //which will hold the value for displaying, if we press run, we will go consecutive multiplication
								next_state = load;    //if we press Reset_Load_Clear, we will go to load and clear1 states to wait for the Run key (next computation)
							else if (~Run)
								next_state = clear;						
				load :  		next_state = clear1;
				
				clear1:     next_state = start; 
				clear :  		next_state = B;    //for consecutive multiplication
							  
        endcase
   
		  

		  Clear = 1'b0;
        case (curr_state) 
				start:
				begin
					 Clear = 1'b1;
                Load = Reset_Load_Clear;
                Shift_En = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
				end
				
				B:
				begin
                Load =  1'b1;
                Shift_En = 1'b0;
					 Add = M;
					 Sub = 1'b0;
		      end
				C:
				begin
                Load =  1'b1;
                Shift_En = 1'b0;
					 Add = M;
					 Sub = 1'b0;
		      end
				D:
				begin
                Load =  1'b1;
                Shift_En = 1'b0;
					 Add = M;
					 Sub = 1'b0;
		      end
				E: 
				begin
                Load =  1'b1;
                Shift_En = 1'b0;
					 Add = M;
					 Sub = 1'b0;
		      end
				F:
				begin
                Load =  1'b1;
                Shift_En = 1'b0;
					 Add = M;
					 Sub = 1'b0;
		      end
				G: 
				begin
                Load =  1'b1;
                Shift_En = 1'b0;
					 Add = M;
					 Sub = 1'b0;
		      end	
				H: 
				begin
                Load =  1'b1;
                Shift_En = 1'b0;
					 Add = M;
					 Sub = 1'b0;
		      end
				I:
				begin
					Add = 1'b0;
					Load =  1'b1;
               Shift_En = 1'b0;
					if (M)begin
						Sub = 1'b1;
					end else
						Sub = 1'b0; 
				end
	   	   J: 
		      begin
                Load =  1'b1;
                Shift_En = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					 Clear = 1'b0;
		      end
				
				load :
				begin
					 Load =  1'b0;
                Shift_En = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					 Clear = 1'b1;
				end
				clear:
				begin
					 Load =  1'b1;
                Shift_En = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					 Clear = 1'b1;
				end
				hold:
				begin
					 Load =  1'b1;
                Shift_En = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					 Clear = 1'b0;
				end
				clear1:
				begin
					 Load =  1'b1;
                Shift_En = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					 Clear = 1'b1;
				end
				
	   	   default:  
		      begin 
					 Add = 1'b0;
					 Sub = 1'b0;
                Load = 1'b1;
                Shift_En = 1'b1;
		      end
        endcase
    end
endmodule

module Rounding(

	input		wire			T,
	input		wire			G,
	input 		wire			L,
	input		wire			Sz,
	input		wire	[1:0]	R_mode,
	input		wire	[24:0]	After_norm,     //hidden+fraction+G
	
	output		reg				Overflow_after_round,
	output		reg		[22:0]	Mz,
	output		reg				rnd
);





parameter	to_Near	= 2'b 00 ,
			to_Zero = 2'b 01 ,
			to_Pinf	= 2'b 10 ,
			to_Ninf	= 2'b 11 ; 



always @ (*)
	begin
		case (R_mode)
			to_Near:
				begin
					if (G)
						begin
							if(L|T)
								begin
									rnd=1'b1;
								end
							else
								begin
									rnd=1'b0;
								end		
						end
	
					else	
						begin
							rnd=1'b0;
						end	
				end
			to_Zero:
				begin
					rnd=1'b0;			
				end
			to_Pinf:
				begin
					if (Sz)
						begin
							rnd=1'b0;
						end
	
					else	
						begin
							if(G|T)
								begin
									rnd=1'b1;
								end
							else
								begin
									rnd=1'b0;
								end
						end				
		
				end
			to_Ninf:
				begin
					if (Sz)
						begin
							if(G|T)
								begin
									rnd=1'b1;
								end
							else
								begin
									rnd=1'b0;
								end		
						end
	
					else	
						begin
							rnd=1'b0;
						end				
		
				end				
		endcase
	end
	

always @ (*)
	begin
	
		{Overflow_after_round,Mz}=After_norm[23:1] + rnd ;
		
		
	end
	
	
	
endmodule	
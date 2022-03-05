module Rounding(

	input		wire			T,
	input		wire			Sz,
	input		wire	[1:0]	R_mode,
	input		wire	[24:0]	After_norm,     //hidden+fraction+G
	
	output		reg				Overflow_after_round,
	output		reg		[23:0]	Mz, 
	output      reg      		inexact_flag
);

wire 			L,G;
reg 	[23:0]	internal_Mz;

assign G = After_norm[0];
assign L = After_norm[1];

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
									inexact_flag=1'b1;
								end
							else
								begin
									inexact_flag=1'b0;
								end		
						end
	
					else	
						begin
							inexact_flag=1'b0;
						end	
				end
			to_Zero:
				begin
					inexact_flag=1'b0;			
				end
			to_Pinf:
				begin
					if (Sz)
						begin
							inexact_flag=1'b0;
						end
	
					else	
						begin
							if(G|T)
								begin
									inexact_flag=1'b1;
								end
							else
								begin
									inexact_flag=1'b0;
								end
						end				
		
				end
			to_Ninf:
				begin
					if (Sz)
						begin
							if(G|T)
								begin
									inexact_flag=1'b1;
								end
							else
								begin
									inexact_flag=1'b0;
								end		
						end
	
					else	
						begin
							inexact_flag=1'b0;
						end				
		
				end				
		endcase
	end
	

always @ (*)
	begin
		
		
		{Overflow_after_round,internal_Mz}=After_norm[24:1] + inexact_flag ;
		
		if (Overflow_after_round)
			begin 
			Mz = {1'b1,internal_Mz[23:1]};
			end
		else 
			Mz = internal_Mz ;
		
		
	end
	
	
	
endmodule
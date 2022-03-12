module Rounding(

	input		wire			T,
	input		wire			Sz,
	input		wire	[1:0]	R_mode,
	input		wire	[24:0]	After_norm,     //hidden+fraction+G
	
	output		reg				Overflow_after_round,
	output		reg		[23:0]	Mz, 
	output      wire      		inexact_flag
);
//internal signals
wire 			L,G;
//reg 	[23:0]	internal_Mz;
reg rnd; //the bit in the block diagram in the book
assign G = After_norm[0];
assign L = After_norm[1];
assign inexact_flag = rnd ;
//parameters
parameter	to_Near	= 2'b 00 ,
			to_Zero = 2'b 01 ,
			to_Pinf	= 2'b 10 ,
			to_Ninf	= 2'b 11 ; 
//function
always@(*)
begin
	case (R_mode)
		to_Near :
			begin
				rnd = G & (T | L);
				{Overflow_after_round , Mz} = After_norm[24:1] + rnd;	
			end
		to_Zero :
			begin
				rnd = 0;
				Overflow_after_round = 0;
				Mz = After_norm[24:1];
			end	
		to_Pinf : 
			begin
				rnd = (~Sz) & (G | T);
				{Overflow_after_round , Mz} = After_norm[24:1] + rnd;
			end	
		to_Ninf :
			begin
				rnd = (Sz) & (G | T);
				{Overflow_after_round , Mz} = After_norm[24:1] + rnd;
			end
	endcase	
end	
endmodule
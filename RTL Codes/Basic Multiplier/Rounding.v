module Rounding(
	input 	 	wire 			CLK,RST, 
	input		wire			T,
	input		wire			Sz,
	input		wire	[1:0]	R_mode_ext,
	input		wire	[24:0]	After_norm,     //hidden+fraction+G
	
	output		reg				Overflow_after_round,
	output		reg		[23:0]	Mz, 
	output      wire       		inexact_flag

);



//internal signals
wire 			L,G;
reg 			rnd; //the bit in the block diagram in the book

//Flip_Flops 
reg 	[1:0]	R_mode1, R_mode2, R_mode3, R_mode4, R_mode5 ;

//reg				T_ff ;

//reg		[24:0]	After_norm_f,After_norm_ff ;

reg				/*Sz1,Sz2,Sz3,*/Sz4 ;



assign G = After_norm[0];
assign L = After_norm[1];

assign inexact_flag = rnd ;

//parameters
parameter	to_Near	= 2'b 00 ,
			to_Zero = 2'b 01 ,
			to_Pinf	= 2'b 10 ,
			to_Ninf	= 2'b 11 ; 



always@(*)
begin
	case (R_mode5)
		to_Near :
			begin
				rnd = G & (T | L);
				{Overflow_after_round , Mz} = After_norm[24:1] + rnd ;	
			end
		to_Zero :
			begin
				rnd = 0;
				Overflow_after_round = 0;
				Mz = After_norm[24:1];
			end	
		to_Pinf : 
			begin
				rnd = (~Sz4) & (G | T);
				{Overflow_after_round , Mz} = After_norm[24:1] + rnd;
			end	
		to_Ninf :
			begin
				rnd = (Sz4) & (G | T);
				{Overflow_after_round , Mz} = After_norm[24:1] + rnd;
			end
	endcase	
end	





always @ (posedge CLK or negedge RST )
	begin
	if (!RST) 
		begin
////////inputs RST	
/*			Sz1 			<= 0;
			Sz2 			<= 0;
			Sz3 			<= 0;
			Sz4 			<= 0;
			
			T_ff			<= 0;
			After_norm_f	<= 0; 
			After_norm_ff	<= 0; 
			
			R_mode1 			<= 0;
			R_mode2 			<= 0;
			R_mode3 			<= 0;
			R_mode4 			<= 0;
*/
			R_mode5 			<= 0;
			Sz4 				<= 0;
		end
		
	else
		begin
////////inputs Reg
/*			Sz1 			<= Sz ;
			Sz2 			<= Sz1;
			Sz3 			<= Sz2;
			Sz4 			<= Sz3;
			
			R_mode1 			<= R_mode_ext;
			R_mode2 			<= R_mode1;
			R_mode3 			<= R_mode2;
			R_mode4 			<= R_mode3;
			R_mode5 			<= R_mode4;
			
			R_mode5 			<= R_mode_ext;
			
			
			T_ff			<= T;
			
			After_norm_f	<= After_norm ; 
			After_norm_ff	<= After_norm_f ; 
*/			
			R_mode5 			<= R_mode_ext;
			Sz4 				<= Sz;
		end			
	end
	
endmodule
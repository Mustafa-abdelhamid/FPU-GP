module final_output 
(
input  		wire 			CLK,RST,
input  		wire 			Sz_out,	
input		wire	[23:0] 	M_out ,
input	 	wire	[7:0] 	E_out ,
input 		wire  			initial_zero_flag,overflow_flag , underflow_case , invalid_flag , inexact_flag,

output		reg 	[22:0] 	final_M_out ,
output		reg		[7:0] 	final_E_out ,
output  	reg 			final_Sz_out ,


output 		reg  			invalid_flag_ext, zero_flag_ext,overflow_flag_ext , underflow_flag_ext ,inexact_flag_ext

) ;
 
 
reg		[7:0] 	denorm_exactValue;
reg 	[23:0] 	final_M_out_int ;
reg 	[7:0] 	final_E_out_int ;

reg zero_flag_int;

////////Flip_Flops

reg			invalid_flag_f, overflow_flag_f,
			inexact_flag_f1, inexact_flag_f2, inexact_flag_f3,
			initial_zero_flag_f,
			underflow_case_f, underflow_case_ff;

//reg	[7:0] 	E_out_f, E_out_ff ;

//reg	[23:0] 	M_out_f1, M_out_f2, M_out_f3 ;

reg			Sz_1, Sz_2, Sz_3, Sz_4, Sz_5, Sz_6, Sz_7 ;

always@(*)
begin 

		if (overflow_flag)
			begin
			
			final_M_out_int = 0 ;  
			final_E_out_int = 8'b  1111_1111 ; 
			end 
		else if (underflow_case)
			begin
			final_M_out_int = M_out;
			final_E_out_int = 0 ;
			end
		else if (invalid_flag) 
			begin
			final_M_out_int = 23'b 11111_11111_11111_11111_111 ;
			final_E_out_int = 8'b 1111_1111 ;
		
			end 
		else  
			begin
				final_M_out_int= M_out ;
				final_E_out_int = E_out ; 
			end		
			
			
		zero_flag_int = ((~|final_M_out_int) & (~|final_E_out_int)) | initial_zero_flag ;

end 
	

always @ (posedge CLK or negedge RST )
	begin
	if (!RST) 
		begin
/*		
//////////////input
		
			invalid_flag_f		<= 0 ;
			overflow_flag_f		<= 0 ;
			
			inexact_flag_f1		<= 0 ;
			inexact_flag_f2		<= 0 ;
			inexact_flag_f3		<= 0 ;
			
			initial_zero_flag_f		<= 0 ;
			
			underflow_case_f		<= 0 ;
			underflow_case_ff		<= 0 ;
		
			E_out_f					<= 0 ;
			E_out_ff				<= 0 ;
			
			M_out_f1				<= 0 ;
			M_out_f2				<= 0 ;
			M_out_f3				<= 0 ;
			
			Sz_1 <=0 ; Sz_2 <=0 ; Sz_3 <=0 ; Sz_4 <=0 ; Sz_5 <=0 ; Sz_6 <=0 ; Sz_7 <=0 ;
*/		
		
		
		
/////////////output
			final_E_out 		<= 0 ;
			final_M_out 		<= 0 ;
			final_Sz_out		<= 0 ;
			
			overflow_flag_ext   <= 0 ;
			invalid_flag_ext    <= 0 ;
			zero_flag_ext		<= 0 ;
			underflow_flag_ext  <= 0 ;
			inexact_flag_ext	<= 0 ;
					
		end
		
	else
		begin
//////////////input
/*
			invalid_flag_f		<= invalid_flag  ;
			overflow_flag_f		<= overflow_flag ;
			
			inexact_flag_f1		<= inexact_flag    ;
			inexact_flag_f2		<= inexact_flag_f1 ;
			inexact_flag_f3		<= inexact_flag_f2 ;

			initial_zero_flag_f		<= initial_zero_flag ;

			underflow_case_f		<= underflow_case 	;
			underflow_case_ff		<= underflow_case_f ;

			E_out_f					<= E_out   ;
			E_out_ff				<= E_out_f ;

			M_out_f1				<= M_out    ;
			M_out_f2				<= M_out_f1 ;
			M_out_f3				<= M_out_f2 ;
			
			Sz_1 <=Sz_out ; Sz_2 <=Sz_1 ; Sz_3 <=Sz_2 ; Sz_4 <=Sz_3 ; Sz_5 <=Sz_4 ; Sz_6 <=Sz_5 ; Sz_7 <=Sz_6 ;
*/

/////////////output
			final_E_out			<= final_E_out_int;
			final_M_out 		<= final_M_out_int[22:0];
			final_Sz_out		<= Sz_out ;
			
			overflow_flag_ext   <= overflow_flag ;
			invalid_flag_ext    <= invalid_flag ;
			
			zero_flag_ext		<= zero_flag_int ;
			underflow_flag_ext  <= (~zero_flag_int) & underflow_case ;
			
			inexact_flag_ext	<= inexact_flag ;
		end			
	end



endmodule

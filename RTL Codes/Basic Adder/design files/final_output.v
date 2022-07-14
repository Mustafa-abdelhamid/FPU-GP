module final_output (
input wire [23:0] mantessa_mux_out ,
input wire [7:0]E_exponent_update,
input wire [9:0]excessive_shift_left,
input wire  overflow_flag , underflow_flag , invalid_flag , 

output	reg [22:0] final_M_out ,
output	reg [7:0] final_E_out 
) ; 
//reg  [7:0] denorm_exactValue;
//internal signals
reg [23:0]internal_mantessa;
always@(*)
begin 
	//denorm_exactValue = required_shift - E_out ;
		if (overflow_flag)
			begin
			internal_mantessa = 0;	
			final_M_out = internal_mantessa[22:0] ;  
			final_E_out = 8'b  1111_1111 ; 
			end 
		else if (underflow_flag)
			begin
			internal_mantessa = mantessa_mux_out >> excessive_shift_left ;
			final_M_out = internal_mantessa[22:0] ;
			final_E_out = 0 ;
			end
		else if (invalid_flag) 
			begin
			internal_mantessa = 23'b 11111_11111_11111_11111_111 ;
			final_M_out = internal_mantessa[22:0] ;
			final_E_out = 8'b 1111_1111 ;
			end 
		else  
			begin
				internal_mantessa= mantessa_mux_out ;
				final_M_out = internal_mantessa[22:0] ;
				final_E_out = E_exponent_update ; 
			end
			
end 

endmodule
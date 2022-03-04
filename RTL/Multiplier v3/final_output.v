module final_output (
input wire [22:0] M_out ,
input wire [7:0] E_out ,
input wire [4:0] required_shift  ,

input wire  overflow_flag , underflow_flag , invalid_flag , zero_flag, 

output	reg [22:0] final_M_out ,
output	reg [7:0] final_E_out 
) ; 
reg  [7:0] denorm_exactValue;
always@(*)
begin 
	denorm_exactValue = required_shift - E_out ;
		if (overflow_flag)
			begin
			final_M_out = 0 ;  
			final_E_out = 8'b  1111_1111 ; 
			end 
		else if (underflow_flag)
			begin
			final_M_out = M_out >> denorm_exactValue ;  
			final_E_out = 0 ;
			end
		else if (invalid_flag) 
			begin
			final_M_out = 23'b 00000_11111_00000_11111_000 ;
			final_E_out = 8'b 1111_1111 ;
			end 
		else if (zero_flag) 
			begin
			final_M_out = 0 ;
			final_E_out = 0 ;
			end 
		else  
			begin
				final_M_out= M_out ;
				final_E_out = E_out ; 
			end
			
end 

endmodule

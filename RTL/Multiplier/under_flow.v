module under_flow(
input  	wire 	CLK,RST,
input 	wire 	in_underflow_flag,in_zero_flag,
output	reg		underflow_flag

);

always @ (posedge CLK or negedge RST )
	begin
	if (!RST) 
		begin
			underflow_flag <= 0;
		end
		
	else
		begin
			underflow_flag <= (~in_zero_flag) & in_underflow_flag;
		end			
	end
	



endmodule
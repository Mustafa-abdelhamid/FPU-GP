module zero_flag_block (CLK,RST,final_M_out , final_E_out , initial_zero_flag , zero_flag,zero_flag_to_underflow);

//inputs and outputs
input  	wire 				CLK;
input  	wire 				RST;  
input 			[23:0]		final_M_out;
input 			[7:0]		final_E_out;
input 						initial_zero_flag;
output 	reg 				zero_flag;
output	reg					zero_flag_to_underflow;

//internal signals
reg		int_zero;

wire zero_mantessa_z;
assign zero_mantessa_z = ~| final_M_out;

wire zero_exponent_z;
assign zero_exponent_z = ~|final_E_out;

//function
always@(*)
begin
    int_zero = (zero_mantessa_z & zero_exponent_z) | initial_zero_flag;
	zero_flag_to_underflow = int_zero;
end  


always @ (posedge CLK or negedge RST )
	begin
	if (!RST) 
		begin
			zero_flag <= 0;
		end
		
	else
		begin
			zero_flag <= int_zero;
		end			
	end
	


endmodule  
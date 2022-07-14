module Exponent_Update_2 (internal_exponent , mantessa_mux_out , sum , E_exponent_update , max_exponent_z , min_exponent_z , excessive_shift_left , underflow_flag);
input [9:0]internal_exponent;
input [23:0]mantessa_mux_out;
input [26:0]sum;
output reg [7:0]E_exponent_update;
output reg max_exponent_z , min_exponent_z;
output reg [9:0]excessive_shift_left;
output reg underflow_flag;
always@(*)
begin
    if( ( (internal_exponent[8] == 1'b 1) && (internal_exponent[9] == 1'b 0) ) || (internal_exponent == 10'b 0011_1111_11) )     //max exponent case
		begin
			E_exponent_update = 8'b 1111_1111;
			max_exponent_z = 1;
			min_exponent_z = 0;
			excessive_shift_left = 0;
			underflow_flag = 0;
		end
	else if(((internal_exponent[8] == 1'b 1) && (internal_exponent[9] == 1'b 1)))   //min exponent case
		begin
			E_exponent_update = 8'b 0000_0000;
			max_exponent_z = 0;
			min_exponent_z = 1;
			excessive_shift_left = ~internal_exponent + 1'b 1;
			underflow_flag = 1;
		end
	else if((internal_exponent == 10'b 0000_0000_00) && (mantessa_mux_out[22:0] == 23'b 0000_0000_0000_0000_0000_000) && (sum[26] == 1'b 0))//not uderflow and not normalized number
		begin
			E_exponent_update = 8'b 0000_0000;
			max_exponent_z = 0;
			min_exponent_z = 1;
			excessive_shift_left = internal_exponent;
			underflow_flag = 0;
		end
	else if((internal_exponent == 10'b 0000_0000_00) && (mantessa_mux_out[22:0] == 23'b 0000_0000_0000_0000_0000_000) && (sum[26] == 1'b 1))//not underflow but normalized number
		begin
			E_exponent_update = 8'b 0000_0001;
			max_exponent_z = 0;
			min_exponent_z = 0;
			excessive_shift_left = internal_exponent;
			underflow_flag = 0;
		end			
	else if((internal_exponent == 10'b 0000_0000_00) && (mantessa_mux_out[22:0] != 23'b 0000_0000_0000_0000_0000_000) && (sum[26] == 1'b 0))//underflow 
		begin
			E_exponent_update = 8'b 0000_0000;
			max_exponent_z = 0;
			min_exponent_z = 1;
			excessive_shift_left = internal_exponent;
			underflow_flag = 1;
		end
	else if((internal_exponent == 10'b 0000_0000_00) && (mantessa_mux_out[22:0] != 23'b 0000_0000_0000_0000_0000_000) && (sum[26] == 1'b 1))//not underflow but normalized number 
		begin
			E_exponent_update = 8'b 0000_0001;
			max_exponent_z = 0;
			min_exponent_z = 0;
			excessive_shift_left = internal_exponent;
			underflow_flag = 0;
		end	
	//else if((internal_exponent == 10'b 0000_0000_00) && (sum[26] == 1'b 1))//not underflow 
	else
		begin
			E_exponent_update = internal_exponent;
			max_exponent_z = 0;
			min_exponent_z = 0;
			excessive_shift_left = 0;
			underflow_flag = 0;
		end	
		
end	
endmodule
module Exponent_Update(mux_out , ovf , ovf_rnd , massive_shift_left , one_shift_left , sum , E_exponent_update , max_exponent_z , min_exponent_z , excessive_shift_left , underflow_flag);
//inputs and outputs
input [7:0]mux_out;
input ovf , ovf_rnd;
input [4:0]massive_shift_left;
input one_shift_left;
input [26:0]sum;
output reg [7:0]E_exponent_update;
output reg max_exponent_z , min_exponent_z;
output reg [9:0]excessive_shift_left;
output reg underflow_flag;
//internal signals
//reg [4:0]tot_shift_left;
//reg [1:0]tot_shift_right;
wire [2:0]most_bits_of_adder_out;
reg [9:0]internal_exponent; // bit 8 is the carry and bit 9 is to decide if the result is + or -
//assignments
//assign tot_shift_left = massive_shift_left + one_shift_left;
//assign tot_shift_right = ovf + ovf_rnd;
//assign internal_exponent = mux_out + tot_shift_right - tot_shift_left;
assign most_bits_of_adder_out = {ovf , sum[26] , sum[25]};
//function
always@(*)
begin
	if(most_bits_of_adder_out == 3'b 000)//left path is chosen
		begin
			internal_exponent = mux_out + ovf + ovf_rnd - massive_shift_left;
		end
	else
		begin
			internal_exponent = mux_out + ovf + ovf_rnd - one_shift_left;
		end
	if( ( (internal_exponent[8] == 1'b 1) && (internal_exponent[9] == 1'b 0) ) || (internal_exponent == 10'b 0011_1111_11) )     //max exponent case
		begin
			E_exponent_update = 8'b 1111_1111;
			max_exponent_z = 1;
			min_exponent_z = 0;
			excessive_shift_left = 0;
			underflow_flag = 0;
		end
	else if(((internal_exponent[8] == 1'b 1) && (internal_exponent[9] == 1'b 1)) || (internal_exponent == 10'b 0000_0000_00))   //min exponent case
		begin
			E_exponent_update = 8'b 0000_0000;
			max_exponent_z = 0;
			min_exponent_z = 1;
			excessive_shift_left = ~internal_exponent + 1'b 1;
			underflow_flag = 1;
		end
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
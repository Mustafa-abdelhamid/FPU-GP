module Exponent_Update_1 (ovf , ovf_rnd , one_shift_left , sum , mux_out , massive_shift_left , internal_exponent);
input ovf;
input ovf_rnd;
input one_shift_left;
input [26:0]sum;
input [7:0]mux_out;
input [4:0]massive_shift_left;
output reg [9:0]internal_exponent;
//internal signals
wire [2:0]most_bits_of_adder_out;
//assignment
assign most_bits_of_adder_out = {ovf , sum[26] , sum[25]};
always@(*)
begin
    if(most_bits_of_adder_out == 3'b 000)//left path is chosen
		begin
			internal_exponent = mux_out + ovf - massive_shift_left;
		end
	else
		begin
			internal_exponent = mux_out + ovf + ovf_rnd - one_shift_left;
		end
end
endmodule
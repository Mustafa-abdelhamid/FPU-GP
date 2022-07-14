    module LZA_final_modified (sum_shifted , correct_sum_shifted , second_shift_left);
input [26:0]sum_shifted;
output reg [23:0]correct_sum_shifted;
output reg second_shift_left;
always@(*)
begin
	if(sum_shifted[26])
		begin
			correct_sum_shifted = sum_shifted[26:3];
            second_shift_left = 0;
		end
	else if(sum_shifted == 27'b 0000_0000_0000_0000_0000_0000_000)
		begin
			correct_sum_shifted = 24'b 00000_00000_00000_00000_0000;
			second_shift_left = 0;
		end
	else
		begin
			correct_sum_shifted = sum_shifted[25:2];
            second_shift_left = 1;
		end
end
endmodule
    

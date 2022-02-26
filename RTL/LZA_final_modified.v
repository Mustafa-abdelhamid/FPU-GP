module LZA_final_modified (sum_shifted , correct_sum_shifted , second_shift_left);
input [26:0]sum_shifted;
output reg [22:0]correct_sum_shifted;
output reg second_shift_left;
always@(*)
begin
	if(sum_shifted[26])
		begin
			correct_sum_shifted = sum_shifted[25:3];
            second_shift_left = 0;
		end
	else
		begin
			correct_sum_shifted = sum_shifted[24:2];
            second_shift_left = 1;
		end
end
endmodule
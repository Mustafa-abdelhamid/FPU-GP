module zero_flag_block_2 (zero_mantessa_z , min_exponent_z , zero_flag);
input zero_mantessa_z , min_exponent_z;
output reg zero_flag;
always@(*)
begin
    zero_flag = zero_mantessa_z & min_exponent_z;
end
endmodule
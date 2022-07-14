module zero_flag_block_new (final_M_out , min_exponent_z , zero_flag);
input [22:0]final_M_out;
input min_exponent_z;
output wire zero_flag;
//internal signals
wire zero_mantessa_z;
//instances
zero_flag_block_1 zero_flag_block_1_inst (final_M_out , zero_mantessa_z);
zero_flag_block_2 zero_flag_block_2_inst (zero_mantessa_z , min_exponent_z , zero_flag);
endmodule
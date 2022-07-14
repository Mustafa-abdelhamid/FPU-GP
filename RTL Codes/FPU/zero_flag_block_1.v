module zero_flag_block_1 (final_M_out , zero_mantessa_z);
input [22:0]final_M_out;
output reg zero_mantessa_z;
always@(*)
begin
    zero_mantessa_z = ~| final_M_out;
end
endmodule
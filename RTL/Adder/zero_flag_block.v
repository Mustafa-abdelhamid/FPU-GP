module zero_flag_block (final_M_out , final_E_out , min_exponent_z , zero_flag);
//inputs and outputs
input [22:0]final_M_out;
input [7:0]final_E_out;
input min_exponent_z;
output reg zero_flag;
//internal signals
wire zero_mantessa_z;
assign zero_mantessa_z = ~| final_M_out;
//function
always@(*)
begin
    zero_flag = zero_mantessa_z & min_exponent_z;
end  
endmodule  
module zero_flag_block (final_M_out , final_E_out , initial_zero_flag , zero_flag);
//inputs and outputs
input [22:0]final_M_out;
input [7:0]final_E_out;
input initial_zero_flag;
output reg zero_flag;

//internal signals
wire zero_mantessa_z;
assign zero_mantessa_z = ~| final_M_out;
wire zero_exponent_z = ~|final_E_out;

//function
always@(*)
begin
    zero_flag = (zero_mantessa_z & zero_exponent_z) | initial_zero_flag;
end  
endmodule  
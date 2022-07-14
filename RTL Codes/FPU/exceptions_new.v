module exceptions_new (Ex , Ey , Mx , My , EOP , max_exponent_z , invalid_flag , overflow_flag);
input [7:0]Ex,Ey;
input [22:0]Mx,My;
input EOP , max_exponent_z;
output wire  invalid_flag,overflow_flag;
//internal signals
wire zero_mantessa_x , zero_mantessa_y , max_exponent_x , max_exponent_y , x_is_inf , y_is_inf , overflow_case;
//instances
exceptions_1 exceptions_1_inst (Ex , Ey , Mx , My , zero_mantessa_x , zero_mantessa_y , max_exponent_x , max_exponent_y);
exceptions_2 exceptions_2_inst (zero_mantessa_x , zero_mantessa_y , max_exponent_x , max_exponent_y , max_exponent_z , overflow_case , x_is_inf , y_is_inf);
exceptions_3 exceptions_3_inst (x_is_inf , y_is_inf , overflow_case , EOP , max_exponent_x , max_exponent_y , zero_mantessa_x , zero_mantessa_y , overflow_flag , invalid_flag);
endmodule
module exceptions_3 (x_is_inf , y_is_inf , overflow_case , EOP , max_exponent_x , max_exponent_y , zero_mantessa_x , zero_mantessa_y , overflow_flag , invalid_flag);
input x_is_inf , y_is_inf , overflow_case , EOP , max_exponent_x , max_exponent_y , zero_mantessa_x , zero_mantessa_y;
output reg overflow_flag , invalid_flag;
always@(*)
begin
    overflow_flag = overflow_case || (x_is_inf^y_is_inf) || (x_is_inf & y_is_inf & ~EOP);
    invalid_flag = (x_is_inf & y_is_inf & EOP) || (max_exponent_x & ~zero_mantessa_x) || (max_exponent_y & ~zero_mantessa_y);
end
endmodule
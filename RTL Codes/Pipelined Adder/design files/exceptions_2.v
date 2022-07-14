module exceptions_2 (zero_mantessa_x , zero_mantessa_y , max_exponent_x , max_exponent_y , max_exponent_z , overflow_case , x_is_inf , y_is_inf);
input zero_mantessa_x , zero_mantessa_y , max_exponent_x , max_exponent_y , max_exponent_z;
output reg overflow_case , x_is_inf , y_is_inf;
always@(*)
begin
    overflow_case = max_exponent_z & ~((max_exponent_x & ~zero_mantessa_x) || (max_exponent_y & ~zero_mantessa_y));
    x_is_inf = max_exponent_x & zero_mantessa_x;
    y_is_inf = max_exponent_y & zero_mantessa_y;
end
endmodule
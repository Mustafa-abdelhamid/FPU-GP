module exceptions (Ex,Ey,Mx,My,Mz,EOP,exponent_z,required_shift,invalid_flag,overflow_flag,underflow_flag,inexat_flag,zero_flag,max_exponent_z);
input [7:0]Ex,Ey;
input [22:0]Mx,My,Mz;
input EOP , max_exponent_z;
input [7:0]exponent_z;
input [4:0]required_shift;
output reg  invalid_flag,overflow_flag,underflow_flag,inexat_flag,zero_flag;
reg zero_mantessa_x,zero_mantessa_y,max_exponent_x,max_exponent_y,x_is_inf,y_is_inf,min_exponent_z,zero_mantessa_z;
reg [7:0]internal_subtract;
//x and y are inputs and z is output.
always@(*)
begin
    zero_mantessa_x = ~| Mx;
    zero_mantessa_y = ~| My;
    //zero_mantessa_z = | 
    max_exponent_x = & Ex;
    max_exponent_y = & Ey;
    x_is_inf = max_exponent_x & zero_mantessa_x;
    y_is_inf = max_exponent_y & zero_mantessa_y;
    min_exponent_z = ~| exponent_z;
    zero_mantessa_z = ~| Mz;

    overflow_flag = max_exponent_z || (x_is_inf^y_is_inf) || (x_is_inf & y_is_inf & ~EOP);
    //output has max exponent or only on of the inputs is infinity or both is infinity and the operation is adding.
    invalid_flag = (x_is_inf & y_is_inf & EOP) || (max_exponent_x & ~zero_mantessa_x) || (max_exponent_y & ~zero_mantessa_y);
    // inf-inf or one of the inputs is NAN.
    {underflow_flag,internal_subtract} = (exponent_z + ~required_shift + 1'b1);
    zero_flag = min_exponent_z & zero_mantessa_z;
end
endmodule

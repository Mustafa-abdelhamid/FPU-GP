module exceptions (Ex , Ey , Mx , My , EOP , max_exponent_z , invalid_flag , overflow_flag);
input [7:0]Ex,Ey;
input [22:0]Mx,My;
input EOP , max_exponent_z;
output reg  invalid_flag,overflow_flag;
reg zero_mantessa_x,zero_mantessa_y,max_exponent_x,max_exponent_y,x_is_inf,y_is_inf;
//reg [7:0]internal_subtract;
wire overflow_case;
//assignments
assign overflow_case = max_exponent_z & ~((max_exponent_x & ~zero_mantessa_x) || (max_exponent_y & ~zero_mantessa_y));
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
    //min_exponent_z = ~| E_exponent_shifter;
    //zero_mantessa_z = ~| Mz;

    overflow_flag = overflow_case || (x_is_inf^y_is_inf) || (x_is_inf & y_is_inf & ~EOP);
    //output has max exponent or only on of the inputs is infinity or both is infinity and the operation is adding.
    invalid_flag = (x_is_inf & y_is_inf & EOP) || (max_exponent_x & ~zero_mantessa_x) || (max_exponent_y & ~zero_mantessa_y);
    // inf-inf or one of the inputs is NAN.
    //{underflow_flag,internal_subtract} = (E_exponent_update + ~required_shift + 1'b1);
    //underflow_flag = min_exponent_z & ~zero_mantessa_z;
    //zero_flag = min_exponent_z & zero_mantessa_z;
end
endmodule
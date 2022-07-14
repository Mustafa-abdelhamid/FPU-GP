module exceptions_1 (Ex , Ey , Mx , My , zero_mantessa_x , zero_mantessa_y , max_exponent_x , max_exponent_y);
input [7:0]Ex,Ey;
input [22:0]Mx,My;
output reg zero_mantessa_x , zero_mantessa_y , max_exponent_x , max_exponent_y;
always@(*)
begin
    zero_mantessa_x = ~| Mx;
    zero_mantessa_y = ~| My;
    max_exponent_x = & Ex;
    max_exponent_y = & Ey;
end
endmodule
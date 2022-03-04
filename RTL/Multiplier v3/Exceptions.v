 `timescale 1us/1us 
module exceptions (
		input wire [7:0]Ex,Ey,Ez,
		input wire [22:0]Mx,My,Mz,
		input wire [4:0]required_shift,
		output reg  invalid_flag,overflow_flag,underflow_flag,zero_flag
						);

reg zero_mantessa_x,zero_mantessa_y,max_exponent_x,max_exponent_y,x_is_inf,y_is_inf,min_exponent_z,zero_mantessa_z;
reg zero_exponent_x,zero_exponent_y,max_exponent_z,x_is_zero,y_is_zero,x_is_NAN,y_is_NAN;
reg [7:0]internal_subtract;

always @(*)
	begin
			zero_mantessa_x = ~| Mx;
			zero_mantessa_y = ~| My;
			zero_mantessa_z = ~| Mz;
			
			zero_exponent_x = ~| Ex;
			zero_exponent_y = ~| Ey;			
			
			
			max_exponent_x = & Ex;
			max_exponent_y = & Ey;
			max_exponent_z = & Ez;
			
			x_is_inf = max_exponent_x & zero_mantessa_x;
			y_is_inf = max_exponent_y & zero_mantessa_y;
			
			x_is_zero = zero_exponent_x & zero_mantessa_x;
			y_is_zero = zero_exponent_y & zero_mantessa_y;
			
			x_is_NAN = (max_exponent_x & ~zero_mantessa_x) ;
			y_is_NAN = (max_exponent_y & ~zero_mantessa_y);
			
			//min_exponent_z = ~| Ez;
			//zero_mantessa_z = ~| Mz;
			
			
			zero_flag = (	x_is_zero & !y_is_inf	)	||	(	!x_is_inf & y_is_zero	) ;
			
			overflow_flag = (max_exponent_z & zero_mantessa_z) || (	(x_is_inf & !y_is_zero) | (!x_is_zero & y_is_inf)	) ;
			
			invalid_flag = (x_is_zero & y_is_inf)	||	(x_is_inf & y_is_zero) 	||  (x_is_NAN ||y_is_NAN) ;
			
			{underflow_flag,internal_subtract} = (Ez + ~required_shift + 1'b1);//

			
			
	end
endmodule
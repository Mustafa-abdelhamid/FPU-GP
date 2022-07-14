module exceptions (
		input 	wire				CLK,RST,
		input 	wire 	[7:0]		Ex_ext,Ey_ext,Ez,
		input 	wire 	[22:0] 		Mx_ext,My_ext,
		input 	wire 	[23:0] 		Mz,
		input	wire          		overflow_case ,
		output 	reg  				invalid_flag,overflow_flag,initial_zero_flag
					);


reg 	zero_mantessa_x,zero_mantessa_y,max_exponent_x,max_exponent_y,x_is_inf,y_is_inf,min_exponent_z,zero_mantessa_z;
reg 	zero_exponent_x,zero_exponent_y,max_exponent_z,x_is_zero,y_is_zero,x_is_NAN,y_is_NAN;

reg		[7:0]	Ex7,Ey7;
				/*Ex1,Ex2,Ex3,Ex4,Ex5,Ex6,Ex7,
				Ey1,Ey2,Ey3,Ey4,Ey5,Ey6,Ey7,
				Ez_f;*/
				
reg 	[22:0] 	Mx7,My7;
				/*Mx1,Mx2,Mx3,Mx4,Mx5,Mx6,Mx7,
				My1,My2,My3,My4,My5,My6,My7;*/
				
//reg 	[23:0] 	Mz_f,Mz_ff;
				
//reg				overflow_case_f ;

always @ (posedge CLK or negedge RST )
	begin
	if (!RST) 
		begin
			
		/*
			Ex1		<= 0 ;  Ey1		<= 0 ;
			Ex2		<= 0 ;  Ey2		<= 0 ;
			Ex3		<= 0 ;	Ey3		<= 0 ;
			Ex4		<= 0 ;	Ey4		<= 0 ;
			Ex5		<= 0 ;	Ey5		<= 0 ;
			Ex6		<= 0 ;	Ey6		<= 0 ;
		*/
			Ex7		<= 0 ;	Ey7		<= 0 ;
			
		/*
			Mx1		<= 0 ;  My1		<= 0 ;
			Mx2		<= 0 ;  My2		<= 0 ;
			Mx3		<= 0 ;	My3		<= 0 ;
			Mx4		<= 0 ;	My4		<= 0 ;
			Mx5		<= 0 ;	My5		<= 0 ;
			Mx6		<= 0 ;	My6		<= 0 ;
		*/
			Mx7		<= 0 ;	My7		<= 0 ;
			
			//Ez_f 	<= 0 ;
			//Mz_f	<= 0 ;
			//Mz_ff	<= 0 ;
			
			//overflow_case_f	<= 0 ;
	
		end
		
	else
		begin
			
		/*
			Ex1		<= 0 ;  Ey1		<= 0 ;
			Ex2		<= 0 ;  Ey2		<= 0 ;
			Ex3		<= 0 ;	Ey3		<= 0 ;
			Ex4		<= 0 ;	Ey4		<= 0 ;
			Ex5		<= 0 ;	Ey5		<= 0 ;
			Ex6		<= 0 ;	Ey6		<= 0 ;
		*/
			Ex7		<= Ex_ext ;	Ey7		<= Ey_ext ;
			
		/*
			Mx1		<= 0 ;  My1		<= 0 ;
			Mx2		<= 0 ;  My2		<= 0 ;
			Mx3		<= 0 ;	My3		<= 0 ;
			Mx4		<= 0 ;	My4		<= 0 ;
			Mx5		<= 0 ;	My5		<= 0 ;
			Mx6		<= 0 ;	My6		<= 0 ;
		*/
			Mx7		<= Mx_ext ;	My7		<= My_ext ;
			
			//Ez_f 	<= 0 ;
			//Mz_f	<= 0 ;
			//Mz_ff	<= 0 ;
			
			//overflow_case_f	<= 0 ;
			
		end			
	end

always @(*)
	begin
			zero_mantessa_x = ~| Mx7;
			zero_mantessa_y = ~| My7;
			zero_mantessa_z = ~| Mz;
			
			zero_exponent_x = ~| Ex7;
			zero_exponent_y = ~| Ey7;			
			
			
			max_exponent_x = & Ex7;
			max_exponent_y = & Ey7;
			max_exponent_z = & Ez;
			
			x_is_inf = max_exponent_x & zero_mantessa_x;
			y_is_inf = max_exponent_y & zero_mantessa_y;
			
			x_is_zero = zero_exponent_x & zero_mantessa_x;
			y_is_zero = zero_exponent_y & zero_mantessa_y;
			
			x_is_NAN = (max_exponent_x & ~zero_mantessa_x) ;
			y_is_NAN = (max_exponent_y & ~zero_mantessa_y);

			initial_zero_flag = (	x_is_zero & !y_is_inf	)	||	(	!x_is_inf & y_is_zero	) ;	
			overflow_flag = (max_exponent_z & zero_mantessa_z) || (	(x_is_inf & !y_is_zero) | (!x_is_zero & y_is_inf)) || overflow_case ;
			invalid_flag = (x_is_zero & y_is_inf)	||	(x_is_inf & y_is_zero) 	||  (x_is_NAN ||y_is_NAN) ;
				
	end
endmodule
module Top_Mul_tb ();

reg 	[7:0]	Ex,Ey;
reg 	[22:0]	Mx,My;
reg 	     	Sx,Sy;
reg 	[1:0]	R_mode;
reg 	[1:0]	Mul_enable;
wire 	[22:0]	Mz;
wire 	[7:0]	Ez;
wire 		    Sz;
wire  invalid_flag,overflow_flag,underflow_flag,inexact_flag,zero_flag; ////////




initial 
	begin 
		$dumpfile("Significand.vcd") ;
		$dumpvars ;
		
		Mx = 23'b00001100010000000000000; 
		My = 23'b00001100011001000100000;
		Ex = 8'b00000000;  
		Ey = 8'b11000000;  //// not passed 
				
				/// and any inputs thier outputs is zeros	
		Sx = 1'b0;
		Sy = 1'b0;
		R_mode = 2'b00 ;
		#10

		Mx = 23'b01111100010001000010000;
		My = 23'b11111111111111111111111;
		Ex = 8'b10000110 ;
		Ey = 8'b10001110 ;
		Sx = 1'b0;
		Sy = 1'b0;		
		R_mode = 2'b00 ;
		
		#10		
		
		
		
		
		
		
		
		
		
		
		
		#10
		$finish ;
	end





Top_Mul S1 
(
.Mx(Mx),
.My(My),
.Mz(Mz),
.Ex(Ex),
.Ey(Ey),
.Ez(Ez),
.Sx(Sx),
.Sy(Sy),
.Sz(Sz),
.R_mode(R_mode),
.Mul_enable(Mul_enable),
.invalid_flag(invalid_flag),
.overflow_flag(overflow_flag),
.underflow_flag(underflow_flag),
.inexact_flag(inexact_flag),
.zero_flag(zero_flag)

);

endmodule
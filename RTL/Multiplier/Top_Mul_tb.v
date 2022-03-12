`timescale 1ns/1ns 

module Top_Mul_tb ();

reg 			CLK,RST;
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
		
		Mx = 23'b0; 
		My = 23'b0;
		Ex = 8'b0;  
		Ey = 8'b0;
		Sx = 1'b0;
		Sy = 1'b0;
		R_mode = 2'b00 ;
		
		CLK = 1'b0; 
		RST = 1'b1;
		#20
		RST = 1'b0; 
		
		#200
		RST = 1'b1;
		
		#20  
		
		Mx = 23'b00001100010000000000000; 
		My = 23'b00001100011001000100000;
		Ex = 8'b 00000001;  
		Ey = 8'b 11000000;
		Sx = 1'b0;
		Sy = 1'b0;
		R_mode = 2'b00 ;
		#60		
		
		if (Mz==23'b00011001001111000000110 && Ez==8'b01000010)
		$display ("case1: Pass");
		else 
		$display ("case1: Fail");

////////////
		Mx = 23'b00001100010000000000000; 
		My = 23'b00001100011001000100000;
		Ex = 8'b 10110110;  
		Ey = 8'b 01110111;   
		Sx = 1'b0;
		Sy = 1'b0;		
		R_mode = 2'b00 ;
		#60	;	
		
		if (Mz==23'b00011001001111000000110 && Ez==8'b10101110)
		$display ("case2: Pass");
		else 
		$display ("case2: Fail");
		
////////////
		Mx = 23'b00000100111111000000000; 
		My = 23'b01111001110101010000000;
		Ex = 8'b 00000111;  
		Ey = 8'b 00000001;  
		Sx = 1'b0;
		Sy = 1'b0;		
		R_mode = 2'b00 ;
		#60	;	
		
		if (Mz==23'b0 && Ez==8'b0)
		$display ("case3: Pass");
		else 
		$display ("case3: Fail");	
		
////////////
		Mx = 23'b 0; 
		My = 23'b 0;
		Ex = 8'b 0;  
		Ey = 8'b 11111111;  
		Sx = 1'b0;
		Sy = 1'b0;		
		R_mode = 2'b00 ;
		#60	;	
		
		if (Mz==23'b 00000_11111_00000_11111_000 && Ez==8'b 11111111)
		$display ("case4: Pass");
		else 
		$display ("case4: Fail");		
				
		#20
		
		$finish ;
	end


always #10  CLK = ~CLK; 


Top_Mul S1 
(
.Mx_ext(Mx),
.My_ext(My),
.Mz_ext(Mz),
.Ex_ext(Ex),
.Ey_ext(Ey),
.Ez_ext(Ez),
.Sx_ext(Sx),
.Sy_ext(Sy),
.Sz_ext(Sz),
.CLK(CLK),
.RST(RST),
.R_mode_ext(R_mode),
.Mul_enable(Mul_enable),
.invalid_flag_ext(invalid_flag),
.overflow_flag_ext(overflow_flag),
.underflow_flag_ext(underflow_flag),
.inexact_flag_ext(inexact_flag),
.zero_flag_ext(zero_flag)

);

endmodule
module significand_tb ();

reg   [23:0]       Mx,My;
reg 	           zero_Ex,zero_Ey;
reg	  [1:0] 	   R_mode ;
reg  			   Sz;
wire  [22:0]       Mz;
wire			   ovf;
wire  [4:0]		   SHL;
wire			   Overflow_after_round;



initial 
	begin 
		$dumpfile("Significand.vcd") ;
		$dumpvars ;
		
		Mx = 23'b00001100010000000000000;
		My = 23'b00001100011001000100000;
		zero_Ex = 1'b0 ;
		zero_Ey = 1'b0 ;
	    Sz = 1'b0 ;
		R_mode = 2'b00 ;
		#10

		Mx = 24'b01111100010001000010000;
		My = 24'b1111111111111111111111;
		zero_Ex = 1'b0 ;
		zero_Ey = 1'b0 ;
		Sz = 1'b1 ;
		R_mode = 2'b00 ;
		#10		
		
		
		
		
		
		
		
		
		
		
		
		#10
		$finish ;
	end





significand S1 
(
.Mx(Mx),
.My(My),
.zero_Ex(zero_Ex),
.zero_Ey(zero_Ex),
.R_mode(R_mode),
.Sz(Sz),
.Mz(Mz),
.ovf(ovf),
.SHL(SHL),
.Overflow_after_round(Overflow_after_round)
);

endmodule
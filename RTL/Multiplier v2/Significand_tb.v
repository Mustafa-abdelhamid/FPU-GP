module significand_tb ();

reg   [23:0]       Mx,My;
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
		
		Mx = 24'b0000_0110_0010_0000_0000_0000;
		My = 24'b0000_0110_0011_0010_0010_0000;
		Sz = 1'b0 ;
		R_mode = 2'b00 ;
		#10

		///////
		
		Mx = 24'b0000_0110_0010_0000_0000_0000;
		My = 24'b0000_0110_0011_0010_0010_0000;
		Sz = 1'b0 ;
		R_mode = 2'b00 ;
		#10

		//////
		
		
		Mx = 24'b0000_0110_0010_0000_0000_0000;
		My = 24'b0000_0110_0011_0010_0010_0000;
		Sz = 1'b0 ;
		R_mode = 2'b00 ;		
		#10


		Mx = 24'b0000_0110_0010_0000_0000_0000;
		My = 24'b0000_0110_0011_0010_0010_0000;
		Sz = 1'b0 ;
		R_mode = 2'b00 ;

		
		#10
		$finish ;
	end





significand S1 
(
.Mx(Mx),
.My(My),
.R_mode(R_mode),
.Sz(Sz),
.Mz(Mz),
.ovf(ovf),
.SHL(SHL),
.Overflow_after_round(Overflow_after_round)
);

endmodule
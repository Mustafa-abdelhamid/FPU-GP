module sticky_bit_tb ();

reg	 [22:0]	 leastbits; 
wire 	 sticky;

initial 
	begin 
		$dumpfile("Top_Add_Sub.vcd") ;
		$dumpvars ;
		
		leastbits = 23'b0000_0000_0000_0000_0000_000;
		#10
		if (sticky==0)
		$display ("success");
		else 
		$display ("Failed");
		///////
		
		leastbits = 23'b0000_0000_0000_0000_0000_010;
		#10
		if (sticky==1)
		$display ("success");
		else 
		$display ("failed");
		//////
		
		
		leastbits = 23'b0000_0000_1000_0000_0000_010;
		#10
		if (sticky==1)
		$display ("success");
		else 
		$display ("failed")	;


		leastbits = 23'b11111111111111111111111;
		#10
		if (sticky==1)
		$display ("success");
		else 
		$display ("failed")	;	
		
		#10
		$finish ;
	end

sticky_bit TT 
(
.leastbits(leastbits),
.sticky (sticky)
);

endmodule 
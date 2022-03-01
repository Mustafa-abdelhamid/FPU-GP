module Tob_Add_Sub_tb();

reg		[7:0]	Ex_tb;
reg		[7:0]	Ey_tb;
wire	[7:0]	Ez_tb;
reg		[22:0]	Mx_tb;
reg		[22:0]	My_tb;
wire	[22:0]	Mz_tb;
reg				Sx_tb;			
reg				Sy_tb;			
wire			Sz_tb;	
reg				Eop_tb;	
reg				sub_tb;							
wire  			invalid_flag_tb,overflow_flag_tb,underflow_flag_tb,inexact_flag_tb,zero_flag_tb;
reg	    [1:0]   roundMode_tb;

initial 
  begin
    $dumpfile("Top_Add_Sub.vcd") ;
    $dumpvars ;
	
	//test(1'b0, 23'b110_00000_00000_00000_00000, 8'b100, 1'b0, 1'b0, 23'b010_00000_00000_00000_00000, 8'b010, 1'b0, 2'b00);
	$display ("test case 1") ; 
	test(1'b0, 23'b11100000000000000000000, 8'b10000001,  //operand 1 
		 1'b0,  //operation
		 1'b0, 23'b00100000000000000000000, 8'b10000000,   //operand 2 
		 1'b0,
		 2'b00); // round mode
		 #1;  
	if ( (Ez_tb == 8'b10000010) &&
		(Mz_tb == 23'b00111000000000000000000) &&
		(Sz_tb == 1'b0) &&  
		({invalid_flag_tb,overflow_flag_tb,underflow_flag_tb,inexact_flag_tb,zero_flag_tb}== 5'b00000)) 
			$display("test case 1 Passed" ) ;
	else 
			$display ("test case 1 failed ") ; 
	#10 ;

	 	$display ("test case 2 .... testing inexact") ; 
	test(1'b0, 23'b 10000000000000000000001, 8'b 10000000,  //operand 1 
		 1'b0,  //operation
		 1'b0, 23'b 10000000000000000000000, 8'b 10000001,   //operand 2 
		 1'b0,
		 2'b00); // round mode
		 #1;  
	if ( (Ez_tb == 8'b 10000010) &&
		(Mz_tb == 23'b 00100000000000000000000) &&
		(Sz_tb == 1'b0) &&  
		({invalid_flag_tb,overflow_flag_tb,underflow_flag_tb,inexact_flag_tb,zero_flag_tb}== 5'b00010)) 
			$display("test case 2 Passed" ) ;
	else 
			$display ("test case 2 failed ") ; 
	#10 ;	$display ("test case 3 ..... testing NAN") ; 
	test(1'b0, 23'b 00000000000001000001000, 8'b 11111111,  //operand 1 
		 1'b0,  //operation
		 1'b0, 23'b00100000000000000000000, 8'b10000000,   //operand 2 
		 1'b0,
		 2'b00); // round mode
		 #2;  
	if ( (Ez_tb == 8'b 11111111) &&
		(Mz_tb != 23'b 00000000000000000000000) &&
		(Sz_tb == 1'b0) &&  
		({invalid_flag_tb,overflow_flag_tb,underflow_flag_tb,inexact_flag_tb,zero_flag_tb}== 5'b10000)) 
			$display("test case 3 Passed" ) ;
	else 
			$display ("test case 3 failed ") ; 
	#10 ;	$display ("test case 4 .... inf - inf ") ; 
	test(1'b0, 23'b 00000000000000000000000, 8'b 11111111,  //operand 1 
		 1'b1,  //operation
		 1'b0, 23'b 00000000000000000000000, 8'b 11111111,   //operand 2 
		 1'b1,
		 2'b00); // round mode
		 #2;  
	if ( (Ez_tb == 8'b 11111111) &&
		(Mz_tb != 23'b00000000000000000000000) &&
		(Sz_tb == 1'b1) &&  
		({invalid_flag_tb,overflow_flag_tb,underflow_flag_tb,inexact_flag_tb,zero_flag_tb}== 5'b10000)) 
			$display("test case 4 Passed" ) ;
	else 
			$display ("test case 4 failed ") ; 
	#10 ;
	$display ("test case 5 .... Subtraction ") ; 
	test(1'b0, 23'b 11100000000000000000000, 8'b 10000001,  //operand 1 
		 1'b1,  //operation
		 1'b0, 23'b 00100000000000000000000, 8'b 10000000,   //operand 2 
		 1'b1,
		 2'b00); // round mode
		 #2;  
		 
	if ( (Ez_tb == 8'b 10000001) &&
		(Mz_tb == 23'b 01010000000000000000000) &&
		(Sz_tb == 1'b0) &&  
		({invalid_flag_tb,overflow_flag_tb,underflow_flag_tb,inexact_flag_tb,zero_flag_tb}== 5'b00000)) 
			$display("test case 5 Passed" ) ;
	else 
			$display ("test case 5 failed ") ; 
	#10 ;
	$display ("test case 6 .... Subtraction negative ") ; 
	test(1'b0, 23'b 00100000000000000000000, 8'b 10000000,  //operand 1 
		 1'b1,  //operation
		 1'b0, 23'b 11100000000000000000000, 8'b 10000001,   //operand 2 
		 1'b1,
		 2'b00); // round mode
		 #2;  
		 
	if ( (Ez_tb == 8'b 10000001) &&
		(Mz_tb == 23'b 01010000000000000000000) &&
		(Sz_tb == 1'b1) &&  
		({invalid_flag_tb,overflow_flag_tb,underflow_flag_tb,inexact_flag_tb,zero_flag_tb}== 5'b00000)) 
			$display("test case 6 Passed" ) ;
	else 
			$display ("test case 6 failed ") ; 
	#10 ;
	$display ("test case 7 .... massive shift left ") ; 
	test(1'b0, 23'b 00100000000000000000000, 8'b 10000001,  //operand 1 
		 1'b1,  //operation
		 1'b0, 23'b 11100000000000000000000, 8'b 10000001,   //operand 2 
		 1'b1,
		 2'b00); // round mode
		 #2;  
		 
	if ( (Ez_tb == 8'b 10000000) &&
		(Mz_tb == 23'b 10000000000000000000000) &&
		(Sz_tb == 1'b1) &&  
		({invalid_flag_tb,overflow_flag_tb,underflow_flag_tb,inexact_flag_tb,zero_flag_tb}== 5'b00000)) 
			$display("test case 7 Passed" ) ;
	else 
			$display ("test case 7 failed ") ; 
	#10 ;
	$display ("test case 8 .... massive shift left ") ; 
	test(1'b0, 23'b 11100000000000100000000, 8'b 10000001,  //operand 1 
		 1'b1,  //operation
		 1'b0, 23'b 11100000000000000000000, 8'b 10000001,   //operand 2 
		 1'b1,
		 2'b00); // round mode
		 #2;  
		 
	if ( (Ez_tb == 8'b 01110010) &&
		(Mz_tb == 23'b 00000000000000000000000) &&
		(Sz_tb == 1'b0) &&  
		({invalid_flag_tb,overflow_flag_tb,underflow_flag_tb,inexact_flag_tb,zero_flag_tb}== 5'b00000)) 
			$display("test case 8 Passed" ) ;
	else 
			$display ("test case 8 failed ") ; 
	#10 ;
	$display ("test case 9 .... +inf ") ; 
	test(1'b0, 23'b 11100000000000100000011, 8'b 11111110,  //operand 1 
		 1'b0,  //operation
		 1'b0, 23'b 11100000000000000000011, 8'b 11111110,   //operand 2 
		 1'b0,
		 2'b00); // round mode
		 #2;  
		 
	if ( (Ez_tb == 8'b 11111111) &&
		(Mz_tb == 23'b 00000000000000000000000) &&
		(Sz_tb == 1'b0) &&  
		({invalid_flag_tb,overflow_flag_tb,underflow_flag_tb,inexact_flag_tb,zero_flag_tb}== 5'b01000)) 
			$display("test case 9 Passed" ) ;
	else 
			$display ("test case 9 failed ") ; 
	#10 ;
	$display ("test case 10 .... +inf ") ; 
	test(1'b0, 23'b 11111111111111111111111, 8'b 11111110,  //operand 1 
		 1'b0,  //operation
		 1'b0, 23'b 11111111111111111111111, 8'b 11111110,   //operand 2 
		 1'b0,
		 2'b00); // round mode
		 #2;  
		 
	if ( (Ez_tb == 8'b 11111111) &&
		(Mz_tb == 23'b 00000000000000000000000) &&
		(Sz_tb == 1'b0) &&  
		({invalid_flag_tb,overflow_flag_tb,underflow_flag_tb,inexact_flag_tb,zero_flag_tb}== 5'b01000)) 
			$display("test case 10 Passed" ) ;
	else 
			$display ("test case 10 failed ") ; 
	#10 ;
    // $finish ;
    
  end


task test ;
input				sx;
input	[22:0]		mx;
input	[7:0]		ex;
input				op;
input				sy;
input	[22:0]		my;
input	[7:0]		ey;
input				sub_sig;
input	[1:0]		round_mode;
	begin
	
	Sx_tb = sx;	
	Mx_tb = mx;
	Ex_tb = ex;
	
	Eop_tb = op;
	
	Sy_tb = sy;	
	My_tb = my;
	Ey_tb = ey;

	sub_tb = sub_sig;
	roundMode_tb=round_mode;
	end
endtask	






Top_Add_Sub		DUT (
.Mx(Mx_tb),
.My(My_tb),
.Mz_final(Mz_tb),
.Ex(Ex_tb),
.Ey(Ey_tb),
.Ez(Ez_tb),
.Sx(Sx_tb),
.Sy(Sy_tb),
.Sz(Sz_tb),
.EOP(Eop_tb),
.sub(sub_tb),
.roundMode(roundMode_tb),
.invalid_flag(invalid_flag_tb),
.overflow_flag(overflow_flag_tb),
.underflow_flag(underflow_flag_tb),
.inexact_flag(inexact_flag_tb),
.zero_flag(zero_flag_tb)
);

endmodule
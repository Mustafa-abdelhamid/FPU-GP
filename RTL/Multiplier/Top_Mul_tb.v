	`timescale 1ns/1ns 

module Top_Mul_tb ();

reg 			CLK,RST;
reg 	[7:0]	Ex,Ey;
reg 	[22:0]	Mx,My;
reg 	     	Sx,Sy;
reg 	[1:0]	R_mode;
wire 	[22:0]	Mz;
wire 	[7:0]	Ez;
wire 		    Sz;
wire 			underflow_flagex,inexact_flagex,zero_flagex,
				invalid_flagex, overflow_flagex;////////


/////////////////////////////////////////////////////////
///////////////////// Parameters ////////////////////////
/////////////////////////////////////////////////////////

parameter cases_number =  15000;
parameter tclk = 20;



/////////////////////////////////////////////////////////
///////////////// Loops Variables ///////////////////////
/////////////////////////////////////////////////////////

integer           Operation,check_op ;
integer			  Failed_Cases = 0;
integer			  Passed_Cases = 0;

integer			  failed_zero = 0;
integer			  failed_underflow = 0;
integer			  failed_invalid = 0;
integer			  failed_ovf = 0;

integer			  Under_Ovf_conflict= 0 ;


//integer			  denorm_cases = 0;

/////////////////////////////////////////////////////////
/////////////////////// Memories ////////////////////////
/////////////////////////////////////////////////////////

reg    [31:0]   X_values     [cases_number:1] ;
reg    [31:0]   Y_values  	 [cases_number:1] ;
reg    [31:0]   mul_values   [cases_number:1] ;


/////////
initial CLK = 0;
//////
always
#(tclk/2) CLK = ~CLK;

initial //main block && input setting
  begin
    $dumpfile("Top_Mul_tb.vcd") ;
    $dumpvars ;
	// Read Input Files
	$readmemb("single_x.txt", X_values);
	$readmemb("single_y.txt", Y_values);
	
	$readmemb("single_multiplication.txt", mul_values);
	
	RST = 1;
	#(tclk);
	RST = 0;	
	#(tclk*10); //10clk
	RST = 1;
	// check Mul 
	 for (Operation=1;Operation<=cases_number;Operation=Operation+1)
	  begin
	  test(X_values[Operation],  //operand 1 
		   Y_values[Operation],   //operand 2 
		   2'b00 // round mode
		  ); 
		#(tclk) ; 
	  end
	  
	#(10*tclk);
	
	$display ("%d Failed Cases",Failed_Cases);
	$display ("%d Passed Cases",Passed_Cases);
	//$display ("%d denorm_cases Cases",denorm_cases);

	$display ("%d failed_ovf",failed_ovf);
	$display ("%d failed_underflow",failed_underflow);
	$display ("%d failed_zero",failed_zero);
	$display ("%d failed_invalid",failed_invalid);

	
	#100;
	$finish ;
  end
  
 ////////////// checking //////////// 
 ///////////////////////////////////
initial 
	begin 
	#(20*tclk);
	
	 for (check_op=1;check_op<=(cases_number);check_op=check_op+1)
	  begin
	   check_out(mul_values[check_op],check_op) ;           // check output response
	   #tclk ;
	  end
	  
	end

	
	
//////////////////////////////TASKS /////////////////////
/////////////////////////////////////////////////////////
task test ;
input	[31:0]		first_operand;
input	[31:0]		second_operand;
input	[1:0]		round_mode;

	begin
	
	Sx = first_operand[31];	
	Ex = first_operand[30:23];
	Mx = first_operand[22:0];
	
	Sy = second_operand[31];	
	Ey = second_operand[30:23];
	My = second_operand[22:0];
	
	R_mode=round_mode;
	end
endtask	



////////////////// Check Out Response  ////////////////////

task check_out ;
 input  reg     [31:0]     expec_out ;
 input  integer            Oper_Num ; 

 //output integer i ;
 //reg genr_out ;
 begin
	//genr_out = {Sz,Ez,Mz};
	if ({Sz,Ez,Mz} == expec_out)
    begin
	 //if (Ez==0 && Mz!=0) begin  denorm_cases = denorm_cases +1 ; end
	 if  (Ez==0 && Mz==0)
			if (zero_flagex != 1'b1) failed_zero = failed_zero + 1 ;
			
	 if  (Ez==0 && Mz!=0) begin 
			if (underflow_flagex != 1'b1) failed_underflow = failed_underflow + 1 ;
			else if (zero_flagex==1'b1)  $display("conflict %d ", Oper_Num); end

	 if  (Ez==8'b1111_1111 && Mz==0)
			if (failed_ovf != 1'b1) begin  failed_ovf = failed_ovf + 1 ;   $display("ovvvver %d is failed", Oper_Num); end
			
	 if  (Ez==8'b1111_1111 && Mz==23'b 11111_11111_11111_11111_111)
			if (invalid_flagex != 1'b1) failed_invalid = failed_invalid + 1 ;
			
	 Passed_Cases = Passed_Cases + 1 ;
    end
   else
    begin
     $display("Test Case %d is failed", Oper_Num);
	 $display("genr_out %d : %b ", Oper_Num,{Sz,Ez,Mz});
	 $display("Expect   %d : %b ", Oper_Num,expec_out);
	 $display();

	 Failed_Cases = Failed_Cases + 1 ;
    end
	
 end
endtask


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
.CLK(CLK),
.RST(RST),
.R_mode(R_mode),
.invalid_flagex(invalid_flagex),
.overflow_flagex(overflow_flagex),
.underflow_flagex(underflow_flagex),
.inexact_flagex(inexact_flagex),
.zero_flagex(zero_flagex)
);

endmodule













































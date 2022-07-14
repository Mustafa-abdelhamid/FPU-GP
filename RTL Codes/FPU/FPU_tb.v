`timescale 1ns/1ps 

module FPU_tb ();

reg  		 [7:0]        Ex,Ey;
reg   		 [22:0]       Mx,My;
reg                	  	  Sx,Sy;
reg               	  	  en_add_mul;							//add=1 , mul=0
reg              		  sub;
reg	 		 [1:0] 		  roundMode;
reg               	  	  rst , clk; 

//outputs
wire  		 [7:0]        Ez;
wire  	 	 [22:0]       Mz;
wire              	 	  Sz;
wire 				 	  invalid_flag,overflow_flag,underflow_flag,inexact_flag,zero_flag;



/////////////////////////////////////////////////////////
///////////////////// Parameters ////////////////////////
/////////////////////////////////////////////////////////

parameter cases_number =  10000;
parameter tclk 		   =  10;



/////////////////////////////////////////////////////////
///////////////// Loops Variables ///////////////////////
/////////////////////////////////////////////////////////

integer           Operation,check_op ;
integer			  Failed_Cases	   = 0;
integer			  Passed_Cases     = 0;

integer			  failed_zero 	   = 0;
integer			  failed_underflow = 0;
integer			  failed_invalid   = 0;
integer			  failed_ovf       = 0;
integer			  Pass_under       = 0;

integer 		  succeeded        	  ;
integer			  failed 		      ;


/////////////////////////////////////////////////////////
/////////////////////// Memories ////////////////////////
/////////////////////////////////////////////////////////

reg    [31:0]   X_values_mul     [cases_number:1]   ;
reg    [31:0]   Y_values_mul  	 [cases_number:1]   ;
reg    [31:0]   X_values_add     [cases_number-1:0]   ;
reg    [31:0]   Y_values_add  	 [cases_number-1:0]   ;
reg    [31:0]   mul_values  	 [cases_number:1]   ;
reg    [31:0]   add_values  	 [cases_number-1:0] ;
//reg    [31:0]   sub_values  	 [cases_number-1:0] ;
//////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////
////////////////	CLK		//////////////////////////////

initial clk = 0;
always	#(tclk/2) clk = ~clk;
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
//////////////////// initial_blok ///////////////////////
////////////////////////////////////////////////////////

initial //main block && input setting
  begin
    $dumpfile("FPU_tb.vcd") ;
    $dumpvars ;
	// Read Input Files
	$readmemb("single_x_mul.txt", X_values_mul); //for_mul
	$readmemb("single_y_mul.txt", Y_values_mul); //for_mul
	$readmemb("single_x_add.txt", X_values_add); //for_add
	$readmemb("single_y_add.txt", Y_values_add); //for_add
	//$readmemb("single_subtraction.txt", sub_values);
	$readmemb("single_addition.txt", add_values);
	$readmemb("single_multiplication.txt", mul_values);
		succeeded = 0;
	failed = 0;
	en_add_mul = 1;
	if(en_add_mul)
		begin
			reset_high();
		end
	else
		begin
			reset_low();
		end
	

	
	
	
if(en_add_mul)
	begin
	
		 for (Operation=0;Operation<cases_number;Operation=Operation+1)
	  begin
	  test_add(X_values_add[Operation],  //operand 1 
			   1'b0,  //Operation
			   Y_values_add[Operation],   //operand 2 
			   1'b0, //EOP
			   2'b00); // round mode
		#(35*tclk) ;
		//#tclk; 
	   check_out_add(add_values[Operation],Operation) ;           // check output response
	   #tclk;
	  end
	end
else
	begin
	#(tclk*30);// check Mul 
	 for (Operation=1;Operation<=cases_number;Operation=Operation+1)
	  begin
	  test_mul(X_values_mul[Operation],  //operand 1 
			   Y_values_mul[Operation],   //operand 2 
			   2'b00 // round mode
			  ); 
		#(tclk) ; 
	  end
	  
	#(11*tclk);
	
	$display ("%d Failed Cases",Failed_Cases);
	$display ("%d Passed Cases",Passed_Cases);
	$display ("%d failed_ovf",failed_ovf);
	$display ("%d failed_underflow",failed_underflow);
	$display ("%d failed_zero",failed_zero);
	$display ("%d failed_invalid",failed_invalid);
	
	end



	#100;
	$finish ;
  end
  

////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 ////////////// checking //////////// 
 ///////////////////////////////////

initial 
	begin 
	if(!en_add_mul)
		begin
		#(41*tclk);
	
	 for (check_op=1;check_op<=(cases_number);check_op=check_op+1)
	  begin
	   check_out_mul(mul_values[check_op],check_op) ;           // check output response
	   check_flag_mul(mul_values[check_op],check_op) ;           // check output response
	   #tclk ;
	  end	  
		end

end






	
	
 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
///////////////////////////// TASKS /////////////////////
/////////////////////////////////////////////////////////


///////////////////////// RESET /////////////////////////
task reset_high;
 begin
 rst =  'b0;
 #(tclk*10);
 rst  = 'b1;
 #tclk
 rst  = 'b0;
 //#tclk;
 end
endtask  


task reset_low;
 begin
 rst =  'b1;
 #tclk
 rst  = 'b0;
 #tclk
 rst  = 'b1;
 end
endtask  

/////////////////////////////////////////////////////////////
///////////////////////////// MUL ///////////////////////////

//////////////////////////////test_mul /////////////////////
task test_mul ;
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
	
	roundMode=round_mode;
	end
endtask	


///////////////// Check Out Response  ////////////////////
task check_out_mul ;
 input  reg     [31:0]     expec_out ;
 input  integer            Oper_Num ; 

 //output integer i ;
 //reg genr_out ;
 begin
	//genr_out = {Sz,Ez,Mz};
	if ({Sz,Ez,Mz} == expec_out)
    begin
	 //if (Ez==0 && Mz!=0) begin  denorm_cases = denorm_cases +1 ; end

			
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

task check_flag_mul ;
 input  reg     [31:0]     expec_out ;
 input  integer            Oper_Num ; 

 //output integer i ;
 //reg genr_out ;
 begin
 if  (Ez==0 && Mz==0)
			if (zero_flag != 1'b1) 
			begin 
			failed_zero = failed_zero + 1 ; 
			//$display("zflag %d is failed", Oper_Num);
			end
			
	 if  (Ez==0 && Mz!=0)
	 begin
	 	Pass_under = Pass_under + 1;
		
			if (underflow_flag != 1'b1) begin failed_underflow = failed_underflow + 1 ; 	$display("undflag %d is failed", Oper_Num);end
			
	end
	 if  (Ez==8'b1111_1111 && Mz==0)
			if (overflow_flag != 1'b1) begin  failed_ovf = failed_ovf + 1 ;   $display("ovvvver %d is failed", Oper_Num); end
			
	 if  (Ez==8'b1111_1111 && Mz==23'b 11111_11111_11111_11111_111)
			if (invalid_flag != 1'b1) begin failed_invalid = failed_invalid + 1 ; $display("inv %d is failed", Oper_Num);end
 end
endtask

/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////




/////////////////////////////////////////////////////////////
///////////////////////////// ADDER ////////////////////////

task test_add ;

input	[31:0]		first_operand;
input				op;
input	[31:0]		second_operand;
input				sub_sig;
input	[1:0]		round_mode;
	begin
	
	Sx = first_operand[31];	
	Mx = first_operand[22:0];
	Ex = first_operand[30:23];
	
	//Eop_tb = op  ^  first_operand[31] ^ second_operand[31];
	
	Sy = second_operand[31];	
	My = second_operand[22:0];
	Ey = second_operand[30:23];

	sub = sub_sig;
	roundMode=round_mode;
	end
endtask	



///////////////// Check Out Response  ////////////////////

task check_out_add ;
 input  reg     [31:0]     expec_out ;
 input  integer            Oper_Num ; 

 //output integer i ;
 
 reg    [31:0]     gener_out ;

 begin
	if ({Sz,Ez,Mz} == expec_out)
    begin
	 succeeded = succeeded + 1;	
	 $display("real output");
	 $display("%b",{Sz,Ez,Mz});
	 $display("expected output");
	 $display("%b",expec_out);	
     $display("Test Case %d is succeeded",Oper_Num);
	  
    end
   else
    begin
	 failed = failed + 1;	
	 $display("real output");
	 $display("%b",{Sz,Ez,Mz});
	 $display("expected output");
	 $display("%b",expec_out);		
     $display("Test Case %d is failed", Oper_Num);
	
    end
	$display("succeeded %d", succeeded);
	$display("failed %d", failed);
 end
endtask


/////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







////////////////////////////////////////////////////////
///////////////////// Instantation //////////////////////
////////////////////////////////////////////////////////

FPU DUT
(
.Ex(Ex),
.Ey(Ey),
.Mx(Mx),
.My(My),
.Sx(Sx),
.Sy(Sy),
.en_add_mul(en_add_mul),							//add=1 (), mul=0
.sub(sub),
.roundMode(roundMode),
.rst (rst), 
.clk(clk), 

//outputs
.Ez(Ez),
.Mz(Mz),
.Sz(Sz),
.invalid_flag(invalid_flag),
.overflow_flag(overflow_flag),
.underflow_flag(underflow_flag),
.inexact_flag(inexact_flag),
.zero_flag(zero_flag)
);
//////////////////////////////////////////////////////////




endmodule




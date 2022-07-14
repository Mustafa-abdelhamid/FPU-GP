`timescale 1ns/1ns
module Saleh_tb();
reg             rst_tb;
reg 			clk_tb;
reg enable_tb;
reg		[7:0]	Ex_tb;
reg		[7:0]	Ey_tb;
wire	[7:0]	Ez_tb;
reg		[22:0]	Mx_tb;
reg		[22:0]	My_tb;
wire	[22:0]	Mz_tb;
reg				Sx_tb;			
reg				Sy_tb;			
wire			Sz_tb;	
//reg				Eop_tb;	
reg				sub_tb;							
wire  			invalid_flag_tb,overflow_flag_tb,underflow_flag_tb,inexact_flag_tb,zero_flag_tb;
reg	    [1:0]   roundMode_tb;
//outputs taken from Exponont_Difference
///wire [7:0]d;
///wire sgn_d;
///wire zero_d;
//outputs taken from Alignment
///wire Cmp;
///wire [26:0]out_11;
///wire [26:0]out_22;
//outputs taken from adder_modified
///wire EOP;
///wire [26:0]sum;
///wire ovf_rnd;
//outputs taken from mux
///wire [7:0]Out_mux;
//outputs taken from LZA_massive_SHL
///wire [4:0]massive_shift_left;
///output wire [55:0]correct_sum_shifted,
//outputs taken from left_right_shifter
///wire ovf;
///wire [26:0]righPass_shift_out;
///wire one_shift_left;
//outputs taken from mantessa_mux
///wire [2:0]most_bits_of_adder_out;
///wire [55:0]mantessa_mux_out;
//outputs taken from round
///wire [23:0]MOut;
//outputs taken from exponent_update
///wire [7:0]E_exponent_update;
///wire max_exponent_z;
///wire min_exponent_z;
///wire [9:0]excessive_shift_left;
///outputs taken from submodule in LZA_and_massive_SHL
//output [26:0]E,
///wire [4:0]SHL;       
///output [58:0]sum_shifted,   
///wire second_shift_left; 

///wire [22:0]Mz_final_int;

///wire Sz_int;



/////////////////////////////////////////////////////////
///////////////////// Parameters ////////////////////////
/////////////////////////////////////////////////////////

parameter cases_number = 10000 ;
parameter CLK_PERIOD = 3 ;
parameter tcq = 10;
parameter tclk = 3;


/////////////////////////////////////////////////////////
///////////////// Loops Variables ///////////////////////
/////////////////////////////////////////////////////////

integer                       Operation ;
integer succeeded;
integer failed;

/////////////////////////////////////////////////////////
/////////////////////// Memories ////////////////////////
/////////////////////////////////////////////////////////

reg    [31:0]   X_values   [cases_number-1:0] ;
reg    [31:0]   Y_values   [cases_number-1:0] ;
reg    [31:0]   add_values   [cases_number-1:0] ;
reg    [31:0]   sub_values   [cases_number-1:0] ;
reg    [31:0]   mul_values   [cases_number-1:0] ;


Top_Add_Sub_new		DUT (
.rst(rst_tb),
.clk(clk_tb),
.enable(enable_tb),
.Mx(Mx_tb),
.My(My_tb),
.Mz_final(Mz_tb),
.Ex(Ex_tb),
.Ey(Ey_tb),
.Ez(Ez_tb),
.Sx(Sx_tb),
.Sy(Sy_tb),
.Sz(Sz_tb),
//.EOP(Eop_tb),
.sub(sub_tb),
.roundMode(roundMode_tb),
.invalid_flag(invalid_flag_tb),
.overflow_flag(overflow_flag_tb),
.underflow_flag(underflow_flag_tb),
.inexact_flag(inexact_flag_tb),
.zero_flag(zero_flag_tb)
///.d(d),
///.sgn_d(sgn_d),
///.zero_d(zero_d),
///.Cmp(Cmp),
///.out_11(out_11),
///.out_22(out_22),
///.EOP(EOP),
///.sum(sum),
///.ovf_rnd(ovf_rnd),
///.Out_mux(Out_mux),
///.massive_shift_left(massive_shift_left),
//.correct_sum_shifted(correct_sum_shifted),
///.ovf(ovf),
///.righPass_shift_out(righPass_shift_out),
///.one_shift_left(one_shift_left),
///.most_bits_of_adder_out(most_bits_of_adder_out),
///.mantessa_mux_out(mantessa_mux_out),
///.MOut(MOut),
///.E_exponent_update(E_exponent_update)
///.max_exponent_z(max_exponent_z),
///.min_exponent_z(min_exponent_z),
///.excessive_shift_left(excessive_shift_left),
///.SHL(SHL),
///.second_shift_left(second_shift_left),
///.Mz_final_int(Mz_final_int),
///.Sz_int(Sz_int)
);

initial clk_tb = 0;
always
#(tclk/2) clk_tb = ~clk_tb;

initial 


  begin
    $dumpfile("Top_Add_Sub.vcd") ;
    $dumpvars ;
	// Read Input Files
	$readmemb("single_x.txt", X_values);
	$readmemb("single_y.txt", Y_values);
	
	$readmemb("single_subtraction.txt", sub_values);
	$readmemb("single_addition.txt", add_values);
	$readmemb("single_multiplication.txt", mul_values);
	
	succeeded = 0;
	failed = 0;
	enable_tb = 1;
	rst_tb = 0;
	#(tclk*10);//10clk - 10ns
	rst_tb = 1;	
	#tclk;
	rst_tb = 0;
	#tclk;
	#(tclk*50);
	//#(tclk*1.5);
	// check add 
	 for (Operation=0;Operation<cases_number;Operation=Operation+1)
	  begin
	  test(X_values[Operation],  //operand 1 
		 1'b0,  //Operation
		 Y_values[Operation],   //operand 2 
		 1'b0, //EOP
		 2'b00); // round mode
		#(35*tclk) ;
		 //#tclk; 
	   check_out(add_values[Operation],Operation) ;           // check output response
	  end

	
    #100;
	//$finish ;
  end

//////////////////////////////TASKS /////////////////////
/////////////////////////////////////////////////////////
task test ;

input	[31:0]		first_operand;
input				op;
input	[31:0]		second_operand;





input				sub_sig;
input	[1:0]		round_mode;
	begin
	
	Sx_tb = first_operand[31];	
	Mx_tb = first_operand[22:0];
	Ex_tb = first_operand[30:23];
	
	//Eop_tb = op  ^  first_operand[31] ^ second_operand[31];
	
	Sy_tb = second_operand[31];	
	My_tb = second_operand[22:0];
	Ey_tb = second_operand[30:23];

	sub_tb = sub_sig;
	roundMode_tb=round_mode;
	end
endtask	



////////////////// Check Out Response  ////////////////////

task check_out ;
 input  reg     [31:0]     expec_out ;
 input  integer                      Oper_Num ; 

 //output integer i ;
 
 reg    [31:0]     gener_out ;

 begin
	if ({Sz_tb,Ez_tb,Mz_tb} == expec_out)
    begin
	 succeeded = succeeded + 1;	
	 $display("real output");
	 $display("%b",{Sz_tb,Ez_tb,Mz_tb});
	 $display("expected output");
	 $display("%b",expec_out);	
     $display("Test Case %d is succeeded",Oper_Num);
	  
    end
   else
    begin
	 failed = failed + 1;	
	 $display("real output");
	 $display("%b",{Sz_tb,Ez_tb,Mz_tb});
	 $display("expected output");
	 $display("%b",expec_out);		
     $display("Test Case %d is failed", Oper_Num);
	
    end
	$display("succeeded %d", succeeded);
	$display("failed %d", failed);
 end
endtask




endmodule
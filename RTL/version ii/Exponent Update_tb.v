module Exponent_Update_tb();

reg [7:0] maxOf_Ex_Ey; 
reg  ovf,ovf_rnd;
	//input wire  L_R_shift , // required shift by L1/R1 shifter
	//input wire  select_leftOrRight ,
reg	[4:0] reqiredShift_left ; // LZA output (shift requred for massive shifter)
wire	[4:0] mantissaReqiredModify ; // to modify mantisa in case of underflow
wire [7:0]  Ez;
wire underflow_flag; 
wire overflow_case ;

Exponent_Update DUT(
 maxOf_Ex_Ey, 
ovf,ovf_rnd,
reqiredShift_left , // LZA output (shift requred for massive shifter)
mantissaReqiredModify , // to modify mantisa in case of underflow
Ez,
underflow_flag ,
overflow_case
//max_exponent_z 
 );

initial 
	begin 
	maxOf_Ex_Ey= 8'b00000100; //4 
	ovf= 1'b0 ;
	ovf_rnd= 1'b0 ;
	reqiredShift_left= 5'b 00000 ; 
	
	#10 ;

	ovf= 1'b1 ;
	ovf_rnd= 1'b0 ;
	reqiredShift_left= 5'b 00000 ; 
	
	#10 ;
	ovf= 1'b1 ;
	ovf_rnd= 1'b1 ;
	reqiredShift_left= 5'b 00000 ; 
	
	#10 ;
	ovf= 1'b1 ;
	ovf_rnd= 1'b0 ;
	reqiredShift_left= 5'b 00010 ; 
	
	#10 ;
	ovf= 1'b0 ;
	ovf_rnd= 1'b1 ;
	reqiredShift_left= 5'b 01000 ; 
	
	#10 ;
	maxOf_Ex_Ey= 8'b 1111_1111 ;
	ovf= 1'b1 ;
	ovf_rnd= 1'b1 ;
	reqiredShift_left= 5'b 00000 ; 
	end
	
endmodule
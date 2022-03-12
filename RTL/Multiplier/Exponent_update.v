module Exponent_Update(
    input wire [9:0] maxOf_Ex_Ey, 
    input wire  ovf,ovf_rnd,
	//input wire  L_R_shift , // required shift by L1/R1 shifter
	//input wire  select_leftOrRight ,
	input wire	[4:0] reqiredShift_left , // LZA output (shift requred for massive shifter)
	output reg	[7:0] mantissaReqiredModify , // to modify mantisa in case of underflow //max is 127 so it's 8 bit 
    output reg [7:0]  Ez,
	output reg underflow_flag , overflow_case 
    );
	
 		

	reg [9:0] internal  ; 
	reg determine_flag ; 
always@(*) 
  begin
	 
	internal=maxOf_Ex_Ey +~reqiredShift_left+1'b1
								 + ovf +ovf_rnd; 
								 
	if (internal[8])
		begin
			if (~internal[9]) //overflow
				begin
					underflow_flag=1'b0 ;
					overflow_case= 1'b1 ; 
					Ez= 8'b 11111111 ;
					mantissaReqiredModify = 8'b00000000 ;
				end
			else  // underflow case
				begin
					underflow_flag=1'b1 ;
					overflow_case= 1'b0 ; 
					Ez= 8'b 00000000 ;
					mantissaReqiredModify = ~internal + 1'b1 ;
				end
		end
	else 
		begin
		underflow_flag=1'b0 ;
		overflow_case= 1'b0 ; 
		mantissaReqiredModify=8'b00000000;
		Ez=internal[7:0] ;
		end 
  end
   
endmodule   
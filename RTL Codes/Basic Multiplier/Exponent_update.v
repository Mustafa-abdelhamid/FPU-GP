module Exponent_Update
(
	//input 	 wire 					CLK,RST, 

    input 	 wire	 [9:0] 			Ez_add, 
    input	 wire  					ovf,ovf_rnd,
	input	 wire	 [4:0]			SHL , // LZA output (shift requred for massive shifter)
    output 	 reg 	 [7:0] 			Ez,
	output 	 reg 					underflow_case , overflow_case 
    );
	
	reg		 [9:0] 		internal  ; 
	reg 				determine_flag ; 
	
	
/////flip_flops

//reg					ovf_rnd_f ,ovf_f1, ovf_f2, ovf_f3;	
	
//reg	 	[4:0]		SHL_f1, SHL_f2, SHL_f3;	

//reg     [9:0] 			Ez_add_f1, Ez_add_f2, Ez_add_f3, Ez_add_f4, Ez_add_f5 ;
	
always@(*) 
  begin
	 
	internal= Ez_add +~ SHL + 1'b1 + ovf + ovf_rnd; 
				
    
	
	if (internal[8] || internal[7:0]==8'b11111111)
		begin
			if (~internal[9]) //overflow
				begin
					underflow_case=1'b0 ;
					overflow_case= 1'b1 ; 
					Ez= 8'b 11111111 ;
		//			mantissaReqiredModify = 8'b00000000 ;
				end
			else  // underflow case
				begin
					underflow_case=1'b1 ;
					overflow_case= 1'b0 ; 
					Ez= 8'b 00000000 ;
		//			mantissaReqiredModify = ~internal + 1'b1 ;
				end
		end
	else if(~(|internal))
		begin
					underflow_case=1'b1 ;
					overflow_case= 1'b0 ; 
					Ez= 8'b 00000000 ;
		end
	
	else
		begin
		underflow_case=1'b0 ;
		overflow_case= 1'b0 ; 
//		mantissaReqiredModify=8'b00000000;
		Ez=internal[7:0] ;
		end 
  end
   
   /*
   always @ (posedge CLK or negedge RST )
	begin
	if (!RST) 
		begin
////////inputs RST
			ovf_rnd_f		<= 0 ;
			
			ovf_f1			<= 0 ;
			ovf_f2			<= 0 ;
			ovf_f3			<= 0 ;
			
			SHL_f1			<= 0 ;
			SHL_f2			<= 0 ;
			SHL_f3			<= 0 ;

			Ez_add_f1			<= 0  ;
			Ez_add_f2			<= 0  ;
			Ez_add_f3			<= 0  ;
			Ez_add_f4			<= 0  ;
			Ez_add_f5			<= 0  ;
		end
		
	else
		begin
////////inputs Reg
			ovf_rnd_f		<= ovf_rnd ;
			
			ovf_f1			<= ovf 	  ;
			ovf_f2			<= ovf_f1 ;
			ovf_f3			<= ovf_f2 ;
			
			SHL_f1			<= SHL 	  ;
			SHL_f2			<= SHL_f1 ;
			SHL_f3			<= SHL_f2 ;
			
			Ez_add_f1			<= Ez_add 	  ;
			Ez_add_f2			<= Ez_add_f1  ;
			Ez_add_f3			<= Ez_add_f2  ;
			Ez_add_f4			<= Ez_add_f3  ;
			Ez_add_f5			<= Ez_add_f4  ;
			
			
		end			
	end
   */
   
   
   
   
   
endmodule   
module left_right_shifter (
input wire [26:0] adder_out , 
input wire ovf , 
output reg [26:0] righPass_shift_out,
output reg [1:0]  righPath_exponentUpdate_control 
); 

wire [2:0] control_bits ;  
assign control_bits = {ovf,adder_out [26:25] } ; 

parameter	shift_left = 2'b 00 ,	
			shift_right= 2'b 01 , 
			donnot_shift = 2'b 10 ; 

always@(*) 
begin 
	case (control_bits)
	3'b 000:  // do nothing the left pass will be chosen 
	begin
	 righPass_shift_out=adder_out ; 
	 righPath_exponentUpdate_control= donnot_shift ; 
	end
	3'b 001:// shift left by 1 
	begin
		righPass_shift_out = adder_out <<1 ;
		righPath_exponentUpdate_control= shift_left ; 
	end
	3'b 010:// do nothing 
	begin
	righPass_shift_out=adder_out ;
	righPath_exponentUpdate_control= donnot_shift ; 
	end
	3'b 011: //do nothing 
	begin
	righPass_shift_out=adder_out ;
	righPath_exponentUpdate_control = donnot_shift ; 
	end
	3'b 100: // shift right  //edit so that the added bit is 1 
	begin
	righPass_shift_out={1'b1,adder_out[26:1]}  ;
	righPath_exponentUpdate_control = donnot_shift ; 
	end
	3'b 101: // shift right
	begin
	righPass_shift_out={1'b1,adder_out[26:1]}  ;
	righPath_exponentUpdate_control = donnot_shift ; 
	end
	3'b 110: // shift right
	begin
	righPass_shift_out={1'b1,adder_out[26:1]}  ; 
	righPath_exponentUpdate_control = donnot_shift ; 
	end
	3'b 111: // shift right
	begin
	righPass_shift_out={1'b1,adder_out[26:1]}   ;
	righPath_exponentUpdate_control = donnot_shift ; 
	end
	
	endcase 
end 
endmodule 


module Exponent_shifter(
	input wire [7:0] E,
    input wire [4:0] L_shift_value, 
    input wire  selection,
	input [1:0] L_or_R,
    output reg [7:0]  Ez_pre
    );

always@(*) 
	begin
			if(selection)
				begin
					Ez_pre = E -  L_shift_value; // left shift    left shifter
				end
			else
				begin
					case (L_or_R)
					2'b 00 :
						begin
							Ez_pre = E - 1 ; //left shift by one  L/R
						end
					2'b 01 :
						begin
							Ez_pre = E + 1; // right shift by one  L/R
						end
					default : Ez_pre = E ; 
					endcase
				end

	end
endmodule   
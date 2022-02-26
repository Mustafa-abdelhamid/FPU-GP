
module Mux(
	//input wire       CLK,
    input wire [7:0] Ex, 
    input wire [7:0] Ey,
    input wire  sgn_d, // d is sign of d 
	output reg[7:0] Out_mux
    );
always@(*) 
  begin      
		case(sgn_d)       
			1'b0 	: Out_mux = Ex ; // sign of subtraction is pos
			1'b1 	: Out_mux = Ey ; // sign of subtraction is neg
			default : Out_mux = Ex ; // check
			
		endcase
  end
endmodule   
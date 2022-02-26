
module Exponent_Update(
    input wire [7:0] Mux_Out, 
    input wire  ovf,ovf_rnd,
    output reg [7:0]  Ez
    );
	reg [1:0] R;

	always@(*) 
  begin
	R = {ovf,ovf_rnd}; 
	
		case(R)       
			2'b00 	: Ez=Mux_Out; 
			2'b01 	: Ez=Mux_Out+1'b1;			
			2'b10 	: Ez=Mux_Out+1'b1;
			2'b11 	: Ez=Mux_Out+2'b10;
			default : Ez=Mux_Out; 
			
		endcase
  end
endmodule   
	
module Alignment_7 (bit_inv_cont_x , bit_inv_cont_y , out_x_shR , out_y_with_T , out_11 , out_22);
input bit_inv_cont_x , bit_inv_cont_y;
input [26:0] out_x_shR;
input [26:0] out_y_with_T;
output reg [26:0]out_11;
output reg [26:0]out_22;
always@(*)
begin
    if(bit_inv_cont_x)
			begin
				out_11= ~out_x_shR;
			end
		else	
			begin
				out_11= out_x_shR;
			end
    if(bit_inv_cont_y)
			begin
				out_22 = ~out_y_with_T;
			end
		else	
			begin
				out_22 = out_y_with_T;
			end        
end
endmodule
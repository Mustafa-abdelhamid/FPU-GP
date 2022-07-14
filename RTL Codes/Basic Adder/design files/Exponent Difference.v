
module Exponent_Difference(
    input wire [7:0] Ex, 
    input wire [7:0] Ey,
    output reg [7:0]  d,
    output reg sgn_d,zero_d
    );
//internal signals
	reg [7:0] difference ; 
	reg carry ;
	reg ay7aga ;
	wire zero_Ex;
	wire zero_Ey;
//instances
	assign zero_Ex = ~| Ex;
	assign zero_Ey = ~| Ey;
always@(*)
begin
	if((zero_Ey && (~zero_Ex)))
		begin
			{carry,difference}= Ex + ~Ey ; 
		end
	else if((zero_Ex && (~zero_Ey)))
		begin
			{carry,difference}= Ex + ~Ey + 1'b1 + 1'b1 ;
		end
	else
		begin
			{carry,difference}= Ex + ~Ey + 1'b1 ;
		end
   if (carry) 
	begin
		{ay7aga,d}= ~difference + 1'b1 ;
	end
	else 
		begin
		d=difference ;
		ay7aga= 1'b0 ; 
		end
		
			
   if (d==0)
    begin
      zero_d=1;
    end
	else 
	begin
	zero_d=0;
	end
sgn_d=  carry ; 
end

endmodule
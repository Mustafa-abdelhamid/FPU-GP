module sign (
input  	wire 			CLK,RST,Enable,
input 	wire 	     	Sx_ext,Sy_ext,
output 	wire 		    Sz
);

reg 	     	Sx,Sy;

assign Sz = Sx ^ Sy ;

always @ (posedge CLK or negedge RST )
	begin
	if (!RST) 
		begin
			Sx <= 0;
			Sy <= 0;
		end
		
	else if (!Enable)
		begin
			Sx <= Sx_ext;
			Sy <= Sy_ext;
		end			
	end
	


endmodule
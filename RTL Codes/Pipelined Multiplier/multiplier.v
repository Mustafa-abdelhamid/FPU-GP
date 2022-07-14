module multiplier 
//inputs and outputs
(
input  	wire 			CLK,RST, 
input	wire	[23:0]	Mx_conc,My_conc,

output	reg		[47:0]	P
);

//Flip_Flops 
reg 	[23:0]	Mx,My;


//assign Mx1 = zero_Ex_f ? {1'b0,Mx} : {1'b1,Mx} ;  //for hidden bit
//assign My1 = zero_Ey_f ? {1'b0,My} : {1'b1,My} ;	//for hidden bit

//assign Mx1 = {Conc_Ex_ff,Mx};
//assign My1 = {Conc_Ey_ff,My};

always @ (posedge CLK )
	begin
	if (!RST) 
		begin
////////inputs RST
			Mx 			<= 0;
			My 			<= 0;
			P			<= 0;

		end
		
	else
		begin
////////inputs Reg
			Mx	  <= Mx_conc ;
			My	  <= My_conc ;
			P	  <= Mx * My ;
			
		end			
	end


endmodule
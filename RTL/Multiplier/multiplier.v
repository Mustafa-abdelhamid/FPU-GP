module multiplier 


//inputs and outputs
(
input  	wire 			CLK,RST, 
input 	wire 	        zero_Ex,zero_Ey,
input	wire	[22:0]	Mx_ext,
input	wire 	[22:0]	My_ext,
output	wire	[47:0]	P
);

//Flip_Flops 
reg 	[22:0]	Mx,My;

reg 	[22:0]	Mx_ff,My_ff;

reg				zero_Ex_ff,zero_Ey_ff ;
//internal signals
wire [23:0]  Mx1,My1;




assign Mx1 = zero_Ex_ff ? {1'b0,Mx} : {1'b1,Mx} ;  //for hidden bit
assign My1 = zero_Ey_ff ? {1'b0,My} : {1'b1,My} ;	//for hidden bit
assign P = Mx1 * My1 ;


always @ (posedge CLK or negedge RST )
	begin
	if (!RST) 
		begin
////////inputs RST
			Mx 			<= 0;
			My 			<= 0;
			Mx_ff		<= 0;
			My_ff		<= 0;
			zero_Ex_ff	<= 0;
			zero_Ey_ff	<= 0; 
		end
		
	else
		begin
////////inputs Reg
			Mx_ff <= Mx_ext;
			My_ff <= My_ext;
			Mx	  <= Mx_ff ;
			My	  <= My_ff ;
			
			zero_Ex_ff	<= zero_Ex ;
			zero_Ey_ff	<= zero_Ey ;
		end			
	end


endmodule
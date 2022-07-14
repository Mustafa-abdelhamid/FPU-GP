module sticky_bit 

(
input 	wire		   CLK,RST,

input 	wire 	[22:0] leastbits,
input	wire 		   Mul_MSB,
input 	wire 		   Ez_add_MSB,
output  wire		   sticky 
);

reg 		  	 Mul_MSB_f; //Mul_MSB_ff ; 
reg 		   	 Ez_add_MSB_f1, Ez_add_MSB_f2, Ez_add_MSB_f3 ;

reg 	[22:0] 	 leastbits_f;


assign sticky = (Mul_MSB_f || Ez_add_MSB_f3) ? |leastbits_f : |leastbits_f[21:0] ;

always @ (posedge CLK or negedge RST )
	begin
	if (!RST) 
		begin
////////inputs RST
			Mul_MSB_f 		<= 0;
			//Mul_MSB_ff		<= 0;
			Ez_add_MSB_f1	<= 0;
			Ez_add_MSB_f2	<= 0;
			Ez_add_MSB_f3	<= 0;
			leastbits_f  	<= 0;
		end
		
	else
		begin
////////inputs Reg
			Mul_MSB_f 		<= Mul_MSB;
			//Mul_MSB_ff		<= Mul_MSB_f;
			
			Ez_add_MSB_f1	<= Ez_add_MSB;
			Ez_add_MSB_f2	<= Ez_add_MSB_f1;
			Ez_add_MSB_f3	<= Ez_add_MSB_f2;
			
			leastbits_f		<= leastbits ;

		end			
	end
	
endmodule
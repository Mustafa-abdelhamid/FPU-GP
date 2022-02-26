module Alignment (
input	wire	[22:0]	Mx,
input	wire	[22:0]	My,

input	wire 	[7:0]	d, //from body & atef 
input	wire 	[7:0]	Ex,
input	wire 	[7:0]	Ey,
input 	wire			sgn_d,
input	wire			EOP,
input	wire			zero_d,
output	reg		       	Cmp,
output	reg		[26:0]	out_11,
output	reg		[26:0]	out_22
);

reg		[23:0]	out_x;// 22 or 25?
reg		[23:0]	out_y;

reg		[23:0]	bef_shift_y;
reg		[23:0]	bef_shift_x;

reg		[46:0]	shR_y;
reg		[46:0]	out_y_shR;   // gaurd bits ??
reg     [26:0]  out_y_with_T;
reg             sticky;	

reg		[26:0]	out_x_shR;


reg 			bit_inv_cont_x;
reg 			bit_inv_cont_y;




always @ (*)
	begin


if(Ey==0)		
	begin
		bef_shift_y = {1'b0,My[22:0]};  //// kanet l7d 1
	end
else
	begin
		bef_shift_y = {1'b1,My[22:0]};
	end

if(Ex==0)		
	begin
		bef_shift_x = {1'b0,Mx[22:0]};
	end
else
	begin
		bef_shift_x = {1'b1,Mx[22:0]};
	end			

	
	
	
		if(sgn_d)						//SWAP bloc;
			begin		
				out_x = bef_shift_y;					
				out_y = bef_shift_x;
			end 
		else 
			begin
				out_x = bef_shift_x;
				out_y = bef_shift_y;
			end
			
			
			


////// till now I have 24 bits 1(hidden) + 23(Mx,My)			
shR_y = {out_y[23:0], 23'b0 };	
out_x_shR = {out_x[23:0], 3'b0 };   
 
if(d==0)
	begin
		out_y_shR = shR_y;	//R_SHIFT block
		sticky = 1'b0;
		out_y_with_T=out_y_shR[46:20];
		
	end
else	
	begin
		out_y_shR = shR_y>>(d);		//R_SHIFT block
		sticky = |out_y_shR[20:0];
		out_y_with_T={out_y_shR[46:21],sticky};
	end
	

		

////// till now I have 27 bits 1(hidden) + 23(Mx,My) + 3(guard)		

		
	end
	
	
always @ (*)
	begin
		if(Mx>My)				//Compare Block
			begin
				Cmp = 1'b0;		
			end
		else
			begin
				Cmp = 1'b1;
			end
	
	
		
		
		if(EOP==0)					///Cont block
			begin
			bit_inv_cont_x = 0;
			bit_inv_cont_y = 0;
			end
			
		else
			begin
				if(zero_d==1)
					begin
						if (Cmp==0)
							begin
								bit_inv_cont_x = 0;
								bit_inv_cont_y = 1;	
							end
						else
							begin
								bit_inv_cont_x = 1;
								bit_inv_cont_y = 0;
							end
							
					end
				else
					begin
						bit_inv_cont_x = 0;
						bit_inv_cont_y = 1;
					end
			end
	
	end



always @ (*)
	begin
		if(bit_inv_cont_x)
			begin
				out_11= ~out_x_shR;
			end
		else	
			begin
				out_11= out_x_shR;
			end
	end
	
	
	always @ (*)
	begin
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

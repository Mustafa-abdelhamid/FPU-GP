module FPU (

//inputs
input     wire  	 [7:0]        Ex,Ey,
input     wire   	 [22:0]       Mx,My,
input     wire                	  Sx,Sy,
input     wire               	  en_add_mul,							//add=1 , mul=0
input     wire              	  sub,
input	  wire	 	 [1:0] 		  roundMode ,
input     wire               	  rst , clk, 

//outputs
output    reg  		 [7:0]        Ez,
output    reg  	 	 [22:0]       Mz,
output    reg               	  Sz,
output	  reg 				 	  invalid_flag,overflow_flag,underflow_flag,inexact_flag,zero_flag 
); 


wire	[7:0]		Ez_mul;
wire	[22:0]		Mz_mul;
wire				Sz_mul,inexact_flag_mul,invalid_flag_mul,overflow_flag_mul,underflow_flag_mul,zero_flag_mul;


wire	[7:0]		Ez_add;
wire	[22:0]		Mz_add;
wire				Sz_add,inexact_flag_add,invalid_flag_add,overflow_flag_add,underflow_flag_add,zero_flag_add;

always @ (*)
	begin		
		if(en_add_mul)
			begin
			
				Ez = Ez_add;
				Mz = Mz_add;
				Sz = Sz_add;
				
				inexact_flag   = inexact_flag_add;
				invalid_flag   = invalid_flag_add;
				overflow_flag  = overflow_flag_add;
				underflow_flag = underflow_flag_add;
				zero_flag      = zero_flag_add;
				
			end
		else
			begin
			
				Ez = Ez_mul;
				Mz = Mz_mul;
				Sz = Sz_mul;
				
				inexact_flag   = inexact_flag_mul;
				invalid_flag   = invalid_flag_mul;
				overflow_flag  = overflow_flag_mul;
				underflow_flag = underflow_flag_mul;
				zero_flag      = zero_flag_mul;
				
			end
	end	


Top_Add_Sub_new		ADDER (

.Ex(Ex),
.Ey(Ey),
.Mx(Mx),
.My(My),
.Sx(Sx),
.Sy(Sy),
.sub(sub),
.enable(en_add_mul),////////////
.roundMode(roundMode),
.rst(rst),
.clk(clk),
.Ez(Ez_add),
.Mz_final(Mz_add),
.Sz(Sz_add),
.invalid_flag(invalid_flag_add),
.overflow_flag(overflow_flag_add),
.underflow_flag(underflow_flag_add),
.inexact_flag(inexact_flag_add),
.zero_flag(zero_flag_add)
); 




Top_Mul		MUL
(
.Ex(Ex),
.Ey(Ey),
.Mx(Mx),
.My(My),
.Sx(Sx),
.Sy(Sy),
.Enable(en_add_mul),////////////
.R_mode(roundMode),
.CLK(clk),
.RST(rst),
.Mz(Mz_mul),
.Ez(Ez_mul),
.Sz(Sz_mul),
.invalid_flagex(invalid_flag_mul),
.overflow_flagex(overflow_flag_mul),
.underflow_flagex(underflow_flag_mul),
.inexact_flagex(inexact_flag_mul),
.zero_flagex(zero_flag_mul)
);



endmodule

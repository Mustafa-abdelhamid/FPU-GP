module Top_MUL_tb();

reg    [7:0]        Ex_tb,Ey_tb;
reg    [22:0]       Mx_tb,My_tb;
reg                 Sx_tb,Sy_tb;
reg	   [1:0]        R_mode_tb ;

wire   [7:0]        Ez_tb;
wire   [22:0]       Mz_tb;
wire                Sz_tb;
wire                invalid_flag_tb,overflow_flag_tb,underflow_flag_tb,inexact_flag_tb,zero_flag_tb;


initial 
  begin
    $dumpfile("Top_MUL.vcd") ;
    $dumpvars ;
	
	test_Mul(0,23'b010_00000_00000_00000_00000,8'b1001,0,23'b011_00000_00000_00000_00000,8'b1011,2'b01);
	
	
	
    $finish ;
    
  end



task test_Mul ;

input				sx;
input	[22:0]		mx;
input	[7:0]		ex;
input				sy;
input	[22:0]		my;
input	[7:0]		ey;
input	[1:0]		round_mode;
	
	begin
	Sx_tb = sx;	
	Mx_tb = mx;
	Ex_tb = ex;
	Sy_tb = sy;	
	My_tb = my;
	Ey_tb = ey;
	R_mode_tb=round_mode;
	end
	
endtask	


Top_MUL DUT(
.Ex(Ex_tb),
.Ey(Ey_tb),
.Mx(Mx_tb),
.My(My_tb),
.Sx(Sx_tb),
.Sy(Sy_tb),
.R_mode(R_mode_tb),
.Ez(Ez_tb),
.Mz(Mz_tb),
.Sz(Sz_tb),
.invalid_flag(invalid_flag_tb),
.overflow_flag(overflow_flag_tb),
.underflow_flag(underflow_flag_tb),
.inexact_flag(inexact_flag_tb),
.zero_flag(zero_flag_tb)
);


endmodule
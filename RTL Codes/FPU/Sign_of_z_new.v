module Sign_of_z_new (
input wire  Sx,Sy,EOP,cmp,zero_d,sign_d,
output wire  Sz
);
//internal signals
wire Sz_0 , Sz_1 , Sz_2 , Sz_3;
//instances
mux_2_in_1_out mux_2_in_1_out_inst_1 (Sz_1 , Sz_0 , zero_d , Sz);
mux_2_in_1_out mux_2_in_1_out_inst_2 (Sx , Sz_2 , EOP , Sz_0);
mux_2_in_1_out mux_2_in_1_out_inst_3 (Sx , ~Sx , cmp , Sz_2);
mux_2_in_1_out mux_2_in_1_out_inst_4 (Sx , Sz_3 , sign_d , Sz_1);
mux_2_in_1_out mux_2_in_1_out_inst_5 (Sx , ~Sx , EOP , Sz_3);
endmodule
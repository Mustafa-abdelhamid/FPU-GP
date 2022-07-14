module mux_4_in_2_out (in0 , in1 , in2 , in3 , sel , out0 , out1);
input [24:0]in0,in1,in2,in3;//{ovf_rnd , Mout}
input [1:0]sel;
output reg [23:0]out0;//Mout
output reg out1;//ovf_rnd
always@(*)
begin
    case(sel)
        2'b00: 
            begin
                out0 = in0[23:0];
                out1 = in0[24];
            end
        2'b01:
            begin 
                out0 = in1[23:0];
                out1 = in1[24];
            end
        2'b10:
            begin 
                out0 = in2[23:0];
                out1 = in2[24];
            end
        2'b11:
            begin
                out0 = in3[23:0];
                out1 = in2[24];
            end
    endcase    
end
endmodule
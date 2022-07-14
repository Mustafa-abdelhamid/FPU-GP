module mux_8_in_2_out (in0 , in1 , in2 , in3 , in4 , in5 , in6 , in7 , sel , out0 , out1);
input [24:0]in0 , in1 , in2 , in3 , in4 , in5 , in6 , in7; //{ovf_rnd , Mout}
input [2:0]sel;
output reg [23:0]out0;//Mout
output reg out1;//ovf_rnd
always@(*)
begin
    case(sel)
        3'b000:
            begin
                out0 = in0[23:0];
                out1 = in0[24];
            end
        3'b001:
            begin
                out0 = in1[23:0];
                out1 = in1[24];
            end
        3'b010:
            begin
                out0 = in2[23:0];
                out1 = in2[24];
            end
        3'b011:
            begin
                out0 = in3[23:0];
                out1 = in3[24];
            end
        3'b100:
            begin
                out0 = in4[23:0];
                out1 = in4[24];
            end
        3'b101:
            begin
                out0 = in5[23:0];
                out1 = in5[24];
            end
        3'b110:
            begin
                out0 = in6[23:0];
                out1 = in6[24];
            end
        3'b111:
            begin
                out0 = in7[23:0];
                out1 = in7[24];
            end
    endcase
end
endmodule
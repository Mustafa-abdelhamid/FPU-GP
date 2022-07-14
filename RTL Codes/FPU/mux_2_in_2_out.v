module mux_2_in_2_out (in0 , in1 , sel , out0 , out1);
input [1:0]in0 , in1;//{x , y}
input sel;
output reg out0 , out1;
always@(*)
begin
    if(sel == 0)
        begin
            out0 = in0[0];
            out1 = in0[1];
        end
    else
        begin
            out0 = in1[0];
            out1 = in1[1];
        end
end
endmodule
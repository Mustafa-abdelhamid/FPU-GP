module mux_2_in_1_out (in0 , in1 , sel , out);
input in0 , in1 , sel;
output reg out;
always@(*)
begin
if(sel)
    begin
        out = in1;
    end
else
    begin
        out = in0;
    end
end    
endmodule
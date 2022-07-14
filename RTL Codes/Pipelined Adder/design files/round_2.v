module round_2 (Min , MOut);
input [26:0]Min;
output reg [23:0]MOut;
always@(*)
begin
    MOut = {1'b1 , Min[25:3]};
end
endmodule
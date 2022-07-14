module round_6 (Min , MOut);
input [26:0]Min;
output reg [23:0]MOut;
always@(*)
begin
    MOut = {Min[26] , Min[25:3]};
end
endmodule
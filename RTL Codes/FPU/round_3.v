module round_3 (Min , ovf_rnd , hidden , internal_mantessa);
input [26:0]Min;
output reg ovf_rnd; 
output reg hidden;
output reg [22:0]internal_mantessa;
always@(*)
begin
    {ovf_rnd,hidden,internal_mantessa}=Min[26:3] + 1'b1 ;
end
endmodule
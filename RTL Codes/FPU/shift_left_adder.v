    module shift_left_adder (SHL , second_shift_left , final_shift_left);
input [4:0]SHL;
input second_shift_left;
output reg [4:0]final_shift_left;
always@(*)
begin
    final_shift_left = SHL + second_shift_left;
end
endmodule
    

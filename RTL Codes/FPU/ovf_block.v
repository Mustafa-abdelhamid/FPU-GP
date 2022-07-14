    module ovf_block (carry_out , sub , ovf_out);
input carry_out , sub;
output reg ovf_out;
always@(*)
begin
    ovf_out = carry_out & ~sub;
end
endmodule
    

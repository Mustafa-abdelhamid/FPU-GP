module normalization (

input [25:0] MSB_multiplier_output ,  //(23+1)*2 bits --->  
//input [7:0] exponent ,
output reg [24:0] normalised_output , // hidden + 23 mantissa + sticky bit 
output reg [4:0] SHL ,
output reg ovf  
);



always@(*)

begin 
	if (!MSB_multiplier_output[25])  // already normalised or Leading zeros
		begin
		ovf = 1'b0 ;
		casez(MSB_multiplier_output[24:0]) //24 bit // synopsys full_case parallel_case
				25'b1???????????????????????? : // already normalised
					begin
						SHL = 0;
						normalised_output= MSB_multiplier_output[24:0] ; 
					end
				25'b01??????????????????????? : // leading zero 
					begin
						SHL = 1;
						normalised_output= {MSB_multiplier_output [23:0], 1'b0 } ; 
					end
				
				25'b001?????????????????????? : // leading zero 
					begin
						SHL = 2;
						normalised_output= {MSB_multiplier_output [22:0], 2'b 00 } ; 
					end
				
				25'b0001????????????????????? : // leading zero 
					begin
						SHL = 3;
						normalised_output= {MSB_multiplier_output [21:0], 3'b000 } ; 
					end
				
				25'b00001???????????????????? : // leading zero 
					begin
						SHL = 4;
						normalised_output= {MSB_multiplier_output [20:0], 4'b0000 } ; 
					end
					
				25'b000001??????????????????? : // leading zero
					begin
						SHL = 5;
						normalised_output= {MSB_multiplier_output [19:0], 5'b 00000} ; 
					end
				
				25'b0000001?????????????????? : // leading zero
					begin
						SHL = 6;
						normalised_output= {MSB_multiplier_output [18:0], 6'b 000000} ; 
					end
				25'b00000001????????????????? : // leading zero
					begin
						SHL = 7;
						normalised_output= {MSB_multiplier_output [17:0], 7'b 0000000} ; 
					end
				25'b000000001???????????????? : // leading zero
					begin
						SHL = 8;
						normalised_output= {MSB_multiplier_output [16:0], 8'b 00000000} ; 
					end
				25'b0000000001??????????????? : // leading zero
					begin
						SHL = 9;
						normalised_output= {MSB_multiplier_output [15:0], 9'b 0000_0000_0} ; 
					end
				25'b00000000001?????????????? : // leading zero
					begin
						SHL = 10;
						normalised_output= {MSB_multiplier_output [14:0], 10'b 0000_0000_00} ; 
					end
				25'b0000_0000_0001_????_????_????_? : // leading zero
					begin
						SHL = 11;
						normalised_output= {MSB_multiplier_output [13:0], 11'b 0000_0000_000} ; 
					end
				
				25'b0000_0000_0000_1???_????_????_? : // leading zero
					begin
						SHL = 12;
						normalised_output= {MSB_multiplier_output [12:0], 12'b 0000_0000_0000} ; 
					end
				
				25'b0000_0000_0000_01??_????_????_? : // leading zero
					begin
						SHL = 13;
						normalised_output= {MSB_multiplier_output [11:0], 13'b 0000_0000_0000_0} ; 
					end
				
				25'b0000_0000_0000_001?_????_????_? : // leading zero
					begin
						SHL = 14;
						normalised_output= {MSB_multiplier_output [10:0], 14'b 0000_0000_0000_00} ; 
					end
				
				25'b0000_0000_0000_0001_????_????_? : // leading zero
					begin
						SHL = 15;
						normalised_output= {MSB_multiplier_output [9:0], 15'b 0000_0000_0000_00} ; 
					end
				
				25'b0000_0000_0000_0000_1???_????_? : // leading zero
					begin
						SHL = 16;
						normalised_output= {MSB_multiplier_output [8:0], 16'b 0000_0000_0000_0000} ; 
					end
				
				25'b0000_0000_0000_0000_01??_????_? : // leading zero
					begin
						SHL = 17;
						normalised_output= {MSB_multiplier_output [7:0], 17'b 0000_0000_0000_0000_0} ; 
					end
				
				25'b0000_0000_0000_0000_001?_????_? : // leading zero
					begin
						SHL = 18;
						normalised_output= {MSB_multiplier_output [6:0], 18'b 0000_0000_0000_0000_00} ; 
					end
				
								
				25'b0000_0000_0000_0000_0001_????_? : // leading zero
					begin
						SHL = 19;
						normalised_output= {MSB_multiplier_output [5:0], 19'b 0000_0000_0000_0000_000} ; 
					end
								
				25'b0000_0000_0000_0000_0000_1???_? : // leading zero
					begin
						SHL = 20;
						normalised_output= {MSB_multiplier_output [4:0], 20'b 0000_0000_0000_0000_0000} ; 
					end
				
								
				25'b0000_0000_0000_0000_0000_01??_? : // leading zero
					begin
						SHL = 21;
						normalised_output= {MSB_multiplier_output [3:0], 21'b 0000_0000_0000_0000_0000_0} ; 
					end
								
				25'b0000_0000_0000_0000_0000_001?_? : // leading zero
					begin
						SHL = 22;
						normalised_output= {MSB_multiplier_output [2:0], 22'b 0000_0000_0000_0000_0000_00} ; 
					end
				
				25'b0000_0000_0000_0000_0000_0001_? : // leading zero
					begin
						SHL = 23;
						normalised_output= {MSB_multiplier_output [1:0], 23'b 0000_0000_0000_0000_0000_000} ; 
					end
				25'b0000_0000_0000_0000_0000_0000_1 : // leading zero
					begin
						SHL = 24;
						normalised_output= {MSB_multiplier_output [0], 24'b 0000_0000_0000_0000_0000_0000} ; 
					end
				
				endcase
		  
		end 
	else 
		begin
			SHL=0 ;
			ovf= 1'b1 ;
			normalised_output= MSB_multiplier_output [25:1] ; 
		end 
end 

endmodule
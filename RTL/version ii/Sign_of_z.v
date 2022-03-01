

module Sign_of_z(
    input wire  Sx,Sy,EOP,cmp,zero_d,sign_d,
    output reg  Sz
    );
	
	always @(*)
	begin
	if(zero_d==1)
		begin
			if (EOP==0)
				begin
				Sz=Sx;
				end
			else if (cmp==0) // EOP =1
				begin
				Sz=Sx;
				end
			else //  EOP =1 & cmp =1
				begin
				Sz=~Sx;
				end
		end
	else if (sign_d==0) // x > y 
		begin
			if (EOP==0)
				begin
				Sz=Sx;
				end
			else 
				begin
				Sz=Sx;
				end
		end
	else // sign_d = 1    Y > X
		begin
			if (EOP==0)
				begin
				Sz=Sx;
				end
			else 
				begin
				Sz=~Sx;
				end
		end
	end
	endmodule
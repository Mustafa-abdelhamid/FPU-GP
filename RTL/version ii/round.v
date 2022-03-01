module ROUND # (
parameter	Significant_WD = 23 ,
			roundmodeReg_WD=2   
)
////////////////////////////////////////////////////////////
//////////// Input and output port decleration /////////////
////////////////////////////////////////////////////////////
(
input	wire 	[Significant_WD+3:0] Min   ,  //operands significand in + 3 guard bits
				[roundmodeReg_WD-1:0] roundMode,
		
input		Sign_in ,
output	reg		[Significant_WD-1:0] MOut  ,
output	reg				overFlow,inexact_flag 
) ;
parameter	toNearest	= 2'b 00 ,
			toZero 		= 2'b 01 ,
			toPinf		= 2'b 10 , //to plus inf
			toMinf		= 2'b 11 ; //to minus inf	

////////////////////////////////////////////////////////////
//////////////////////Internal signals//////////////////////
////////////////////////////////////////////////////////////
wire [2:0] guard_bits ;
reg hidden ;
assign guard_bits=Min[2:0] ; 
////////////////////////////////////////////////////////////
////////////////////////  behaviour ////////////////////////
////////////////////////////////////////////////////////////
always@ (*)
	begin
		inexact_flag = | guard_bits ; 
		overFlow= 1'b0 ;
		case (roundMode)
		
		toNearest:
			begin
				case(guard_bits)
				3'b 000 :
					begin
						MOut=Min[Significant_WD+2:3] ;
					end
				3'b 001 :
					begin
						MOut=Min[Significant_WD+2:3] ;
						
					end
				3'b 010 :
					begin
						MOut=Min[Significant_WD+2:3] ;
					end
				3'b 011 :
					begin
						MOut=Min[Significant_WD+2:3] ;
					end
				3'b 100 :
					begin
						if (Min[3])
							{overFlow,hidden,MOut}=Min[Significant_WD+3:3] + 1'b1 ;
						else 
							MOut=Min[Significant_WD+2:3] ;
					end
				3'b 101 :
					begin
						{overFlow,hidden,MOut}=Min[Significant_WD+3:3] + 1'b1 ;
					end
				3'b 110 :
					begin
						{overFlow,hidden,MOut}=Min[Significant_WD+3:3] + 1'b1 ;
					end
				3'b 111 :
					begin
						{overFlow,hidden,MOut}=Min[Significant_WD+3:3] + 1'b1 ;
					end
				endcase
			end
		toZero : 
			begin
				MOut=Min[Significant_WD+2:3] ;
			end
		
		toPinf:
			begin
				if (Sign_in)
					MOut=Min[Significant_WD+2:3] ;
				else
					begin
						
						case(guard_bits)
							3'b 000:
								begin
								 MOut=Min[Significant_WD+2:3] ;
								end
							default:
								begin
								{overFlow,hidden,MOut}=Min[Significant_WD+3:3] + 1'b1 ;
								end
						endcase
					end
			end
		toMinf:
			begin
				if (Sign_in==1'b0)
					begin
						MOut=Min[Significant_WD+2:3] ;
					end
				else
					begin
						
						case(guard_bits)
							3'b 000:
								begin
								 MOut=Min[Significant_WD+2:3] ;
								end
							default:
								begin
								{overFlow,hidden,MOut}=Min[Significant_WD+3:3] + 1'b1 ;
								end
						endcase
					end
				
			end
			
		endcase
	end

endmodule

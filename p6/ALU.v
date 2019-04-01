`timescale 1ns / 1ns
module ALU(
input [31:0]op1,
input [31:0]op2,
input [3:0]sel,
output [31:0]result
//output zero
);
    reg [31:0]res;
	 always @(*) begin
	     case(sel)
		      0:res={31'b0,~op1[31]};//>=0
				1:res={31'b0,op1[31]};//<0
				2:res=op1+op2;
				3:res=op1-op2;
				4:res=op1&op2;
				5:res=op1|op2;
				6:res=op1^op2;
				7:res=~(op1|op2);
				8:res=op2>>(op1[4:0]);
				9:res=($signed(op2))>>>(op1[4:0]);
				10:res=op2<<(op1[4:0]);
				11:res={31'b0,(op1==op2)};
				12:res={31'b0,($signed(op1))<($signed(op2))};
				13:res={31'b0,op1<op2};
				14:res={31'b0,op1!=0&&(~op1[31])};//>0
				15:res={31'b0,op1==0||op1[31]};//<=0
		  endcase
	 end
	 assign result=res;
	 //assign zero=(res==0);
endmodule

`timescale 1ns / 1ns
module muldiv(
input clk,
input loen,
input hien,
input reset,
input mdsel,
input isunsigned,
input add,
input [31:0]op1,
input [31:0]op2,
output reg busy,
output reg [31:0]lo=0,
output reg [31:0]hi=0
);
	 reg [3:0]count;
	 reg [63:0]temp;
	 reg a;
	 initial begin
	     temp=0;count=0;busy=0;
	 end
	 always @(posedge clk) begin
	     if(reset) begin
		      temp=0;hi=0;lo=0;busy=0;count=0;
		  end
		  else if(count!=0) begin
		      count=count-1;
				if(count==0) begin
				    busy=0;
					 if(a) {hi,lo}={hi,lo}+temp;
					 else {hi,lo}=temp;
				end
		  end
		  else if(~busy&&(loen||hien)) begin
				if(loen&&hien) begin
					 busy=1;a=add;
					 if(mdsel) count=10;
					 else count=5;
				    case({mdsel,isunsigned})
				    0:temp=$signed(op1)*$signed(op2);
					 1:temp=op1*op2;
					 2:temp={$signed(op1)%$signed(op2),$signed(op1)/$signed(op2)};
					 3:temp={op1%op2,op1/op2};
					 endcase
				end
				else if(loen) lo=op1;
				else hi=op1;
		  end
	 end
endmodule

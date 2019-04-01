`timescale 1ns / 1ns
module compare(
input [31:0]c1,
input [31:0]c2,
input [2:0]sel,
output reg true
);
    always @(*) begin
	     case(sel)
		      0:true=c1==c2;
				1:true=c1!=c2;
				2:true=c1==0||c1[31];
				3:true=c1!=0&&~c1[31];
				4:true=c1[31];
				5:true=~c1[31];
		  endcase
	 end
endmodule

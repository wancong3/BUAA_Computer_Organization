`timescale 1ns / 1ns
module GRF(
input clk,
input WEnable,
input reset,
input [4:0]RAddr1,
input [4:0]RAddr2,
input [4:0]WAddr,
input [31:0]WData,
input [31:0]IAddr,
output [31:0]RData1,
output [31:0]RData2
);
    reg [31:0]regs [0:31];
	 integer i;
    initial begin
	     for(i=0;i<=31;i=i+1) regs[i]=0;
		  //regs[28]=32'h00001800;
		  //regs[29]=32'h00002ffc;
	 end
	 always @(posedge clk) begin
	     if(reset) begin
		      for(i=0;i<=31;i=i+1) regs[i]<=0;
				//regs[28]=32'h00001800;
				//regs[29]=32'h00002ffc;
		  end
		  else if(WEnable&&WAddr>0) begin
		      regs[WAddr]<=WData;
//				$display("@%h: $%d <= %h", IAddr, WAddr,WData);
				$display("%d@%h: $%d <= %h", $time,IAddr, WAddr,WData);
		  end
	 end
	 assign RData1=regs[RAddr1];
	 assign RData2=regs[RAddr2];
endmodule

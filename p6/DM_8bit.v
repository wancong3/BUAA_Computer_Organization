`timescale 1ns / 1ns

module DM_8bit(
input clk,
input WE,
input reset,
input isu,
input [1:0]MemDst,
input [13:0]Addr,
input [31:0]WData,
input [31:0]IAddr,
output [31:0]RData
);
    reg [7:0]ram[0:16383];
	 wire [31:0]out1;
	 wire [31:0]out2;
	 integer i;
	 initial begin
	     for(i=0;i<16384;i=i+4) {ram[i+3],ram[i+2],ram[i+1],ram[i]}=0;
	 end
	 always @(posedge clk) begin
	     if(reset) for(i=0;i<16384;i=i+4) {ram[i+3],ram[i+2],ram[i+1],ram[i]}=0;
		  else if(WE) begin
		      i={18'b0,Addr[13:2],2'b0};
				case(MemDst)
					 0:begin
					     ram[Addr]=WData[7:0];//sb
						  $display("%d@%h: *%h <= %h",$time,IAddr, i,{ram[i+3],ram[i+2],ram[i+1],ram[i]});
					 end
					 1:begin
					     {ram[{Addr[13:1],1'b1}],ram[{Addr[13:1],1'b0}]}=WData[15:0];//sh
						  $display("%d@%h: *%h <= %h",$time,IAddr, i,{ram[i+3],ram[i+2],ram[i+1],ram[i]});
					 end
					 3:begin
					     {ram[i+3],ram[i+2],ram[i+1],ram[i]}=WData;//sw
						  $display("%d@%h: *%h <= %h",$time,IAddr, i,WData);
					 end
				endcase
		  end
	 end
	 ext extend1({ram[Addr+1],ram[Addr]},{1'b0,isu},out1);//lb,lbu
	 extbyte extend2(ram[Addr],isu,out2);//lh,lhu
	 assign RData=(MemDst==3)?{ram[Addr+3],ram[Addr+2],ram[Addr+1],ram[Addr]}:(MemDst[0]?out1:out2);
endmodule

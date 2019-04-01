`timescale 1ns / 1ns
module Instr_Memory(
input [11:0]RAddr,
output [31:0]RData
);
    reg [31:0] rom[0:4095];
	 integer i;
	 initial begin
	     for(i=0;i<4096;i=i+1) rom[i]=0;
		  $readmemh("code.txt",rom);
	 end
	 assign RData=rom[RAddr];
endmodule

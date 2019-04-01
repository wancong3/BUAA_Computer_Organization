`timescale 1ns / 1ns
module Instr_Memory(
input [9:0]RAddr,
output [31:0]RData
);
    reg [31:0] rom[0:1023];
	 integer i;
	 initial begin
	     for(i=0;i<1024;i=i+1) rom[i]=0;
		  $readmemh("code.txt",rom);
	 end
	 assign RData=rom[RAddr];
endmodule

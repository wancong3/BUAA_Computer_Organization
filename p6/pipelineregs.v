`timescale 1ns / 1ns
module preg1(
input clk,
input en,
input reset,
input in,
output reg out=0
);
    always @(posedge clk) begin
	     if(reset) out=0;
		  else if(en) out=in;
	 end
endmodule

module preg5(
input clk,
input en,
input reset,
input [4:0]in,
output reg [4:0]out=0
);
    always @(posedge clk) begin
	     if(reset) out=0;
		  else if(en) out=in;
	 end
endmodule

module preg32(
input clk,
input en,
input reset,
input [31:0]in,
output reg [31:0]out=0
);
    always @(posedge clk) begin
	     if(reset) out=0;
		  else if(en) out=in;
	 end
endmodule

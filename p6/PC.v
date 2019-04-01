`timescale 1ns / 1ns
module PC(
input clk,
input en,
input reset,
input [31:0]next,
output reg [31:0]IAddr=32'h00003000
);
    always @(posedge clk) begin
	     if(reset) IAddr<=32'h00003000;
		  else if(en) IAddr<=next;
	 end
endmodule

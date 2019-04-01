`timescale 1ns / 1ns
module ext(
input [15:0]imm,
input [1:0]EOp,
output [31:0]ext
);
    reg [31:0]out;
	 always @(*) begin
	     case(EOp)
		      0:out={{16{imm[15]}},imm};
				1:out={16'h0000,imm};
				2:out={imm,16'h0000};
				3:out={{14{imm[15]}},imm,2'b00};
		  endcase
	 end
	 assign ext=out;
endmodule

module extbyte(
input [7:0]imm,
input EOp,
output [31:0]ext
);
	 assign ext=EOp?{24'b0,imm}:{{24{imm[7]}},imm};
endmodule

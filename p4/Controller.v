`timescale 1ns / 1ns
`define bits 13
module Controller(
input [31:0]cmd,
output Jump,
output [1:0]RegSrc,
output MemWrite,
output Branch,
output [1:0]ALUSrc,
output [1:0]RegDst,
output RegWrite,
output [1:0]ExtOp,
output [3:0]ALUCtrl
);
    //{ext,RegWrite,[1:0]RegDst,[1:0]ALUSrc,Branch,MemWrite,[1:0]RegSrc,Jump,[3:0]ALUCtrl,hilo,}
	 reg [15:0]temp;
	 always @(cmd) begin
	     if(cmd==0) temp=0;//nop
	     else case(cmd[31:26])
		      0:case(cmd[5:0])
				    0:temp=16'b00_1_01_10_00_00_0_1010;//sll
					 2:temp=16'b00_1_01_10_00_00_0_1000;//srl
					 3:temp=16'b00_1_01_10_00_00_0_1001;//sra
					 4:temp=16'b00_1_01_00_00_00_0_1010;//sllv
					 6:temp=16'b00_1_01_00_00_00_0_1000;//srlv
					 7:temp=16'b00_1_01_00_00_00_0_1001;//srav
					 8:temp=16'b00_0_00_00_00_00_1_0000;//jr
					 9:temp=16'b00_1_01_00_00_10_1_0000;//jalr
					 //16://mfhi
					 //17://mthi
					 //18://mflo
					 //19://mtlo
					 //24://mult
					 //25://multu
					 //26://div
					 //27://divu
					 32:temp=16'b00_1_01_00_00_00_0_0010;//add
					 33:temp=16'b00_1_01_00_00_00_0_0010;//addu
					 34:temp=16'b00_1_01_00_00_00_0_0011;//sub
					 35:temp=16'b00_1_01_00_00_00_0_0011;//subu
					 36:temp=16'b00_1_01_00_00_00_0_0100;//and
					 37:temp=16'b00_1_01_00_00_00_0_0101;//or
					 38:temp=16'b00_1_01_00_00_00_0_0110;//xor
					 39:temp=16'b00_1_01_00_00_00_0_0111;//nor
					 42:temp=16'b00_1_01_00_00_00_0_1100;//slt
					 43:temp=16'b00_1_01_00_00_00_0_1101;//sltu
				endcase
				1:case(cmd[20:16])
				    0:temp=16'b11_0_00_00_10_00_0_0000;//bltz
					1:temp=16'b11_0_00_00_10_00_0_0001;//bgez
					17:temp=16'b11_1_10_00_10_10_0_0001;//bgezal
				endcase
				//{[1:0]ext,RegWrite,[1:0]RegDst,[1:0]ALUSrc,Branch,MemWrite,[1:0]RegSrc,Jump,[3:0]ALUCtrl}
				2:temp=16'b00_0_00_01_00_00_1_0000;//j
				3:temp=16'b00_1_10_01_00_10_1_0000;//jal
				4:temp=16'b11_0_00_00_10_00_0_0110;//beq
				5:temp=16'b11_0_00_00_10_00_0_1011;//bne
				6:temp=16'b11_0_00_00_10_00_0_1110;//blez
				7:temp=16'b11_0_00_00_10_00_0_1111;//bgtz
				8:temp=16'b00_1_00_01_00_00_0_0010;//addi
				9:temp=16'b00_1_00_01_00_00_0_0010;//addiu
				10:temp=16'b00_1_00_01_00_00_0_1100;//slti//
				11:temp=16'b00_1_00_01_00_00_0_1101;//sltiu
				12:temp=16'b01_1_00_01_00_00_0_0100;//andi
				13:temp=16'b01_1_00_01_00_00_0_0101;//ori
				14:temp=16'b01_1_00_01_00_00_0_0110;//xori
				15:temp=16'b10_1_00_01_00_00_0_0101;//lui
				//16:
				32:temp=16'b00_1_00_01_00_01_0_0010;//lb
				33:temp=16'b00_1_00_01_00_01_0_0010;//lh
				35:temp=16'b00_1_00_01_00_01_0_0010;//lw
				36:temp=16'b00_1_00_01_00_01_0_0010;//lbu
				37:temp=16'b00_1_00_01_00_01_0_0010;//lhu
				40:temp=16'b00_0_00_01_01_00_0_0010;//sb
				41:temp=16'b00_0_00_01_01_00_0_0010;//sh
				43:temp=16'b00_0_00_01_01_00_0_0010;//sw
		  endcase
	 end
	 assign {ExtOp,RegWrite,RegDst,ALUSrc,Branch,MemWrite,RegSrc,Jump,ALUCtrl}=temp;
endmodule

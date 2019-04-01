`timescale 1ns / 1ns

module Controller(
input [31:0]cmd,
output Jump,
output [2:0]RegSrc,
output MemWrite,
output Branch,
output [1:0]ALUSrc,
output [1:0]RegDst,
output RegWrite,
output [1:0]ExtOp,
output [3:0]ALUCtrl,
output loen,
output hien
);
    //{ext,RegWrite,[1:0]RegDst,[1:0]ALUSrc,Branch,MemWrite,[2:0]RegSrc,Jump,[3:0]ALUCtrl,hilo,}
	 reg [18:0]temp;
	 always @(cmd) begin
	     if(cmd==0) temp=0;//nop
	     else case(cmd[31:26])
		      0:case(cmd[5:0])
				    0:temp='b00_1_01_10_00_000_0_1010_00;//sll
					 2:temp='b00_1_01_10_00_000_0_1000_00;//srl
					 3:temp='b00_1_01_10_00_000_0_1001_00;//sra
					 4:temp='b00_1_01_00_00_000_0_1010_00;//sllv
					 6:temp='b00_1_01_00_00_000_0_1000_00;//srlv
					 7:temp='b00_1_01_00_00_000_0_1001_00;//srav
					 8:temp='b00_0_00_00_00_000_1_0000_00;//jr
					 9:temp='b00_1_01_00_00_010_1_0000_00;//jalr
					 /*16:temp='b00_1_01_00_00_100_0_0000_00;//mfhi 010000 mdsel=Intsr[1]
					 17:temp='b00_0_00_00_00_000_0_0000_01;//mthi 010001 isunsigned=Instr[0]
					 18:temp='b00_1_01_00_00_011_0_0000_00;//mflo 010010
					 19:temp='b00_0_00_00_00_000_0_0000_10;//mtlo 010011
					 24:temp='b00_0_01_00_00_000_0_0000_11;//mult 011000
					 25:temp='b00_0_01_00_00_000_0_0000_11;//multu 011001
					 26:temp='b00_0_01_00_00_000_0_0000_11;//div  011010
					 27:temp='b00_0_01_00_00_000_0_0000_11;//divu 011011*/
					 32:temp='b00_1_01_00_00_000_0_0010_00;//add
					 33:temp='b00_1_01_00_00_000_0_0010_00;//addu
					 34:temp='b00_1_01_00_00_000_0_0011_00;//sub
					 35:temp='b00_1_01_00_00_000_0_0011_00;//subu
					 36:temp='b00_1_01_00_00_000_0_0100_00;//and
					 37:temp='b00_1_01_00_00_000_0_0101_00;//or
					 38:temp='b00_1_01_00_00_000_0_0110_00;//xor
					 39:temp='b00_1_01_00_00_000_0_0111_00;//nor
					 42:temp='b00_1_01_00_00_000_0_1100_00;//slt
					 43:temp='b00_1_01_00_00_000_0_1101_00;//sltu
				endcase
				1:case(cmd[20:16])
				    0:temp='b11_0_00_00_10_000_0_0100_00;//bltz
					1:temp='b11_0_00_00_10_000_0_0101_00;//bgez
					17:temp='b11_1_10_00_10_010_0_0101_00;//bgezal
				endcase
				//{[1:0]ext,RegWrite,[1:0]RegDst,[1:0]ALUSrc,Branch,MemWrite,[2:0]RegSrc,Jump,[3:0]ALUCtrl}
				2:temp='b00_0_00_01_00_000_1_0000_00;//j
				3:temp='b00_1_10_01_00_010_1_0000_00;//jal
				4:temp='b11_0_01_00_10_000_0_0000_00;//beq
				5:temp='b11_0_01_00_10_000_0_0001_00;//bne
				6:temp='b11_0_00_00_10_000_0_0010_00;//blez
				7:temp='b11_0_00_00_10_000_0_0011_00;//bgtz
				8:temp='b00_1_00_01_00_000_0_0010_00;//addi
				9:temp='b00_1_00_01_00_000_0_0010_00;//addiu
				10:temp='b00_1_00_01_00_000_0_1100_00;//slti//
				11:temp='b00_1_00_01_00_000_0_1101_00;//sltiu
				12:temp='b01_1_00_01_00_000_0_0100_00;//andi
				13:temp='b01_1_00_01_00_000_0_0101_00;//ori
				14:temp='b01_1_00_01_00_000_0_0110_00;//xori
				15:temp='b10_1_00_01_00_000_0_0101_00;//lui
				//16:
				//28:temp='b00_0_01_00_00_000_0_0000_11;//madd(u) attention:MUL Instr[1] stall()
				32:temp='b00_1_00_01_00_001_0_0010_00;//lb
				33:temp='b00_1_00_01_00_001_0_0010_00;//lh
				34:temp='b00_1_00_01_00_001_0_0010_00;//lwl
				35:temp='b00_1_00_01_00_001_0_0010_00;//lw
				36:temp='b00_1_00_01_00_001_0_0010_00;//lbu
				37:temp='b00_1_00_01_00_001_0_0010_00;//lhu
				38:temp='b00_1_00_01_00_001_0_0010_00;//lwr
				40:temp='b00_0_00_01_01_000_0_0010_00;//sb
				41:temp='b00_0_00_01_01_000_0_0010_00;//sh
				42:temp='b00_0_00_01_01_000_0_0010_00;//swl
				43:temp='b00_0_00_01_01_000_0_0010_00;//sw
				46:temp='b00_0_00_01_01_000_0_0010_00;//swr
		  endcase
	 end
	 assign {ExtOp,RegWrite,RegDst,ALUSrc,Branch,MemWrite,RegSrc,Jump,ALUCtrl,loen,hien}=temp;
endmodule

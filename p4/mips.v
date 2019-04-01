`timescale 1ns / 1ns
module mips(
input clk,
input reset
);
    parameter condition=1'b1;
	 
    wire [31:0]IAddr;
	 wire [31:0]next;
	 wire [31:0]Instr;
	 wire Jump,MemWrite,Branch,RegWrite,zero;
	 wire [1:0]RegSrc;
	 wire [1:0]RegDst;
	 wire [1:0]ALUSrc;
	 wire [1:0]ExtOp;
	 wire [3:0]ALUCtrl;
	 wire [31:0]SrcA;
	 wire [31:0]SrcB;
	 wire [31:0]RData1;
	 wire [31:0]RData2;
	 wire [31:0]WData;
	 wire [31:0]RData;
	 wire [4:0]RegWAddr;
	 wire [31:0]ALUResult;
	 wire [31:0]Imm;
	 wire [31:0]temp;
	 
	 /*initial begin
	     
	 end*/
	 assign temp=IAddr+4;
	 assign next=Jump?(ALUSrc[0]?{temp[31:28],Instr[25:0],2'b00}:RData1):((Branch&&zero)?temp+Imm:temp);
	 assign RegWAddr=RegDst[1]?5'd31:(RegDst[0]?Instr[15:11]:Instr[20:16]);
	 assign SrcA=ALUSrc[1]?{27'b0,Instr[10:6]}:RData1;
	 assign SrcB=ALUSrc[0]?Imm:RData2;
	 assign WData=RegSrc[1]?temp:(RegSrc[0]?RData:ALUResult);
	 
	 PC pcount(clk,reset,next,IAddr);
	 Instr_Memory im(IAddr[11:2],Instr);
	 Controller ctrl(Instr,Jump,RegSrc,MemWrite,Branch,ALUSrc,RegDst,RegWrite,ExtOp,ALUCtrl);
	 GRF rf(clk,Branch&&condition?(RegWrite&&zero):RegWrite,reset,Instr[25:21],Instr[20:16],RegWAddr,WData,IAddr,RData1,RData2);
	 ALU a(SrcA,SrcB,ALUCtrl,ALUResult,zero);
	 ext extender(Instr[15:0],ExtOp,Imm);
	 //Data_Memory dm(clk,MemWrite,reset,ALUResult[11:2],RData2,IAddr,RData);
	 DM_8bit dm(clk,MemWrite,reset,Instr[28],Instr[27:26],ALUResult[11:0],RData2,IAddr,RData);
endmodule

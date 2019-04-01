`timescale 1ns / 1ns

module conflict(
//stall
input [4:0]WriteRegE,
input [4:0]WriteRegM,
input RegWriteE,
input RegWriteM,
input [2:0]RegSrcE,
input [2:0]RegSrcM,
input BranchD,
input JumpD,
input JumpE,
input [1:0]RegDstD,
input [4:0]rsD,
input [4:0]rtD,

//forward
input [4:0]rsE,
input [4:0]rtE,
input [4:0]WriteRegW,
input RegWriteW,
input [4:0]rtM,

input mdbusy,
input usehilo,

//stall out
output stall,

//forward out
output [1:0]ForwardrsD,
output [1:0]ForwardrtD,
output [1:0]ForwardrsE,
output [1:0]ForwardrtE,
output ForwardrtM
);
    //stall
	 wire branchstall,jumpstall,loadstall,muldivstall;
	 assign branchstall=BranchD && 
	                   ((WriteRegE!=0 && RegWriteE && ~JumpE && (rsD==WriteRegE ||rtD==WriteRegE))||
							 (WriteRegM!=0 && RegSrcM==1 &&(rsD==WriteRegM ||rtD==WriteRegM)));
	 assign jumpstall=JumpD && 
	                   (WriteRegE!=0 && (RegWriteE && ~JumpE && rsD==WriteRegE)||
							 (WriteRegM!=0 && RegSrcM==1 && rsD==WriteRegM));
	 assign loadstall=RegSrcE==1 && WriteRegE!=0 && ((RegDstD!=0 && rtD==WriteRegE)|| rsD==WriteRegE);
	 assign muldivstall=mdbusy && usehilo; 
	 assign stall=branchstall || jumpstall || loadstall ||muldivstall;
	 
	 //forward
	 assign ForwardrsD=WriteRegE!=0 && RegWriteE && WriteRegE==rsD? 3 :
	                   WriteRegM!=0 && RegWriteM && WriteRegM==rsD? 2 :
	                   WriteRegW!=0 && RegWriteW && WriteRegW==rsD? 1 : 0;
	 assign ForwardrtD=WriteRegE!=0 && RegWriteE && WriteRegE==rtD? 3 :
	                   WriteRegM!=0 && RegWriteM && WriteRegM==rtD? 2 :
	                   WriteRegW!=0 && RegWriteW && WriteRegW==rtD? 1 : 0;
	 
	 assign ForwardrsE=WriteRegM!=0 && RegWriteM && WriteRegM==rsE? 2 :
	                   WriteRegW!=0 && RegWriteW && WriteRegW==rsE? 1 : 0;
	 assign ForwardrtE=WriteRegM!=0 && RegWriteM && WriteRegM==rtE? 2 :
	                   WriteRegW!=0 && RegWriteW && WriteRegW==rtE? 1 : 0;
	 
	 assign ForwardrtM=WriteRegW!=0 && RegWriteW && WriteRegW==rtM;
	 
endmodule

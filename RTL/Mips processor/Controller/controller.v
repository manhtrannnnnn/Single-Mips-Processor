module controller(
  input [5:0] funct, 
  input [5:0] opcode,
  input zero,
  output [3:0] alucontrol,
  output pcsrc, regdst, 
  output memtoreg, alusrc,
  output regwrite, memwrite, jump
);
  wire branch;
  wire [1:0] aluop;

  assign pcsrc = branch & zero;

  control maindecoder(opcode, branch, regdst, memtoreg, alusrc, regwrite, jump, memwrite, aluop);

  ALU_control aludecoder(funct, opcode, aluop, alucontrol);


endmodule





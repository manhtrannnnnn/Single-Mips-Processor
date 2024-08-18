module mips(
  input clk, reset,
  output  [31:0] pc,
  input   [31:0] instr,
  output memwrite,
  output  [31:0] aluout, writedata,
  input   [31:0] readdata
);

  wire zero, pcsrc, regdst, memtoreg, alusrc, regwrite, jump;
  wire [3:0] alucontrol;

//controller
controller c(instr[5:0], instr[31:26], zero, alucontrol, pcsrc, regdst, memtoreg, alusrc, regwrite, memwrite, jump);

//datapath
datapath d(clk, reset, regdst, pcsrc, memtoreg, aluscr, regwrite, jump, alucontrol, instr, zero, pc, readdata, aluout, writedata);
endmodule
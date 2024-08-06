module pc(
  input clk, reset,
  input jump, pcsrc,
  input [25:0] instr, 
  output [31:0] pc
);

  wire [31:0] pcnextbranch;
  wire [31:0] pcnext, pcadder, pcbranch, pcjump;


  // PC logic
  pc_ff p(clk, reset, pcnext, pc);
  adder4 #(32) pcadder4(pc, 32'b100, pcadder);
  branch_funct #(32) branchfunct(instr[15:0], pcadder, pcbranch);
  mux2to1 #(32) pcbranchmux(pcadder, pcbranch, pcsrc, pcnextbranch);
  jump_funct #(32) jumpfunct(instr[25:0], pcadder, pcjump);
  mux2to1 #(32) pcjumpmux(pcnextbranch, pcjump, jump, pcnext);

endmodule
module datapath (
    input clk, reset,
    input regdst, pcsrc,
    input memtoreg, aluscr,
    input regwrite, jump,
    input [2:0] alucontrol,
    input [31:0] instr,
    output zero,
    output [31:0] pc,
    input [31:0] readdata,
    output[31:0] aluout, writedata
    );

    wire [31:0] srca, srcb;
    wire [5:0] REG_address_wb;
    wire [31:0] data_wb;
    wire [31:0] pcnextbranch;
    wire [31:0] pcnext, pcadder, pcbranch, pcjump;

    //PC logic
    pc_ff p(clk, reset, pcnext, pc);
    adder4 #(32) pcadder4(pc, 3'b100, pcadder);
    branch_funct #(32) branchfunct(instr[15:0], pcadder, pcbranch);
    mux2to1 #(32) pcbranchmux(pcbranch, pcadder, pcsrc, pcnextbranch);
    jump_funct #(32) jumpfunct(instr[25:0], pcadder, pcjump);
    mux2to1 #(32) pcjumpmux(pcjump, pcnextbranch, jump, pcnext);

    //ALU logic
    mux2to1 #(32) aluoperand2mux({{16{instr[15]}}, instr}, writedata, alusrc, srcb);
    ALU alu(alucontrol, srca, srcb, aluout, zero);

    //Register Logic
    mux2to1 #(5) regdstmux(instr[15:11], instr[20:16], regdst, REG_address_wb);
    mux2to1 #(32) datainmux(readdata, aluout, memtoreg, data_wb);
    REG register(clk, instr[25:21], instr[20:16], REG_address_wb, regwrite, data_wb, srca, writedata);

endmodule

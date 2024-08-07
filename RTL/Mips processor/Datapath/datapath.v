module datapath (
    input clk, reset,
    input regdst, pcsrc,
    input memtoreg, aluscr,
    input regwrite, jump,
    input   [3:0] alucontrol,
    input   [31:0] instr,
    output zero,
    output wire  [31:0] pc,
    input   [31:0] readdata,
    output wire  [31:0] aluout, 
    output  [31:0] writedata
    );  

    wire [31:0] srca, srcb;
    wire [4:0] REG_address_wb;
    wire [31:0] data_wb; 
    //pc logic
    pc pc_logic(clk, reset, jump, pcsrc, instr[25:0], pc);
    
    //ALU logic
    mux2to1 #(32) input2(writedata, {{16{instr[15]}}, instr[15:0]}, alusrc, srcb);
    ALU alu(alucontrol, srca, srcb, aluout, zero);
    
    //register
    mux2to1 #(5) wb(instr[20:16], instr[15:11], regdst, REG_address_wb);
    mux2to1 #(32) rd(aluout, readdata, memtoreg, data_wb);
    REG register(clk, reset, instr[25:21], instr[20:16], REG_address_wb, regwrite, data_wb, srca, writedata);

endmodule




module top(
  input clk, reset,
  output [31:0] pc,
  output [31:0] aluout, 
  output [31:0] writedata,
  output [31:0] readdata
  );
  
  wire [31:0] instr;
  wire memwrite;
  
  //Data Memory
  DMEM data_memory(clk, memwrite, aluout, writedata, readdata);
  
  //Instruction Memomry
  IMEM instruction_memory(pc, instr);
  
  //Mips processor
  mips mips_processor(clk, reset, pc, instr, memwrite, aluout, writedata, readdata);
endmodule

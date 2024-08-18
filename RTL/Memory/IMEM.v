module IMEM (
    input   [31:0]  pc,
    output wire [31:0] instr
);
  reg [31:0] instr_memory[31:0];
  
  initial begin
    $readmemh("D:/BACH KHOA/Verification/Testbench/top/testcase3.txt", instr_memory); //Use for verification
  end

  assign instr = instr_memory[pc[31:2]];
  
endmodule


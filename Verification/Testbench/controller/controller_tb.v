module controller_tb;

  // Inputs
  reg zero;
  reg [5:0] opcode;
  reg [5:0] funct;

  // Outputs
  wire memtoreg;
  wire memwrite;
  wire pcsrc;
  wire alusrc;
  wire regdst;
  wire regwrite;
  wire jump;
  wire [3:0] alucontrol;

  // Instantiate the Unit Under Test (UUT)
  controller dut(funct, opcode, zero, alucontrol, pcsrc, regdst, memtoreg, alusrc, regwrite, memwrite, jump);

  // Test sequence
  initial begin
    // Initialize Inputs
    zero = 0;
    opcode = 0;
    funct = 0;

    // Wait for global reset to finish
    #10;
    // Test R-type ADD
    opcode = 6'b000000;
    funct = 6'b100000;
    #10;
    $display("Time: %0t | R-type ADD (opcode=%b, funct=%b): memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, opcode, funct, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test R-type SUB
    opcode = 6'b000000;
    funct = 6'b100010;
    #10;
    $display("Time: %0t | R-type SUB (opcode=%b, funct=%b): memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, opcode, funct, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);
  
    // Test R-type AND
    opcode = 6'b000000;
    funct = 6'b100100;
    #10;
    $display("Time: %0t | R-type AND (opcode=%b, funct=%b): memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, opcode, funct, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);
             
    // Test R-type OR
    opcode = 6'b000000;
    funct = 6'b100101;
    #10;
    $display("Time: %0t | R-type OR (opcode=%b, funct=%b): memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, opcode, funct, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);
             
    // Test R-type SLT
    opcode = 6'b000000;
    funct = 6'b101010;
    #10;
    $display("Time: %0t | R-type SLT (opcode=%b, funct=%b): memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, opcode, funct, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test LW
    opcode = 6'b100011;
    funct = 6'b000000;
    #10;
    $display("Time: %0t | LW (opcode=%b): memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, opcode, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test SW
    opcode = 6'b101011;
    funct = 6'b000000;
    #10;
    $display("Time: %0t | SW (opcode=%b): memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, opcode, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test BEQ
    opcode = 6'b000100;
    funct = 6'b000000;
    zero = 1;
    #10;
    $display("Time: %0t | BEQ (opcode=%b, zero=1): memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, opcode, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    zero = 0;
    #10;
    $display("Time: %0t | BEQ (opcode=%b, zero=0): memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, opcode, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test ADDI
    opcode = 6'b001000;
    funct = 6'b000000;
    #10;
    $display("Time: %0t | ADDI (opcode=%b): memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, opcode, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test ORI
    opcode = 6'b001101;
    funct = 6'b000000;
    #10;
    $display("Time: %0t | ORI (opcode=%b): memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, opcode, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test SLTI
    opcode = 6'b001010;
    funct = 6'b000000;
    #10;
    $display("Time: %0t | SLTI (opcode=%b): memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, opcode, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test JUMP
    opcode = 6'b000010;
    funct = 6'b000000;
    #10;
    $display("Time: %0t | JUMP (opcode=%b): memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, opcode, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test default case
    opcode = 6'b111111;
    funct = 6'b000000;
    #10;
    $display("Time: %0t | default (opcode=%b): memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, opcode, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Finish the simulation
    $finish;
  end

endmodule


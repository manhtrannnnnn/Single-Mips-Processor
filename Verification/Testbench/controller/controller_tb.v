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
    $display("Time: %0t | R-type ADD: memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test R-type SUB
    opcode = 6'b000000;
    funct = 6'b100010;
    #10;
    $display("Time: %0t | R-type SUB: memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);
  
    // Test R-type AND
    opcode = 6'b000000;
    funct = 6'b100100;
    #10;
    $display("Time: %0t | R-type AND: memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);
             
    // Test R-type OR
    opcode = 6'b000000;
    funct = 6'b100101;
    #10;
    $display("Time: %0t | R-type OR: memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);
             
    // Test R-type slt
    opcode = 6'b000000;
    funct = 6'b101010;
    #10;
    $display("Time: %0t | R-type slt: memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);
             

    // Test lw
    opcode = 6'b100011;
    funct = 6'b000000;
    #10;
    $display("Time: %0t | lw: memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test sw
    opcode = 6'b101011;
    #10;
    $display("Time: %0t | sw: memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test beq
    opcode = 6'b000100;
    zero = 1;
    #10;
    $display("Time: %0t | beq (zero=1): memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    zero = 0;
    #10;
    $display("Time: %0t | beq (zero=0): memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test addi
    opcode = 6'b001000;
    #10;
    $display("Time: %0t | addi: memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test ori
    opcode = 6'b001101;
    #10;
    $display("Time: %0t | ori: memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test slti
    opcode = 6'b001010;
    #10;
    $display("Time: %0t | slti: memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test jump
    opcode = 6'b000010;
    #10;
    $display("Time: %0t | jump: memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Test default case
    opcode = 6'b111111;
    #10;
    $display("Time: %0t | default: memtoreg=%b, memwrite=%b, pcsrc=%b, alusrc=%b, regdst=%b, regwrite=%b, jump=%b, alucontrol=%b", 
             $time, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

    // Finish the simulation
    $finish;
  end

endmodule










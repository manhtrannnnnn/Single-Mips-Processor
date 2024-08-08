module mips_2_tb;

  // Inputs
  reg clk;
  reg reset;
  reg [31:0] instr;
  reg [31:0] readdata;
  // Outputs
  wire [31:0] pc;
  wire memwrite;
  wire [31:0] aluout;
  wire [31:0] writedata;

  // Instantiate the Unit Under Test (UUT)
  mips uut (
    .clk(clk),
    .reset(reset),
    .pc(pc),
    .instr(instr),
    .memwrite(memwrite),
    .aluout(aluout),
    .writedata(writedata),
    .readdata(readdata)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Test sequence
  initial begin
    // Initialize Inputs
    reset <= 0;
    instr <= 0;
    readdata <= 0;

    // Wait for global reset to finish
    #10;
    reset <= 1;
    
    // Test Case 1: BEQ (Branch if Equal) - Should branch
    instr = 32'b000100_00001_00010_0000000000000010; // BEQ R1, R2, offset 2
    #10;
    $display("BEQ (Equal) Instruction: pc = %h (Expected: pc + 8)", pc);

    // Test Case 2: BEQ (Branch if Equal) - Should not branch
    instr = 32'b000100_00001_00010_0000000000000010; // BEQ R1, R2, offset 2
    #10;
    $display("BEQ ( Equal) Instruction: pc = %h (Expected: pc + 8)", pc);

    // Test Case 3: J (Jump)
    instr = 32'b000010_00000000000000000000001000; // J to address 0x00000008
    #10;
    $display("J Instruction: pc = %h (Expected: 0x00000008)", pc);

    // Test Case 4: BEQ (Branch if Equal) - Should branch
    instr = 32'b000100_00011_00100_0000000000000010; // BEQ R3, R4, offset 2
    #10;
    $display("BEQ (Equal) Instruction: pc = %h (Expected: pc + 8)", pc);

    // Test Case 5: BEQ (Branch if Equal) - Should not branch
    instr = 32'b000100_00011_00100_0000000000000010; // BEQ R3, R4, offset 2
    #10;
    $display("BEQ ( Equal) Instruction: pc = %h (Expected: pc + 8)", pc);

    // Test Case 6: J (Jump)
    instr = 32'b000010_00000000000000000000010000; // J to address 0x00000010
    #10;
    $display("J Instruction: pc = %h (Expected: 0x00000010)", pc);

    // Test Case 7: BEQ (Branch if Equal) - Should branch
    instr = 32'b000100_00101_00110_0000000000000010; // BEQ R5, R6, offset 2
    #10;
    $display("BEQ (Equal) Instruction: pc = %h (Expected: pc + 8)", pc);

    // Test Case 8: BEQ (Branch if Equal) - Should not branch
    instr = 32'b000100_00101_00110_0000000000000010; // BEQ R5, R6, offset 2
    #10;
    $display("BEQ (Equal) Instruction: pc = %h (Expected: pc + 8)", pc);

    // Test Case 9: J (Jump)
    instr = 32'b000010_00000000000000000000011000; // J to address 0x00000018
    #10;
    $display("J Instruction: pc = %h (Expected: 0x00000018)", pc);

    // Test Case 10: BEQ (Branch if Equal) - Should branch

    instr = 32'b000100_00111_01000_0000000000000010; // BEQ R7, R8, offset 2
    #10;
    $display("BEQ (Equal) Instruction: pc = %h (Expected: pc + 8)", pc);

    // Finish simulation
    #10;
    $finish;
  end

endmodule

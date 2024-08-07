module mips_tb;

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
    reset = 1;
    instr = 0;
    readdata = 0;

    // Wait for global reset to finish
    #10;
    reset = 0;

    // Test case 1: ADDI instruction (I-type)
    instr = {6'b001000, 5'b00001, 5'b00010, 16'b0000000000000010}; // ADDI R2, R1, 2
    #10;
    $display("ADDI Instruction: aluout = %h (Expected: R1 + 2)", aluout);

    // Test case 2: ANDI instruction (I-type)
    instr = {6'b001100, 5'b00001, 5'b00010, 16'b0000000000000011}; // ANDI R2, R1, 3
    #10;
    $display("ANDI Instruction: aluout = %h (Expected: R1 & 3)", aluout);

    // Test case 3: ORI instruction (I-type)
    instr = {6'b001101, 5'b00001, 5'b00010, 16'b0000000000000100}; // ORI R2, R1, 4
    #10;
    $display("ORI Instruction: aluout = %h (Expected: R1 | 4)", aluout);

    // Test case 4: SLTI instruction (I-type)
    instr = {6'b001010, 5'b00001, 5'b00010, 16'b0000000000000101}; // SLTI R2, R1, 5
    #10;
    $display("SLTI Instruction: aluout = %h (Expected: (R1 < 5) ? 1 : 0)", aluout);

    // Test case 5: LW instruction (I-type)
    instr = {6'b100011, 5'b00001, 5'b00010, 16'b0000000000000110}; // LW R2, 6(R1)
    readdata = 32'h12345678;
    #10;
    $display("LW Instruction: aluout = %h, readdata = %h (Expected: readdata)", aluout, readdata);

    // Test case 6: SW instruction (I-type)
    instr = {6'b101011, 5'b00001, 5'b00010, 16'b0000000000000110}; // SW 6(R1), R2
    #10;
    $display("SW Instruction: writedata = %h (Expected: R2)", writedata);

    // Test case 7: BEQ instruction (I-type)
    instr = {6'b000100, 5'b00001, 5'b00010, 16'b0000000000000110}; // BEQ R1, R2, offset 6
    #10;
    $display("BEQ Instruction: pcsrc = %b (Expected: (R1 == R2) ? 1 : 0)", pcsrc);

    // Test case 8: ADD instruction (R-type)
    instr = {6'b000000, 5'b00001, 5'b00010, 5'b00011, 5'b00000, 6'b100000}; // ADD R3, R1, R2
    #10;
    $display("ADD Instruction: aluout = %h (Expected: R1 + R2)", aluout);

    // Test case 9: SUB instruction (R-type)
    instr = {6'b000000, 5'b00001, 5'b00010, 5'b00011, 5'b00000, 6'b100010}; // SUB R3, R1, R2
    #10;
    $display("SUB Instruction: aluout = %h (Expected: R1 - R2)", aluout);

    // Test case 10: AND instruction (R-type)
    instr = {6'b000000, 5'b00001, 5'b00010, 5'b00011, 5'b00000, 6'b100100}; // AND R3, R1, R2
    #10;
    $display("AND Instruction: aluout = %h (Expected: R1 & R2)", aluout);

    // Test case 11: OR instruction (R-type)
    instr = {6'b000000, 5'b00001, 5'b00010, 5'b00011, 5'b00000, 6'b100101}; // OR R3, R1, R2
    #10;
    $display("OR Instruction: aluout = %h (Expected: R1 | R2)", aluout);

    // Test case 12: SLT instruction (R-type)
    instr = {6'b000000, 5'b00001, 5'b00010, 5'b00011, 5'b00000, 6'b101010}; // SLT R3, R1, R2
    #10;
    $display("SLT Instruction: aluout = %h (Expected: (R1 < R2) ? 1 : 0)", aluout);

    // Test case 13: NOR instruction (R-type)
    instr = {6'b000000, 5'b00001, 5'b00010, 5'b00011, 5'b00000, 6'b100111}; // NOR R3, R1, R2
    #10;
    $display("NOR Instruction: aluout = %h (Expected: ~(R1 | R2))", aluout);

    // Test case 14: XOR instruction (R-type)
    instr = {6'b000000, 5'b00001, 5'b00010, 5'b00011, 5'b00000, 6'b100110}; // XOR R3, R1, R2
    #10;
    $display("XOR Instruction: aluout = %h (Expected: R1 ^ R2)", aluout);

    // Test case 15: Reset
    reset = 1;
    #10;
    $display("Reset: pc = %h (Expected: 0)", pc);
    reset = 0;

    // Finish the simulation
    $finish;
  end

endmodule

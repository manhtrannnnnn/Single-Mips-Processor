module mips_3_tb;
  reg clk;
  reg reset;
  reg [31:0] instr;
  wire [31:0] pc;
  wire memwrite;
  wire [31:0] aluout;
  wire [31:0] writedata;
  reg [31:0] readdata;

  // Instantiate the MIPS processor
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
  always #5 clk = ~clk;

  initial begin
    // Initialize inputs
    clk <= 0;
    reset <= 0;
    instr <= 0;
    readdata <= 0;

    // Apply reset
    #10;
    reset <= 1;

    // Test Case 1: ADDI (Immediate ADD)
    instr = 32'b001000_00000_00001_0000000000000101; // ADDI R1, R0, 5
    #10;
    $display("ADDI Instruction: R1 = %d (Expected: 5)", writedata);

    // Test Case 2: SUB (R-type)
    instr = 32'b000000_00001_00001_00010_00000_100010; // SUB R2, R1, R1
    #10;
    $display("SUB Instruction: R2 = %d (Expected: 0)", writedata);

    // Test Case 3: AND (R-type)
    instr = 32'b000000_00001_00001_00011_00000_100100; // AND R3, R1, R1
    #10;
    $display("AND Instruction: R3 = %d (Expected: 5)", writedata);

    // Test Case 4: OR (R-type)
    instr = 32'b000000_00001_00001_00100_00000_100101; // OR R4, R1, R1
    #10;
    $display("OR Instruction: R4 = %d (Expected: 5)", writedata);

    // Test Case 5: SLT (Set on Less Than, R-type)
    instr = 32'b000000_00001_00000_00101_00000_101010; // SLT R5, R1, R0
    #10;
    $display("SLT Instruction: R5 = %d (Expected: 0)", writedata);

    // Test Case 6: LW (Load Word, I-type)
    instr = 32'b100011_00000_00110_0000000000000000; // LW R6, 0(R0)
    readdata = 32'h00000010; // Simulate memory returning 16 for address 0
    #10;
    $display("LW Instruction: R6 = %h (Expected: 10)", writedata);

    // Test Case 7: SW (Store Word, I-type)
    instr = 32'b101011_00000_00110_0000000000000100; // SW R6, 4(R0)
    #10;
    $display("SW Instruction: Memory at 4 = %h (Expected: 10)", writedata);

    // Test Case 8: BEQ (Branch if Equal, I-type)
    instr = 32'b001000_00000_00111_0000000000000101; // ADDI R7, R0, 5
    #10;
    instr = 32'b001000_00000_01000_0000000000000101; // ADDI R8, R0, 5
    #10;
    instr = 32'b000100_00111_01000_0000000000000010; // BEQ R7, R8, offset 2
    #10;
    $display("BEQ Instruction: pc = %h (Expected: pc + 8)", pc);

    // Test Case 9: J (Jump)
    instr = 32'b000010_00000000000000000000001000; // J to address 0x00000008
    #10;
    $display("J Instruction: pc = %h (Expected: 0x00000008)", pc);

    // Test Case 10: Reset
    reset <= 0;
    #10;
    reset <= 1;
    #10;
    $display("Reset: pc = %h (Expected: 0)", pc);

    // Finish simulation
    #10;
    $finish;
  end

endmodule



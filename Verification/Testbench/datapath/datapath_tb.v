module datapath_tb;

  // Inputs
  reg clk;
  reg reset;
  reg regdst;
  reg pcsrc;
  reg memtoreg;
  reg alusrc;
  reg regwrite;
  reg jump;
  reg [3:0] alucontrol;
  reg [31:0] instr;
  reg [31:0] readdata;

  // Outputs
  wire zero;
  wire [31:0] pc;
  wire [31:0] aluout;
  wire [31:0] writedata;

  // Instantiate the Unit Under Test (UUT)
  datapath uut (
    .clk(clk),
    .reset(reset),
    .regdst(regdst),
    .pcsrc(pcsrc),
    .memtoreg(memtoreg),
    .alusrc(alusrc),
    .regwrite(regwrite),
    .jump(jump),
    .alucontrol(alucontrol),
    .instr(instr),
    .zero(zero),
    .pc(pc),
    .readdata(readdata),
    .aluout(aluout),
    .writedata(writedata)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initialize Inputs
    clk <= 0;
    reset <= 0;
    regdst <= 0;
    pcsrc <= 0;
    memtoreg <= 0;
    alusrc <= 0;
    regwrite <= 0;
    jump <= 0;
    alucontrol <= 4'b0000;
    instr <= 32'b0;
    readdata <= 32'b0;
  
    // Apply reset
    #10;
    reset = 1;
    // Test Case 1: Immediate instruction (ADDI)
    instr = {6'b001000, 5'b00001, 5'b00010, 16'b0000000000000010}; // ADDI R2, R1, 2
    regdst = 0;
    alusrc = 1;
    alucontrol = 4'b0010; // ALU control for ADD
    regwrite = 1;
    #10;
    $display("ADDI Instruction: aluout = %h (Expected: R1 + 2)", aluout);

    // Test Case 2: Immediate instruction (ADDI)
    instr = {6'b001000, 5'b00001, 5'b00011, 16'b0000000000000100}; // ADDI R3, R1, 4
    regdst = 0;
    alusrc = 1;
    alucontrol = 4'b0010; // ALU control for ADD
    regwrite = 1;
    #10;
    $display("ADDI Instruction: aluout = %h (Expected: R1 + 4)", aluout);

    // Test Case 3: Immediate instruction (ANDI)
    instr = {6'b001100, 5'b00001, 5'b00100, 16'b0000000000001111}; // ANDI R4, R1, 15
    regdst = 0;
    alusrc = 1;
    alucontrol = 4'b0000; // ALU control for AND
    regwrite = 1;
    #10;
    $display("ANDI Instruction: aluout = %h (Expected: R1 & 15)", aluout);

    // Test Case 4: Immediate instruction (ORI)
    instr = {6'b001101, 5'b00001, 5'b00101, 16'b0000000000001010}; // ORI R5, R1, 10
    regdst = 0;
    alusrc = 1;
    alucontrol = 4'b0001; // ALU control for OR
    regwrite = 1;
    #10;
    $display("ORI Instruction: aluout = %h (Expected: R1 | 10)", aluout);

    // Test Case 5: Immediate instruction (SLTI)
    instr = {6'b001010, 5'b00001, 5'b00110, 16'b0000000000000011}; // SLTI R6, R1, 3
    regdst = 0;
    alusrc = 1;
    alucontrol = 4'b0111; // ALU control for SLT
    regwrite = 1;
    #10;
    $display("SLTI Instruction: aluout = %h (Expected: R1 < 3 ? 1 : 0)", aluout);

    // Test Case 6: Immediate instruction (ADDI)
    instr = {6'b001000, 5'b00010, 5'b00111, 16'b0000000000000001}; // ADDI R7, R2, 1
    regdst = 0;
    alusrc = 1;
    alucontrol = 4'b0010; // ALU control for ADD
    regwrite = 1;
    #10;
    $display("ADDI Instruction: aluout = %h (Expected: R2 + 1)", aluout);

    // Test Case 7: Immediate instruction (ANDI)
    instr = {6'b001100, 5'b00010, 5'b01000, 16'b0000000000001110}; // ANDI R8, R2, 14
    regdst = 0;
    alusrc = 1;
    alucontrol = 4'b0000; // ALU control for AND
    regwrite = 1;
    #10;
    $display("ANDI Instruction: aluout = %h (Expected: R2 & 14)", aluout);

    // Test Case 8: Immediate instruction (ORI)
    instr = {6'b001101, 5'b00010, 5'b01001, 16'b0000000000001011}; // ORI R9, R2, 11
    regdst = 0;
    alusrc = 1;
    alucontrol = 4'b0001; // ALU control for OR
    regwrite = 1;
    #10;
    $display("ORI Instruction: aluout = %h (Expected: R2 | 11)", aluout);

    // Test Case 9: Immediate instruction (SLTI)
    instr = {6'b001010, 5'b00010, 5'b01010, 16'b0000000000000010}; // SLTI R10, R2, 2
    regdst = 0;
    alusrc = 1;
    alucontrol = 4'b0111; // ALU control for SLT
    regwrite = 1;
    #10;
    $display("SLTI Instruction: aluout = %h (Expected: R2 < 2 ? 1 : 0)", aluout);

    // Test Case 10: Immediate instruction (ADDI)
    instr = {6'b001000, 5'b00011, 5'b01011, 16'b0000000000000101}; // ADDI R11, R3, 5
    regdst = 0;
    alusrc = 1;
    alucontrol = 4'b0010; // ALU control for ADD
    regwrite = 1;
    #10;
    $display("ADDI Instruction: aluout = %h (Expected: R3 + 5)", aluout);

    // Test Case 11: Arithmetic instruction (ADD)
    instr = {6'b000000, 5'b00001, 5'b00010, 5'b00011, 5'b00000, 6'b100000}; // ADD R3, R1, R2
    regdst = 1;
    alusrc = 0;
    alucontrol = 4'b0010; // ALU control for ADD
    regwrite = 1;
    #10;
    $display("ADD Instruction: aluout = %h (Expected: sum of R1 and R2)", aluout);

    // Test Case 12: Memory instruction (LW)
    instr = {6'b100011, 5'b00001, 5'b00010, 16'b0000000000000100}; // LW R2, 4(R1)
    regdst = 0;
    alusrc = 1;
    memtoreg = 1;
    regwrite = 1;
    readdata = 32'h12345678; // Data from memory
    #10;
    $display("LW Instruction: data_wb = %h (Expected: 12345678)", writedata);

    // Test Case 13: Jump instruction (J)
    instr = {6'b000010, 26'b00000000000000000000000001}; // J 1
    jump = 1;
    #10;
    $display("Jump Instruction: pc = %h (Expected: 4)", pc);

    // Test Case 14: Branch instruction (BEQ)
    instr = {6'b000100, 5'b00001, 5'b00010, 16'b0000000000000010}; // BEQ R1, R2, offset 2
    jump = 0;
    
    regdst = 0;
    alusrc = 0;
    alucontrol = 4'b0110; // ALU control for SUB
    pcsrc = 1;
    regwrite = 0;
    #10;
    $display("BEQ Instruction: pc = %h (Expected: branch target address)", pc);
    
    
    // Finish simulation
    $finish;
  end

endmodule








module mips_1_tb;

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

    // Test case 1: Load Word (lw) Instruction
    instr = {6'b100011, 5'b00001, 5'b00010, 16'b0000000000000100}; // lw R2, 4(R1)
    readdata = 32'hDEADBEEF; // Simulate memory read data
    #10;
    $display("Test Case 1 - LW Instruction: writedata = %h (Expected: DEADBEEF)", writedata);

    // Test case 2: Store Word (sw) Instruction
    instr = {6'b101011, 5'b00001, 5'b00010, 16'b0000000000000100}; // sw R2, 4(R1)
    #10;
    $display("Test Case 2 - SW Instruction: writedata = %h (Expected: R2 value)", writedata);

    // Test case 3: Load Word (lw) Instruction
    instr = {6'b100011, 5'b00011, 5'b00100, 16'b0000000000001000}; // lw R4, 8(R3)
    readdata = 32'hCAFEBABE; // Simulate memory read data
    #10;
    $display("Test Case 3 - LW Instruction: writedata = %h (Expected: CAFEBABE)", writedata);

    // Test case 4: Store Word (sw) Instruction
    instr = {6'b101011, 5'b00011, 5'b00100, 16'b0000000000001000}; // sw R4, 8(R3)
    #10;
    $display("Test Case 4 - SW Instruction: writedata = %h (Expected: R4 value)", writedata);

    // Test case 5: Load Word (lw) Instruction
    instr = {6'b100011, 5'b00101, 5'b00110, 16'b0000000000001100}; // lw R6, 12(R5)
    readdata = 32'hB16B00B5; // Simulate memory read data
    #10;
    $display("Test Case 5 - LW Instruction: writedata = %h (Expected: B16B00B5)", writedata);
    
    // Test case 6: Store Word (lw) Instruction
    instr = {6'b100011, 5'b00101, 5'b00110, 16'b0000000000001100}; // sw R6, 12(R5)
    #10;
    $display("Test Case 6 - SW Instruction: writedata = %h (Expected: R6 value)", writedata);
    

    // End simulation

    // Finish the simulation
    $finish;
  end

endmodule







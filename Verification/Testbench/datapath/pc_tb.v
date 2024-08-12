module pc_tb;

  // Inputs
  reg clk;
  reg reset;
  reg jump;
  reg pcsrc;
  reg [25:0] instr;

  // Outputs
  wire [31:0] pc;
  integer checker;
  integer count = 0;
  integer err_cnt = 0;
  // Instantiate the Unit Under Test (UUT)
  pc uut (clk, reset, jump, pcsrc, instr, pc);
  
  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initialize Inputs
    clk <= 0;
    reset <= 0;
    jump <= 0;
    pcsrc <= 0;
    instr <= 26'b0;

    // Apply reset
    #10;
    reset = 1;
    #5;
    
    // Test case 1: Normal PC increment
    instr = 26'h000004;
    #10;
  

    // Test case 2: Normal PC increment
    instr = 26'h000008;
    #10;


    // Test case 3: Normal PC increment
    instr = 26'h00000C;
    #10;


    // Test case 4: Branch instruction (simulated by specific instruction value)
    pcsrc = 1;
    instr = 26'h100014; // Branch to address 0x000014
    #10;
    pcsrc = 0;


    // Test case 5: Normal PC increment
    instr = 26'h000018;
    #10;


    // Test case 6: Jump instruction (simulated by specific instruction value)
    jump = 1;
    instr = 26'h200020; // Jump to address 0x000020
    #10;
    jump = 0;


    // Test case 7: Normal PC increment
    instr = 26'h000024;
    #10;


    // Test case 8: Branch instruction
    pcsrc = 1;
    instr = 26'h10002C; // Branch to address 0x00002C
    #10;
    pcsrc = 0;


    // Test case 9: Normal PC increment
    instr = 26'h000030;
    #10;


    // Test case 10: Jump instruction
    jump = 1;
    instr = 26'h200038; // Jump to address 0x000038
    #10;
    jump = 0;


    // Test case 11: Reset
    reset = 0;
    #10;
    reset = 1;


    // Test case 12: Normal PC increment
    instr = 26'h000004;
    #10;


    // Test case 13: Normal PC increment
    instr = 26'h000008;
    #10;


    // Test case 14: Branch instruction
    pcsrc = 1;
    instr = 26'h100010; // Branch to address 0x000010
    #10;
    pcsrc = 0;


    // Test case 15: Normal PC increment
    instr = 26'h000014;
    #10;


    // Test case 16: Jump instruction
    jump = 1;
    instr = 26'h20001C; // Jump to address 0x00001C
    #10;
    jump = 0;


    // Test case 17: Normal PC increment
    instr = 26'h000020;
    #10;


    // Test case 18: Branch instruction
    pcsrc = 1;
    instr = 26'h100028; // Branch to address 0x000028
    #10;
    pcsrc = 0;

    // Test case 19: Normal PC increment
    instr = 26'h00002C;
    #10;

    // Test case 20: Jump instruction
    jump = 1;
    instr = 26'h200034; // Jump to address 0x000034
    #10;
    jump = 0;
    


    // Finish simulation
    if(err_cnt == 0) begin
      $display("/n=============================");
      $display("TEST SUCCESS");
      $display("=============================\n");
    end
    else begin
      $display("/n=============================");
      $display("TEST FAIL: %0d testcase", err_cnt);
      $display("=============================\n");
    end
   $finish;
  end
  
  initial begin
    forever begin
        @(posedge clk); #1;
            if(!reset) checker = 0;
            else begin
                if(jump) checker = instr[25:0] << 2;
                else if(pcsrc) checker = checker + 4 + (instr[15:0] << 2);
                else checker = checker + 4;
            end
            if(checker == pc) begin 
              $display("Testcase %0d[Success]: expected pc = %h, got pc = %h", count, checker, pc);
            end
            if (checker != pc) begin
              err_cnt = err_cnt + 1;
              $display("Testcase %0d[ERROR]: expected pc = %h, got pc = %h", count, checker, pc);
            end
            count  = count + 1;
    end
  end
  
endmodule





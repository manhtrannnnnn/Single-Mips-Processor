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
  integer count = 1;
  integer err_cnt = 0;
  // Instantiate the Unit Under Test (UUT)
  pc uut (clk, reset, jump, pcsrc, instr, pc);
  
  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initialize Inputs
    clk = 0;
    reset = 0;
    jump = 0;
    pcsrc = 0;
    instr = 26'b0;

    // Apply reset
    #10;
    reset = 1;
    #5;

    // Test case 1: Normal PC increment
    instr = 26'h000004; // Some instruction
    #10;
    //$display("Test case 1: pc = %h (Expected: 00000004)", pc);

    // Test case 2: Branch not taken (pcsrc = 0)
    pcsrc = 0;
    instr = 26'h000010; // Branch instruction
    #10;
    //$display("Test case 2: pc = %h (Expected: 00000008)", pc);

    // Test case 3: Branch taken (pcsrc = 1)
    pcsrc = 1;
    instr = 26'h000010; // Branch instruction
    #10;
    //$display("Test case 3: pc = %h (Expected: 0000004c)", pc); // 0x08 + (0x000010 << 2)

    // Test case 4: Jump taken
    jump = 1;
    instr = 26'h000020; // Jump instruction
    #10;
    //$display("Test case 4: pc = %h (Expected: 00000080)", pc); // 0x000020 << 2

    // Test case 5: Reset
    jump = 0;
    reset = 0;
    #10;
    //$display("Test case 5: pc = %h (Expected: 00000000)", pc);

    // Test case 6: Normal PC increment after reset
    reset = 1;
    pcsrc = 0;
    instr = 26'h000004; // Some instruction
    #10;
    //$display("Test case 6: pc = %h (Expected: 00000004)", pc);

    // Test case 7: Jump not taken (jump = 0)
    jump = 0;
    instr = 26'h000040; // Jump instruction
    #10;
    //$display("Test case 7: pc = %h (Expected: 00000008)", pc);

    // Test case 8: Branch not taken (pcsrc = 0)
    pcsrc = 0;
    instr = 26'h000080; // Branch instruction
    #10;
    //$display("Test case 8: pc = %h (Expected: 0000000C)", pc);

    // Test case 9: Branch taken (pcsrc = 1)
    pcsrc = 1;
    instr = 26'h000100; // Branch instruction
    #10;
    //$display("Test case 9: pc = %h (Expected: 000000410)", pc); // 0x0C + (0x000100 << 2)

    // Test case 10: Jump taken after branch
    jump = 1;
    instr = 26'h000200; // Jump instruction
    #10;
    //$display("Test case 10: pc = %h (Expected: 00000800)", pc); // 0x000200 << 2

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
        @(posedge clk or negedge reset); #1;
            if(!reset) checker = 0;
            else begin
                if(jump) checker = instr[25:0] << 2;
                else if(pcsrc) checker = checker + 4 + (instr[15:0] << 2);
                else checker = checker + 4;
            end
            if(checker == pc) begin 
              $display("[TIME: %0t]Testcase %0d[Success]: expected pc = %h, got pc = %h",$time, count, checker, pc);
            end
            if (checker != pc) begin
              err_cnt = err_cnt + 1;
              $display("[TIME: %0t]Testcase %0d[ERROR]: expected pc = %h, got pc = %h",$time, count, checker, pc);
            end
            count  = count + 1;
    end
  end
  
endmodule



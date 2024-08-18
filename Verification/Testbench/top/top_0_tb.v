module top_0_tb;
  // Inputs
  reg clk;
  reg reset;

  // Outputs
  wire [31:0] pc;
  wire [31:0] aluout;

  // Error counter
  integer err_cnt = 0;

  // Instantiate the Unit Under Test (UUT)
  top uut (clk, reset, pc, aluout, readdata, writedata);

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin
    $display("Simulation starts!!!!");
    reset = 1;
    #10;
    reset = 0;
  end

  // Test sequence
  always @(posedge clk) begin
    // Test ADD R3, R2, R4 at 0x00
    if (pc == 32'h00) begin
      if (aluout !== 0) begin // Expected result: R2 + R4 = 0
        $display("Error at PC: %h, aluout: %d (Expected: 0)", pc, aluout);
        err_cnt = err_cnt + 1;
      end
    end

    // Test ADDI R2, R1, 2 at 0x04
    if (pc == 32'h04) begin
      if (aluout !== 2) begin // Expected result: R1 + 2 = 2
        $display("Error at PC: %h, aluout: %d (Expected: 2)", pc, aluout);
        err_cnt = err_cnt + 1;
      end
    end
    
    // Test ORI R3, R1, 4 at 0x08
    if (pc == 32'h08) begin
      if (aluout !== 4) begin // Expected result: R1 | 4 = 4
        $display("Error at PC: %h, aluout: %d (Expected: 4)", pc, aluout);
        err_cnt = err_cnt + 1;
      end
    end
    
    // Test SLTI R4, R1, 3 at 0x0c
    if (pc == 32'h0c) begin
      if (aluout !== 1) begin // Expected result: (R1 < 3) ? 1 : 0 = 1
        $display("Error at PC: %h, aluout: %d (Expected: 1)", pc, aluout);
        err_cnt = err_cnt + 1;
      end
    end
    
    // Test ADD R3, R4, R2 at 0x10
    if (pc == 32'h10) begin
      if (aluout !== 3) begin // Expected result: R4 + R2 = 3
        $display("Error at PC: %h, aluout: %d (Expected: 3)", pc, aluout);
        err_cnt = err_cnt + 1;
      end
    end
    
    // Test SUB R1, R3, R4 at 0x14
    if (pc == 32'h14) begin
      if (aluout !== 2) begin // Expected result: R3 - R4 = 2
        $display("Error at PC: %h, aluout: %d (Expected: 2)", pc, aluout);
        err_cnt = err_cnt + 1;
      end
    end
    
    // Test OR R3, R1, R2 at 0x18
    if (pc == 32'h18) begin
      if (aluout !== 0) begin // Expected result: R1 | R2 = 0
        $display("Error at PC: %h, aluout: %d (Expected: 0)", pc, aluout);
        err_cnt = err_cnt + 1;
      end
    end
    
    // Test AND R3, R1, R2 at 0x1c
    if (pc == 32'h1c) begin
      if (aluout !== 0) begin // Expected result: R1 & R2 = 0
        $display("Error at PC: %h, aluout: %d (Expected: 0)", pc, aluout);
        err_cnt = err_cnt + 1;
      end
    end
    
    // Test SLT R3, R1, R2 at 0x20
    if (pc == 32'h20) begin
      if (aluout !== 0) begin // Expected result: (R1 < R2) ? 1 : 0 = 0
        $display("Error at PC: %h, aluout: %d (Expected: 0)", pc, aluout);
        err_cnt = err_cnt + 1;
      end
    end
  end

  // Final error report
initial begin
    // Apply stimulus here
    $monitor("PC: %h, ALU Out: %d, Read Data: %h", pc, aluout, readdata);

    // Wait for some time and then check results
    #200;

    if (err_cnt == 0) begin
      $display("All tests passed.");
    end else begin
      $display("%d errors found.", err_cnt);
    end

    $stop; // Stop the simulation
  end

endmodule


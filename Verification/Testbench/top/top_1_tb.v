module top_1_tb;
  // Inputs
  reg clk;
  reg reset;

  // Outputs
  wire [31:0] pc;
  wire [31:0] aluout;
  wire [31:0] readdata;
  wire [31:0] writedata;

  // Error counter
  integer err_cnt = 0;

  // Instantiate the Unit Under Test (UUT)
  top uut (clk, reset, pc, aluout, readdata, writedata);

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  // Initial setup and reset
  initial begin
    $display("Simulation starts!!!!");
    reset = 0;
    #10;
    reset = 1;
  end

  // Test sequence
  always @(posedge clk) begin
    // Test sw R2, 4(R1) at 0x0c
    if (pc == 32'h0c) begin
      if (aluout !== 4 || writedata !== 5) begin 
        $display("Error at PC: %h, aluout: %h, writedata: %h (Expected: 4, 5)", pc, aluout, writedata);
        err_cnt = err_cnt + 1;
      end
    end

    // Test lw R2, 4(R1) at 0x10
    if (pc == 32'h10) begin
      if (aluout !== 4 || readdata !== 5) begin
        $display("Error at PC: %h, aluout: %h, readdata: %h (Expected: 4, 5)", pc, aluout, readdata);
        err_cnt = err_cnt + 1;
      end
    end
    
    // Test sw R4, 8(R3) at 0x14
    if (pc == 32'h14) begin
      if (aluout !== 13 || writedata !== 10) begin 
        $display("Error at PC: %h, aluout: %h, writedata: %h (Expected: 13, 10)", pc, aluout, writedata);
        err_cnt = err_cnt + 1;
      end
    end
    
    // Test lw R4, 8(R3) at 0x18
    if (pc == 32'h18) begin
      if (aluout !== 13 || readdata !== 10) begin 
        $display("Error at PC: %h, aluout: %h, readdata: %h (Expected: 13, 10)", pc, aluout, readdata);
        err_cnt = err_cnt + 1;
      end
    end
    
    // Test sw R6, 12(R5) at 0x1c
    if (pc == 32'h1c) begin
      if (aluout !== 22 || writedata !== 15) begin 
        $display("Error at PC: %h, aluout: %h, writedata: %h (Expected: 22, 15)", pc, aluout, writedata);
        err_cnt = err_cnt + 1;
      end
    end
    
    // Test lw R6, 12(R5) at 0x20
    if (pc == 32'h20) begin
      if (aluout !== 22 || readdata !== 15) begin
        $display("Error at PC: %h, aluout: %h, readdata: %h (Expected: 22, 15)", pc, aluout, readdata);
        err_cnt = err_cnt + 1;
      end
    end
    
    // Test beq R2, R4, offset 2 at 0x24
    if (pc == 32'h24) begin
      #5; // Wait for the branch to take effect
      if (pc !== 32'h28) begin
        $display("Error at beq R2, R4, offset 2, PC: %h (Expected: 32'h28)", pc);
        err_cnt = err_cnt + 1;
      end
    end

    // Test beq R2, R3, offset 2 at 0x28
    if (pc == 32'h28) begin
      #5; // Wait for the branch to take effect
      if (pc !== 32'h34) begin 
        $display("Error at beq R2, R3, offset 2, PC: %h,  aluout: %d (Expected: 32'h34)",$time, pc, aluout);
        err_cnt = err_cnt + 1;
      end
    end
    
    if(pc == 32'h2c || pc == 32'h30) begin
      $display("Error at branch instruction");
      err_cnt = err_cnt + 1;
    end  
      
    // Test jump to address 0x04 at 0x34
    if (pc == 32'h34) begin
      #5; // Wait for the jump to take effect
      if (pc !== 32'h04) begin
        $display("Error at Jump instruction, PC: %h (Expected: 32'h04)",$time, pc);
        err_cnt = err_cnt + 1;
      end
    end
  end

  // Final error report
  initial begin
    // Monitor important signals
    $monitor("PC: %h, ALU Out: %h, Read Data: %h, Write Data: %h", pc, aluout, readdata, writedata);

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


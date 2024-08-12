module ALU_tb;

  reg [3:0] alucontrol;
  reg [4:0] ALU_operand_1;
  reg [4:0] ALU_operand_2;
  wire [4:0] aluout;
  wire Zero;
  integer err_cnt;
  reg clk;

  ALU #(5) dut(alucontrol, ALU_operand_1, ALU_operand_2, aluout, Zero);

  // Expected result calculation
  reg [4:0] expected_aluout;
  reg expected_zero;

  initial begin
    alucontrol = 0;
    ALU_operand_1 = 0;
    ALU_operand_2 = 0;

    #10
    ALU_operand_1 = $random;
    ALU_operand_2 = $random;
    alucontrol = 4'b0010; // add
    #10;
    $display("ADD: In1 = %0d, In2 = %0d, aluout = %0d, Zero = %0b, Expected: aluout = %0d, Zero = %0b", 
             ALU_operand_1, ALU_operand_2, aluout, Zero, expected_aluout, expected_zero);
             
    ALU_operand_1 = $random;
    ALU_operand_2 = $random;
    alucontrol = 4'b0001; // OR 
    #10;
    $display("OR: In1 = %0d, In2 = %0d, aluout = %0d, Zero = %0b, Expected: aluout = %0d, Zero = %0b", 
             ALU_operand_1, ALU_operand_2, aluout, Zero, expected_aluout, expected_zero);
    
    ALU_operand_1 = $random;
    ALU_operand_2 = 5;
    alucontrol = 4'b0110; // subtract
    #10;
    $display("SUB: In1 = %0d, In2 = %0d, aluout = %0d, Zero = %0b, Expected: aluout = %0d, Zero = %0b", 
             ALU_operand_1, ALU_operand_2, aluout, Zero, expected_aluout, expected_zero);
             
    ALU_operand_1 = $random;
    ALU_operand_2 = $random;
    alucontrol = 4'b0000; // AND
    #10;
    $display("AND: In1 = %0d, In2 = %0d, aluout = %0d, Zero = %0b, Expected: aluout = %0d, Zero = %0b", 
             ALU_operand_1, ALU_operand_2, aluout, Zero, expected_aluout, expected_zero);
             
    ALU_operand_1 = $random;
    ALU_operand_2 = $random;
    alucontrol = 4'b0010; // ADD
    #10;
    $display("ADD: In1 = %0d, In2 = %0d, aluout = %0d, Zero = %0b, Expected: aluout = %0d, Zero = %0b", 
             ALU_operand_1, ALU_operand_2, aluout, Zero, expected_aluout, expected_zero);
             
    ALU_operand_1 = $random;
    ALU_operand_2 = $random;
    alucontrol = 4'b0111; // SLT (set less than)
    #10;
    $display("SLT: In1 = %0d, In2 = %0d, aluout = %0d, Zero = %0b, Expected: aluout = %0d, Zero = %0b", 
             ALU_operand_1, ALU_operand_2, aluout, Zero, expected_aluout, expected_zero);

    ALU_operand_1 = $random;
    ALU_operand_2 = $random;
    alucontrol = 4'b0110; // beq (subtract)
    #10;
    $display("SUB: In1 = %0d, In2 = %0d, aluout = %0d, Zero = %0b, Expected: aluout = %0d, Zero = %0b", 
             ALU_operand_1, ALU_operand_2, aluout, Zero, expected_aluout, expected_zero);
             
    ALU_operand_1 = 25;
    ALU_operand_2 = 25;
    alucontrol = 4'b0110; // beq (subtract equal)
    #10;
    $display("BEQ(equal): In1 = %0d, In2 = %0d, aluout = %0d, Zero = %0b, Expected: aluout = %0d, Zero = %0b", 
             ALU_operand_1, ALU_operand_2, aluout, Zero, expected_aluout, expected_zero);
    
    ALU_operand_1 = $random;
    ALU_operand_2 = $random;
    alucontrol = 4'b0110; // beq (subtract equal)
    #10;
    $display("BEQ(not equal): In1 = %0d, In2 = %0d, aluout = %0d, Zero = %0b, Expected: aluout = %0d, Zero = %0b", 
             ALU_operand_1, ALU_operand_2, aluout, Zero, expected_aluout, expected_zero);
         
    ALU_operand_1 = $random;
    ALU_operand_2 = $random;
    alucontrol = 4'b0000; // AND
    #10;
    $display("AND: In1 = %0d, In2 = %0d, aluout = %0d, Zero = %0b, Expected: aluout = %0d, Zero = %0b", 
             ALU_operand_1, ALU_operand_2, aluout, Zero, expected_aluout, expected_zero);
             
    ALU_operand_1 = $random;
    ALU_operand_2 = $random;
    alucontrol = 4'b0001; // OR
    #10;
    $display("OR: In1 = %0d, In2 = %0d, aluout = %0d, Zero = %0b, Expected: aluout = %0d, Zero = %0b", 
             ALU_operand_1, ALU_operand_2, aluout, Zero, expected_aluout, expected_zero);
             
    ALU_operand_1 = $random;
    ALU_operand_2 = $random;
    alucontrol = 4'b0111; // SLT (set less than)
    #10;
    $display("SLT: In1 = %0d, In2 = %0d, aluout = %0d, Zero = %0b, Expected: aluout = %0d, Zero = %0b", 
             ALU_operand_1, ALU_operand_2, aluout, Zero, expected_aluout, expected_zero);
             
    ALU_operand_1 = $random;
    ALU_operand_2 = $random;
    alucontrol = 4'b0110; // sub again
    
    #10;
    $display("SUB: In1 = %0d, In2 = %0d, aluout = %0d, Zero = %0b, Expected: aluout = %0d, Zero = %0b", 
             ALU_operand_1, ALU_operand_2, aluout, Zero, expected_aluout, expected_zero);

    //End simulation
    if(err_cnt == 0) begin
      $display("\n===============================================");
      $display("TEST SUCCESS");
      $display("===============================================\n");
    end
    else begin
      $display("\n===============================================");
      $display("TEST FAIL: %0d testcase(s) failed", err_cnt);
      $display("===============================================\n");
    end
    $finish;
  end

  initial begin
    clk = 0;
    forever begin
      #5; clk = ~clk;
    end
  end

  initial begin
    err_cnt = 0;
    expected_aluout = 0;
    expected_zero = 1;
    forever begin
      @(negedge clk); #1;
        if(alucontrol == 4'b0010) begin
          expected_aluout = ALU_operand_1 + ALU_operand_2; // add
          expected_zero = (expected_aluout == 0);
        end
        else if(alucontrol == 4'b0110) begin
          expected_aluout = ALU_operand_1 - ALU_operand_2; // subtract
          expected_zero = (ALU_operand_1 == ALU_operand_2);
        end
        else if(alucontrol == 4'b0000) begin
          expected_aluout = ALU_operand_1 & ALU_operand_2; // and
          expected_zero = (ALU_operand_1 == ALU_operand_2);
        end
        else if(alucontrol == 4'b0001) begin
          expected_aluout = ALU_operand_1 | ALU_operand_2; // or
          expected_zero = (ALU_operand_1 == ALU_operand_2);
        end
        else if(alucontrol == 4'b0111) begin
          expected_aluout = (ALU_operand_1 < ALU_operand_2) ? 1 : 0; // slt
          expected_zero = (ALU_operand_1 == ALU_operand_2);
        end
        else begin
          expected_aluout = 0;
          expected_zero = (ALU_operand_1 == ALU_operand_2);
        end
          
        if (aluout !== expected_aluout || Zero !== expected_zero) begin
          err_cnt = err_cnt + 1;
          $display("Error: Expected aluout = %0d, Zero = %0b; Got aluout = %0d, Zero = %0b", 
                 expected_aluout, expected_zero, aluout, Zero);
        end
        
      end
  end

endmodule


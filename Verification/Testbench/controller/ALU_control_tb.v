module ALU_control_tb;
    // Inputs
    reg [5:0] opcode;
    reg [5:0] funct;
    reg [1:0] aluop;

    // Outputs
    wire [3:0] alucontrol;
    integer count = 0;

    // Instantiate the ALU_control module
    ALU_control dut(funct, opcode, aluop, alucontrol);

    initial begin
        // Initialize Inputs
        opcode = 6'b0;
        funct = 6'b0;
        aluop = 2'b0;
    end

    initial begin
        // Monitor changes
        $monitor("Time: %0t | opcode: %b | funct: %b | aluop: %b | alucontrol: %b", $time, opcode, funct, aluop, alucontrol);
        #10;
        // Test case: LW, SW
        opcode = 6'b100011;
        funct = 6'b000000;
        aluop = 2'b00;
        #10;
        if (alucontrol !== 4'b0010) begin
            $display("Test Failed: LW, SW");
            count = count + 1;
        end else $display("Test success: LW, SW");

        // Test case: BEQ, BNE
        opcode = 6'b000100;
        funct = 6'b000000;
        aluop = 2'b01;
        #10;
        if (alucontrol !== 4'b0110) begin
            $display("Test Failed: BEQ, BNE");
            count = count + 1;
        end else $display("Test success: BEQ, BNE");

        // Test case: ADDI
        opcode = 6'b001000;
        funct = 6'b000000;
        aluop = 2'b10;
        #10;
        if (alucontrol !== 4'b0010) begin
            $display("Test Failed: ADDI");
            count = count + 1;
        end else $display("Test success: ADDI");

        // Test case: ANDI
        opcode = 6'b001100;
        funct = 6'b000000;
        aluop = 2'b10;
        #10;
        if (alucontrol !== 4'b0000) begin
            $display("Test Failed: ANDI");
            count = count + 1;
        end else $display("Test success: ANDI");

        // Test case: ORI
        opcode = 6'b001101;
        funct = 6'b000000;
        aluop = 2'b10;
        #10;
        if (alucontrol !== 4'b0001) begin
            $display("Test Failed: ORI");
            count = count + 1;
        end else $display("Test success: ORI");

        // Test case: SLTI
        opcode = 6'b001010;
        funct = 6'b000000;
        aluop = 2'b10;
        #10;
        if (alucontrol !== 4'b0111) begin
            $display("Test Failed: SLTI");
            count = count + 1;
        end else $display("Test success: SLTI");

        // Test case: R-type ADD
        aluop = 2'b11;
        opcode = 6'b000000;
        funct = 6'b100000;
        #10;
        if (alucontrol !== 4'b0010) begin
            $display("Test Failed: R-type ADD");
            count = count + 1;
        end else $display("Test success: ADD");

        // Test case: R-type SUBTRACT
        aluop = 2'b11;
        opcode = 6'b000000;
        funct = 6'b100010;
        #10;
        if (alucontrol !== 4'b0110) begin
            $display("Test Failed: R-type SUBTRACT");
            count = count + 1;
        end else $display("Test success: SUB");

        // Test case: R-type AND
        aluop = 2'b11;
        opcode = 6'b000000;
        funct = 6'b100100;
        #10;
        if (alucontrol !== 4'b0000) begin
            $display("Test Failed: R-type AND");
            count = count + 1;
        end else $display("Test success: AND");

        // Test case: R-type OR
        aluop = 2'b11;
        opcode = 6'b000000;
        funct = 6'b100101;
        #10;
        if (alucontrol !== 4'b0001) begin
            $display("Test Failed: R-type OR");
            count = count + 1;
        end else $display("Test success: OR");

        // Test case: R-type SLT
        aluop = 2'b11;
        opcode = 6'b000000;
        funct = 6'b101010;
        #10;
        if (alucontrol !== 4'b0111) begin
            $display("Test Failed: R-type SLT");
            count = count + 1;
        end else $display("Test success: SLT");

        // Result
        if(count == 0) $display("All test cases passed");
        else $display("%d test case(s) failed", count);
        $finish;
    end
endmodule


// Code your testbench here
// or browse Examples
module control_tb;

    // Inputs
    reg [5:0] opcode;

    // Outputs
    wire memtoreg;
    wire memwrite;
    wire branch;
    wire alusrc;
    wire regdst;
    wire regwrite;
    wire jump;
    wire [1:0] aluop;

    // Instantiate the Unit Under Test (UUT)
  control uut (opcode, branch, regdst, memtoreg, alusrc, regwrite, jump, memwrite, aluop);

//     // Test sequence
    initial begin
        // Test R-type instruction
        opcode = 6'b000000;
        #10;
        $display("R-type: regwrite=%b, regdst=%b, alusrc=%b, branch=%b, memwrite=%b, memtoreg=%b, aluop=%b, jump=%b", regwrite, regdst, alusrc, branch, memwrite, memtoreg, aluop, jump);

        // Test lw instruction
        opcode = 6'b100011;
        #10;
        $display("lw: regwrite=%b, regdst=%b, alusrc=%b, branch=%b, memwrite=%b, memtoreg=%b, aluop=%b, jump=%b", regwrite, regdst, alusrc, branch, memwrite, memtoreg, aluop, jump);

        // Test sw instruction
        opcode = 6'b101011;
        #10;
        $display("sw: regwrite=%b, regdst=%b, alusrc=%b, branch=%b, memwrite=%b, memtoreg=%b, aluop=%b, jump=%b", regwrite, regdst, alusrc, branch, memwrite, memtoreg, aluop, jump);
		
        opcode = 6'b000100;
        #10;
        $display("beq: regwrite=%b, regdst=%b, alusrc=%b, branch=%b, memwrite=%b, memtoreg=%b, aluop=%b, jump=%b", regwrite, regdst, alusrc, branch, memwrite, memtoreg, aluop, jump);

        // Test addi instruction
        opcode = 6'b001000;
        #10;
        $display("addi: regwrite=%b, regdst=%b, alusrc=%b, branch=%b, memwrite=%b, memtoreg=%b, aluop=%b, jump=%b", regwrite, regdst, alusrc, branch, memwrite, memtoreg, aluop, jump);

        // Test ori instruction
        opcode = 6'b001101;
        #10;
        $display("ori: regwrite=%b, regdst=%b, alusrc=%b, branch=%b, memwrite=%b, memtoreg=%b, aluop=%b, jump=%b", regwrite, regdst, alusrc, branch, memwrite, memtoreg, aluop, jump);

        // Test slti instruction
        opcode = 6'b001010;
        #10;
        $display("slti: regwrite=%b, regdst=%b, alusrc=%b, branch=%b, memwrite=%b, memtoreg=%b, aluop=%b, jump=%b", regwrite, regdst, alusrc, branch, memwrite, memtoreg, aluop, jump);

        // Test jump instruction
        opcode = 6'b000010;
        #10;
        $display("jump: regwrite=%b, regdst=%b, alusrc=%b, branch=%b, memwrite=%b, memtoreg=%b, aluop=%b, jump=%b", regwrite, regdst, alusrc, branch, memwrite, memtoreg, aluop, jump);

        // Test default case
        opcode = 6'b111111;
        #10;
        $display("default: regwrite=%b, regdst=%b, alusrc=%b, branch=%b, memwrite=%b, memtoreg=%b, aluop=%b, jump=%b", regwrite, regdst, alusrc, branch, memwrite, memtoreg, aluop, jump);

        // Finish the simulation
        $finish;
    end

endmodule

  



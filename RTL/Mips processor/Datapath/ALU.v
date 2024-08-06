module ALU (
    input [3:0] alucontrol,
    input [31:0] ALU_operand_1,
    input [31:0] ALU_operand_2,
    output reg [31:0] aluout,
    output zero
);
  
  always @(*) begin
    case(alucontrol)
      4'b0010: aluout = ALU_operand_1 + ALU_operand_2; //add
      4'b0110: aluout = ALU_operand_1 - ALU_operand_2; //sub
      4'b0000: aluout = ALU_operand_1 & ALU_operand_2; //AND
      4'b0001: aluout = ALU_operand_1 | ALU_operand_2; //OR
      4'b0111: begin
        if(ALU_operand_1 < ALU_operand_2) aluout = 32'b1;
        else aluout = 32'b0;
      end 
    endcase
  end
  assign zero = (ALU_operand_1 == ALU_operand_2) ? 1 : 0

endmodule

module ALU #(parameter WIDTH = 32)(
    input [3:0] alucontrol,
    input [WIDTH-1:0] ALU_operand_1,
    input [WIDTH-1:0] ALU_operand_2,
    output reg [WIDTH-1:0] aluout,
    output zero
);

  always @(*) begin
    case(alucontrol)
      4'b0010: aluout = ALU_operand_1 + ALU_operand_2; // add
      4'b0110: aluout = ALU_operand_1 - ALU_operand_2; // sub
      4'b0000: aluout = ALU_operand_1 & ALU_operand_2; // AND
      4'b0001: aluout = ALU_operand_1 | ALU_operand_2; // OR
      4'b0111: begin
        if(ALU_operand_1 < ALU_operand_2) aluout = 1; // SLT
        else aluout = 0;
      end
      default: aluout = 0; // default case
    endcase
  end

  assign zero = (aluout == 0);

endmodule


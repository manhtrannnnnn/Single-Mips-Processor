module jump_funct #(parameter WIDTH = 32)(
  input [25:0] instr,
  input [WIDTH-1:0] pcadder,
  output [WIDTH-1:0] pcjump
);

  assign pcjump = {pcadder[31:28], instr, 2'b00}; // Concatenate upper bits of pcadder and instr, shift left by 2

endmodule



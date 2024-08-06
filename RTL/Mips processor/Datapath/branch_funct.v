module branch_funct #(parameter WIDTH = 32)(
  input [15:0] instr,
  input [WIDTH-1:0] pcadder,
  output [WIDTH-1:0] pcbranch
);

  wire [WIDTH-1:0] extend;
  wire [WIDTH-1:0] shiftleft;

  assign extend = {{16{instr[15]}}, instr};
  assign shiftleft = {extend[WIDTH-3:0], 2'b00}; // Shift left by 2
  assign pcbranch = shiftleft + pcadder;

endmodule



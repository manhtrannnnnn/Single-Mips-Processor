module IMEM(
  input [31:0] pc,
  output wire [31:0] instr
);

  reg [31:0] RAM[31:0]; 
  assign instr = RAM[pc];

endmodule
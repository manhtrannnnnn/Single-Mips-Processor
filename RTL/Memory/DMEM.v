module DMEM(
  input           clk,
  input           memwrite,
  input   [31:0]  DMEM_address,
  input   [31:0]  DMEM_data_in,
  output  [31:0]  readdata
);

  reg [31:0] RAM[63:0];

  assign readdata = RAM[DMEM_address];

  always @(posedge clk) begin
    if(memwrite) RAM[DMEM_address] <= DMEM_data_in;
  end

endmodule
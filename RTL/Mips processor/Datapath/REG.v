module REG(
  input           clk,
  input   [4:0]   REG_address1,
  input   [4:0]   REG_address2,
  input   [4:0]   REG_address_wb,
  input           regwrite,
  input   [31:0]  data_wb,
  output  [31:0]  data_out_1,
  output  [31:0]  data_out_2
);

  reg [31:0] REGISTER[31:0];

  always@(posedge clk) begin
    if(regwrite) REGISTER[REG_address_wb] <= data_wb;
  end 

  assign data_out_1 = (REG_address1 !=0) ? REGISTER[REG_address1] : 0;
  assign data_out_2 = (REG_address2 !=0) ? REGISTER[REG_address2] : 0;
endmodule
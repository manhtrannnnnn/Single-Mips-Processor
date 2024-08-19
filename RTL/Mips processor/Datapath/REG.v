module REG(
  input           clk,
  input           reset, 
  input   [4:0]   REG_address1,
  input   [4:0]   REG_address2,
  input   [4:0]   REG_address_wb,
  input           regwrite,
  input   [31:0]  data_wb,
  output  [31:0]  data_out_1,
  output  [31:0]  data_out_2
);
  integer i;
  reg [31:0] REGISTER[31:0];

  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      // setup register = 0
      
      for (i = 0; i < 32; i = i + 1) begin
        REGISTER[i] <= 0;
      end
    end else if (regwrite) begin
      REGISTER[REG_address_wb] <= data_wb;
    end
  end 

  assign data_out_1 = (REG_address1 != 0) ? REGISTER[REG_address1] : 0;
  assign data_out_2 = (REG_address2 != 0) ? REGISTER[REG_address2] : 0;
endmodule



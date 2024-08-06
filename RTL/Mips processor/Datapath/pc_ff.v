module pc_ff(
  input clk, reset,
  input [31:0] pcnext,
  output reg [31:0] pc
);
  always@(posedge clk or negedge reset) begin
    if(!reset) pc <= 32'b0;
    else pc <= pcnext;
  end
endmodule
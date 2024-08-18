module DMEM (
    input            clk, 
    input            memwrite,
    input  [31:0]    DMEM_address,
    input  [31:0]    DMEM_data_in,
    output wire [31:0]  readdata  
);
  reg [31:0] data_memory [31:0]; 

  always @(posedge clk) begin
    if (memwrite) begin
      data_memory[DMEM_address[31:2]] <= DMEM_data_in; //word allign
    end
  end
  
  assign readdata = data_memory[DMEM_address[31:2]]; 

endmodule


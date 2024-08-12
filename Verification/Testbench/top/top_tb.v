module top_tb;
  // Inputs
  reg clk;
  reg reset;

  // Outputs
  wire [31:0] pc;
  wire [31:0] aluout;
  wire [31:0] writedata;
  wire [31:0] readdata;

  // Instantiate the Unit Under Test (UUT)
  top uut (clk, reset, pc, aluout, writedata, readdata);

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin
    reset <= 0;
    #10;           
    reset <= 1;     
    
  end
  
  // check results
  always @ (negedge clk) begin
    if(pc === 32'h44) begin
       if(writedata === 7) begin
          $display("Test Success!!!");
          $stop;
        end else begin
          $display("Test Fail!!!");
        end
    end  
  end
  
  initial begin
    $monitor("PC: %h, aluout: %d", pc, aluout);
  end

endmodule



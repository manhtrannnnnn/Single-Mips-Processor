module REG_tb;

  reg           clk;
  reg   [4:0]   REG_address1;
  reg   [4:0]   REG_address2;
  reg   [4:0]   REG_address_wb;
  reg           regwrite;
  reg   [31:0]  data_wb;
  wire  [31:0]  data_out_1;
  wire  [31:0]  data_out_2;

  // Instantiate the module
  REG uut (clk, REG_address1, REG_address2, REG_address_wb, regwrite, data_wb, data_out_1, data_out_2);

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units period
  end

  // Checker task
  task check_output;
    input [31:0] expected_data_out_1;
    input [31:0] expected_data_out_2;
    begin
      if (data_out_1 !== expected_data_out_1) begin
        $display("ERROR: data_out_1 = %h, expected = %h", data_out_1, expected_data_out_1);
      end else begin
        $display("PASSED: data_out_1 = %h", data_out_1);
      end
      
      if (data_out_2 !== expected_data_out_2) begin
        $display("ERROR: data_out_2 = %h, expected = %h", data_out_2, expected_data_out_2);
      end else begin
        $display("PASSED: data_out_2 = %h", data_out_2);
      end
    end
  endtask

  // Test sequence
   // Test sequence
  initial begin
    // Initialize inputs
    REG_address1 <= 0;
    REG_address2 <= 0;
    REG_address_wb <= 0;
    regwrite <= 0;
    data_wb <= 0;

    // Wait for reset
    #10;

    // Write some data to the registers
    regwrite = 1;

    // Write values to registers 1 to 15
    REG_address_wb = 5'b00001; data_wb = 32'hDEADBEEF; #10;
    REG_address_wb = 5'b00010; data_wb = 32'hCAFEBABE; #10;
    REG_address_wb = 5'b00011; data_wb = 32'h12345678; #10;
    REG_address_wb = 5'b00100; data_wb = 32'h87654321; #10;
    REG_address_wb = 5'b00101; data_wb = 32'hABCDEF01; #10;
    REG_address_wb = 5'b00110; data_wb = 32'h0101FEDC; #10;
    REG_address_wb = 5'b00111; data_wb = 32'h00110011; #10;
    REG_address_wb = 5'b01000; data_wb = 32'h11001100; #10;
    REG_address_wb = 5'b01001; data_wb = 32'hFF00FF00; #10;
    REG_address_wb = 5'b01010; data_wb = 32'h00FF00FF; #10;
    REG_address_wb = 5'b01011; data_wb = 32'hAAAAAAAA; #10;
    REG_address_wb = 5'b01100; data_wb = 32'h55555555; #10;
    REG_address_wb = 5'b01101; data_wb = 32'h12341234; #10;
    REG_address_wb = 5'b01110; data_wb = 32'h56785678; #10;
    REG_address_wb = 5'b01111; data_wb = 32'h9ABC9ABC; #10;

    // Stop writing
    regwrite = 0;

    // Read and check values from registers 1 to 15
    REG_address1 = 5'b00001; REG_address2 = 5'b00010; #10; check_output(32'hDEADBEEF, 32'hCAFEBABE);
    REG_address1 = 5'b00011; REG_address2 = 5'b00100; #10; check_output(32'h12345678, 32'h87654321);
    REG_address1 = 5'b00101; REG_address2 = 5'b00110; #10; check_output(32'hABCDEF01, 32'h0101FEDC);
    REG_address1 = 5'b00111; REG_address2 = 5'b01000; #10; check_output(32'h00110011, 32'h11001100);
    REG_address1 = 5'b01001; REG_address2 = 5'b01010; #10; check_output(32'hFF00FF00, 32'h00FF00FF);
    REG_address1 = 5'b01011; REG_address2 = 5'b01100; #10; check_output(32'hAAAAAAAA, 32'h55555555);
    REG_address1 = 5'b01101; REG_address2 = 5'b01110; #10; check_output(32'h12341234, 32'h56785678);
    REG_address1 = 5'b01111; REG_address2 = 5'b00000; #10; check_output(32'h9ABC9ABC, 32'h00000000); // Reading from register 0 should return 0

    // End of test
    $finish;
  end

endmodule

module reset_assertion(input logic clk, input logic rst, input logic ready);

  property p_reset_ready;
    @(posedge clk) disable iff (rst) $rose(!rst) |=> ##2 ready;
  endproperty

  assert property(p_reset_ready);

endmodule

module tb;
  logic clk = 0, rst = 1, ready = 0;
  always #5 clk = ~clk;

  reset_assertion dut(clk, rst, ready);

  initial begin
    #10 rst = 0; // Deassert reset
    #15 ready = 1; // Pass (after 3rd cycle)
    #20 $finish;
  end
endmodule


  
//Output:
    # (No assertion failure — Passed)

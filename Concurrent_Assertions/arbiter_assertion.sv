module arbiter_assertion(input logic clk, input logic [1:0] req, input logic [1:0] grant);

  property p_fairness_0;
    @(posedge clk) req[0] |=> ##[1:5] grant[0];
  endproperty

  assert property(p_fairness_0);

endmodule

module tb;
  logic clk = 0;
  logic [1:0] req = 0, grant = 0;
  always #5 clk = ~clk;

  arbiter_assertion dut(clk, req, grant);

  initial begin
    #10 req[0] = 1;
    #40 grant[0] = 1; // After 4 cycles → Pass
    #10 $finish;
  end
endmodule


//Output:
# (No assertion failure — Passed)

    

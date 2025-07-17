module arbiter_assertion(input logic clk, input logic [1:0] req, input logic [1:0] grant);

  // If req[0] is high, it must be granted within 5 cycles
  property p_fairness_0;
    @(posedge clk) req[0] |=> ##[1:5] grant[0];
  endproperty

  assert property(p_fairness_0);

endmodule

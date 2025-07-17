module burst_assertion(input logic clk, input logic start, input logic [3:0] data);

  // After 'start', there should be 4 valid data cycles with data > 0
  property p_burst;
    @(posedge clk) start |=> (data > 0)[*4];
  endproperty

  assert property(p_burst);

endmodule

module reset_assertion(input logic clk, input logic rst, input logic ready);

  // ready should go high 2 cycles after reset is deasserted
  property p_reset_ready;
    @(posedge clk) disable iff (rst)
      $rose(!rst) |=> ##2 ready;
  endproperty

  assert property(p_reset_ready);

endmodule

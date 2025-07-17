module basic_assertions(input logic clk, input logic rst, input logic a, b);

  // Ensure that a and b are never high at the same time
  property p_exclusive;
    !(a && b);
  endproperty

  assert property (@(posedge clk) disable iff (rst) p_exclusive)
    else $error("a and b should not be high at the same time");

endmodule

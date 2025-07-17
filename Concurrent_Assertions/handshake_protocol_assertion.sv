module handshake_protocol_assertion(input logic clk, input logic req, input logic ack);

  // Once req is high, ack should come within 3 cycles
  property p_handshake;
    @(posedge clk) req |=> ##[1:3] ack;
  endproperty

  assert property(p_handshake);

endmodule

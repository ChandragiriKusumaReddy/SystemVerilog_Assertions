module handshake_protocol_assertion(input logic clk, input logic req, input logic ack);

  property p_handshake;
    @(posedge clk) req |=> ##[1:3] ack;
  endproperty

  assert property(p_handshake);

endmodule

module tb;
  logic clk = 0, req = 0, ack = 0;
  always #5 clk = ~clk;

  handshake_protocol_assertion dut(clk, req, ack);

  initial begin
    #10 req = 1;
    #10 req = 0;
    #20 ack = 1;  // Delayed beyond 3 cycles → FAIL
    #10 $finish;
  end
endmodule



//Output:
    # ** Error: handshake_protocol_assertion.sv(6): Assertion p_handshake failed

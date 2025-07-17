module burst_assertion(input logic clk, input logic start, input logic [3:0] data);

  property p_burst;
    @(posedge clk) start |=> (data > 0)[*4];
  endproperty

  assert property(p_burst);

endmodule

module tb;
  logic clk = 0, start = 0;
  logic [3:0] data = 0;
  always #5 clk = ~clk;

  burst_assertion dut(clk, start, data);

  initial begin
    #10 start = 1;
    #10 start = 0;
    data = 4; #10;
    data = 5; #10;
    data = 1; #10;
    data = 0; #10; // Violates (not > 0)
    #10 $finish;
  end
endmodule


//Output:
# ASSERT: Error: ASRT_0005 testbench.sv(7): Assertion FAILED at time: 55ns, scope: tb.dut, start-time: 15ns
    

module basic_assertions(input logic clk, input logic rst, input logic a, b);

  property p_exclusive;
    !(a && b);
  endproperty

  assert property (@(posedge clk) disable iff (rst) p_exclusive)
    else $error("Assertion Failed: a and b both high!");

endmodule

module tb;
  logic clk = 0, rst = 0, a = 0, b = 0;
  always #5 clk = ~clk;

  basic_assertions dut(clk, rst, a, b);

  initial begin
    #12 a = 1; b = 1; // Violation
    #10 a = 0; b = 1;
    #10 $finish;
  end
endmodule


//Output:
    # KERNEL: Error: testbench.sv (9): Assertion Failed: a and b both high!

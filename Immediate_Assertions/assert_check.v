module assert_check;
  logic [3:0] a, b;

  initial begin
    a = 4'd10;
    b = 4'd5;

    #5 a = 4'd3;  // Fails assertion
    #5 b = 4'd3;

    // Immediate assertion
    assert (a > b)
      else $error("Assertion failed: a is not greater than b at time %0t", $time);
  end
endmodule


//Output:
# KERNEL: Error: testbench.sv (15): Assertion failed: a is not greater than b at time 10

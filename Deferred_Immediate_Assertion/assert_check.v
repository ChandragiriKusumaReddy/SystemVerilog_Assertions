module assert_check;
  logic [3:0] a, b;

  initial begin
    a = 4'd10;
    b = 4'd5;
    #5 a = 4'd3;
    #5 b = 4'd3;

    // Deferred immediate assertion
    assert final (a > b)
      else $error("Deferred Assertion failed: a <= b at time %0t", $time);
  end
endmodule


//Output:
# KERNEL: Error: testbench.sv (12): Deferred Assertion failed: a <= b at time 10

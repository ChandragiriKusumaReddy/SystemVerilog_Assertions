//Pattern 1:
Q1.)When start goes high, done must go high exactly after 4 cycles.
Ans:
property p_start_high;
  @(posedge clk) start |-> ##4 done;
endproperty
assert property(p_start_high);
//Explanation:
// start |-> → When start is true
// ##4 done; → After 4 cycles, done must be high
// This checks that done becomes high exactly 4 cycles after start


//Pattern 2:
Q2.)When start goes high, done must go high within 4 cycles.
Ans:
property p_start_to_done;
  @(posedge clk) start |-> ##[1:4] done;
endproperty
assert property(p_start_do_done);
//Explanation:
// This checks that done becomes high within 4 cycles after start

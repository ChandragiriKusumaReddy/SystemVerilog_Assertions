// Pattern 1: One Signal Must Be High 2 Cycles After Reset Deasserts
Q1.)Write an assertion to check that ready must be high 2 clock cycles after reset is deasserted (active high sync reset).
Ans:
property p_reset_ready;
  @(posedge clk) disable iff(rst) $rose(!rst) |=> ##2 ready;
endproperty
assert property(p_reset_ready);
//Explanation:
// disable iff (reset) disables checking when reset is high
// $rose(!reset) → detects falling edge of reset (1 → 0)
// |=> ##2 ready → after 2 cycles, ready must be high


//Pattern 2: Signal Must Remain High for 3 Cycles
Q2.)Check that when valid is asserted, it must stay high for 3 consecutive cycles.
Ans:
property p_valid_stable;
  @(posedge clk) valid |-> ##1 valid ##1 valid;
endproperty
assert property(p_valid_ready);
//Explanation:
// |-> → implication operator
// This checks:
// If valid is high at time 0, then it must be high at t+1 and t+2.


//Pattern 3: Handshake Protocol (req → ack within 2 cycles)
Q3.)When req is high, ack should be asserted within 2 cycles.
Ans:
property p_handshake;
  @(posedge clk) req |-> ##[1:2] ack;
endproperty
assert property(p_handshake);
//Explanation:
// Checks ack occurs 1st or 2nd cycle after req


//Pattern 4: No Signal Glitch (No 1→0→1 in 2 cycles)
Q4.)Ensure that signal doesn't glitch from 1 to 0 back to 1 within 2 clock cycles.
Ans:
property p_no_glitch;
  @(posedge clk) signal && $past(signal) |-> !($past(signal,2) && !signal);
endproperty
assert property(p_no_glitch);
//Explanation:
// This is more advanced — uses $past() to check history of signal changes.


//Pattern 5: Only One-Hot State Allowed
Q5.)You have a 4-bit state signal. At any time, only one bit should be high (one-hot encoded state).
Ans:
property p_onehot;
  @(posedge clk) $onehot(state);
endproperty
assert property(p_onehot);
//Explanation:
//Built-in function $onehot checks exactly one bit is 1

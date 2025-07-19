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


//Pattern 3:Delayed Enable + Hold
Q3.)If enable goes high, data_valid should go high after exactly 3 clock cycles, and must remain high for 2 consecutive cycles.
Ans:
property p_enable_valid;
  @(posedge clk) enable |-> ##3 (data_valid && ##1 data_valid);
endproperty
assert property(p_enable_valid);
//Explanation:
// ##3 → Wait 3 cycles after enable
// (data_valid && ##1 data_valid) → Must be high in that cycle and next cycle


//Pattern 4: Forbidden Transition
Q4.)mode must not switch directly from 2'b01 to 2'b11 in one clock cycle.
Ans:
property p_mode_forbidden;
  @(posedge clk) !($past(mode) == 2'b01 && mode == 2'b11);
endproperty
assert property(p_mode_forbidden);

         or

sequence illegal_transition;
  $past(mode) == 2'b01 && mode == 2'b11;
endsequence

property p_illegal_transition;
  @(posedge clk) not illegal_transition;
endproperty
assert property(p_illegal_transition);

//Explanation:
// $past(mode) gives previous cycle’s value
// We ensure that mode never changes from 01 → 11
// Assertion passes always except when that illegal transition occurs


//Pattern 5: Trigger → Response Within [1:2] + Hold
Q5.)When trigger is high, response must go high within 1–2 cycles, and stay high at least 1 cycle.
Ans:
property p_trigger_response;
  @(posedge clk) trigger |-> ##[1:2] (response && ##1 response);
endproperty
assert property(p_trigger_response);
//Explanation:
// ##[1:2] → Allows response to go high in either 1st or 2nd cycle after trigger
// (response && ##1 response) → ensures it's high for at least 2 cycles

  

// tb.v
// Self-checking testbench for 4-bit ALU

module tb;

  reg [3:0] t_a, t_b;
  reg t_op;
  wire [3:0] t_result; // Assuming 4-bit result, we will confirm when you paste alu.v

  reg [3:0] exp_result;
  integer i, errors;

  alu DUT (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;
    
    // Test all 512 combinations of a (4 bits), b (4 bits), and op (1 bit)
    for (i = 0; i < 512; i = i + 1) begin
      t_a  = i[8:5];
      t_b  = i[4:1];
      t_op = i[0];
      #5; 

      // Compute expected result independently
      if (t_op == 1'b0)
        exp_result = t_a + t_b; // op=0 is add
      else
        exp_result = t_a - t_b; // op=1 is sub

      // Check for mismatch
      if (t_result !== exp_result) begin
        $display("FAIL at time %0t: op=%b a=%d b=%d | got=%d expected=%d",
                 $time, t_op, t_a, t_b, t_result, exp_result);
        errors = errors + 1;
      end
    end

    $write("Simulation complete. ");
    if (errors == 0)
      $display("All 512 combinations PASSED.");
    else
      $display("%0d combinations FAILED.", errors);

    $finish;
  end

endmodule
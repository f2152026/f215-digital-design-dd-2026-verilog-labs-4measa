module tb;

  reg [1:0] t_a, t_b;
  wire t_gt, t_lt, t_eq;
  
  reg exp_gt, exp_lt, exp_eq;
  integer i, errors;

  comp2 DUT (
    .A(t_a),
    .B(t_b),
    .GT(t_gt),
    .LT(t_lt),
    .EQ(t_eq)
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
    
    for (i = 0; i < 16; i = i + 1) begin
      t_a = i[3:2]; 
      t_b = i[1:0];
      #5; 

      exp_gt = (t_a > t_b);
      exp_lt = (t_a < t_b);
      exp_eq = (t_a == t_b);

      if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
        $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
                 $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
        errors = errors + 1;
      end
    end

    $write("Simulation complete. ");
    if (errors == 0)
      $display("All 16 combinations PASSED.");
    else
      $display("%0d out of 16 combinations FAILED.", errors);

    $finish;
  end

endmodule
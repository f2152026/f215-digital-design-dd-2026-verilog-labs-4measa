// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
  reg  [2:0] t_sel;
  wire [7:0] t_dout;

  integer j;

  // TODO: instantiate DUT here
  lut #(.WIDTH(8), .DEPTH(8)) DUT (
    .sel  (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // TODO: apply different input combinations
    for (j = 0; j < 8; j = j + 1) begin
      t_sel = j;
      #5;
    end
    $finish;
  end

  initial
    $monitor($time, " sel=%d | dout=%d", t_sel, t_dout); // change as required

endmodule

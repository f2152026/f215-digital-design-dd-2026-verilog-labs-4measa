module and_df (
  input a,
  input b,
  output wire y
);
  assign #5 y = a & b;
endmodule
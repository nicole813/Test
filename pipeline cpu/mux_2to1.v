module mux_2to1 ( in1, in0, out, sel );
  input in0, in1;  // input
  input sel;  // sel
  output out;  // out

  assign out = ( sel == 1'b1 ) ? in1 : in0;

endmodule
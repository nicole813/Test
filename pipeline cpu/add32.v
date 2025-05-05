//-----------------------------------------------------------------------------
// Title         : ALU Behavioral Model
//-----------------------------------------------------------------------------

module add32(a, b, result);
  input [31:0] a, b;
  output [31:0] result;

  assign result = a + b;
  /*
  always @ ( result ) begin
    $display( "(add32)%d: result = %d, a = %d, b = %d", $time/10-1, result, a, b );
  end
  */
endmodule


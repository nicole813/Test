module HiLo( clk, MulAns, Signal, Hi, Lo, rst );
  input clk, rst;
  input [5:0] Signal ;
  input [63:0] MulAns;
  output [31:0] Hi, Lo;
  
  reg [31:0] Hi, Lo;
  
  always@( posedge clk or rst ) begin
    if ( Signal == 6'b011001 ) begin
      Hi = ( rst == 1'b1 ) ? 32'b0 : MulAns[63:32];
      Lo = ( rst == 1'b1 ) ? 32'b0 : MulAns[31:0];
    end
  end
  
endmodule
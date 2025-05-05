module EXMEM( clk, pc, Muxout, RD2, wn, control_M, control_W, zero,
              out_pc, out_Muxout, out_RD2, out_wn, out_W, out_zero,
              branch, MemWrite, MemRead );


  input clk, zero ;
  input [1:0] control_W;
  input [2:0] control_M;
  input [4:0] wn;
  input [31:0] pc, Muxout, RD2;

  output out_zero, branch, MemWrite, MemRead ;
  output [1:0] out_W;
  output [4:0] out_wn;
  output [31:0] out_pc, out_Muxout, out_RD2;

  reg out_zero, branch, MemWrite, MemRead ;
  reg [1:0] out_W;
  reg [4:0] out_wn;
  reg [31:0] out_pc, out_Muxout, out_RD2 ;
  
  always @ ( posedge clk ) begin
    out_zero <= zero;
    out_pc <= pc;
    out_Muxout <= Muxout;
    out_RD2 <= RD2;
    out_wn <= wn;
    out_W <= control_W;
    branch <= control_M[2] ;
    MemWrite <= control_M[1] ;
    MemRead <= control_M[0] ;
  end

endmodule
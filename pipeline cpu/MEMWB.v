module MEMWB( clk, control_W, wn, Muxout, rd, 
               out_rd, out_Muxout, out_wn, MemtoReg, RegWrite );

  input clk;
  input [1:0] control_W;
  input [4:0] wn;
  input [31:0] Muxout, rd ;

  output MemtoReg, RegWrite;
  output [4:0] out_wn;
  output [31:0] out_rd, out_Muxout;

  reg MemtoReg, RegWrite;
  reg [4:0] out_wn;
  reg [31:0] out_rd, out_Muxout;
  
  always @ ( posedge clk ) begin
    out_rd <= rd;
    out_Muxout <= Muxout;
    out_wn <= wn;
    MemtoReg <= control_W[1];
    RegWrite <= control_W[0];
  end

endmodule
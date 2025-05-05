module IFID( clk, pc, instr, out_pc, out_instr );
  input clk;
  input [31:0] pc, instr;
  output [31:0] out_pc, out_instr;
  
  reg [31:0] out_pc, out_instr;
  
  always@( posedge clk ) begin
    out_pc <= pc;
    out_instr <= instr;
  end
  
endmodule

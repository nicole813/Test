module IDEX( clk, rt, rd, RD1, RD2, extend_signed, pc, shamt, control_E, control_M, control_W,
             out_rt, out_rd, out_RD1, out_RD2, out_extend_signal, out_pc, out_M, out_W, out_shamt,
             ALUSrc, RegDst, jr, ALUop );
  input clk;
  input [2:0] control_M;
  input [1:0] control_W;
  input [4:0] rt, rd, shamt, control_E;
  input [31:0] RD1, RD2, extend_signed, pc;
  
  output ALUSrc, RegDst, jr;
  output [1:0] out_W, ALUop;
  output [2:0] out_M;
  output [4:0] out_rt, out_rd;
  output [31:0] out_RD1, out_RD2, out_extend_signal, out_pc, out_shamt;
  
  reg ALUSrc, RegDst, jr;
  reg [1:0] out_W, ALUop;
  reg [2:0] out_M;
  reg [4:0] out_rt, out_rd;
  reg [31:0] out_RD1, out_RD2, out_extend_signal, out_pc, out_shamt;
  
  wire zero = 1'b0;
  
  always@( posedge clk ) begin
    out_rt <= rt;
    out_rd <= rd;
    out_RD1 <= RD1;
    out_RD2 <= RD2;
    out_extend_signal <= extend_signed;
    out_pc <= pc;
    out_shamt <= { {17{zero}},shamt};
    out_M <= control_M;
    out_W <= control_W;
    ALUSrc <= control_E[4];
    RegDst <= control_E[3];
    jr <= control_E[2];
    ALUop <= control_E[1:0];
    
  end
  
endmodule
/*
	Title: Sign Extend
	Author: Selene (Computer System and Architecture Lab, ICE, CYCU)
	
	Input Port
		1. immed_in: Ū�J����sign extend���
	Output Port
		1. ext_immed_out: ��X�w����sign extend���
*/
module sign_extend( immed_in, ext_immed_out, opcode );
  input[5:0] opcode;
	input[15:0] immed_in;
	output[31:0] ext_immed_out;
	wire zero = 1'b0;
	
	assign ext_immed_out = ( opcode == 6'b001100 ) ? { {16{zero}}, immed_in } : { {16{immed_in[15]}}, immed_in };
endmodule

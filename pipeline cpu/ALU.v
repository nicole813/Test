module ALU( out, signal, a, b, zero );
  input zero;
  input [2:0] signal;
  input [31:0] a, b;
  output [31:0] out;
  
  wire invertb, less;
  wire [31:0] out, cout, temp;
  wire overflow, LSB, ori_LSB;
  
  assign invertb = ( signal == 3'b110 ) ? 1'b1 :
                   ( signal == 3'b111 ) ? 1'b1 :
                                          1'b0 ;
  
  assign less = 1'b0;

  ALU_Bit_Slice U_ABS0( .out(temp[0]), .carryOut(cout[0]), .a(a[0]), .b(b[0]), .carryIn(invertb), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS1( .out(temp[1]), .carryOut(cout[1]), .a(a[1]), .b(b[1]), .carryIn(cout[0]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS2( .out(temp[2]), .carryOut(cout[2]), .a(a[2]), .b(b[2]), .carryIn(cout[1]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS3( .out(temp[3]), .carryOut(cout[3]), .a(a[3]), .b(b[3]), .carryIn(cout[2]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS4( .out(temp[4]), .carryOut(cout[4]), .a(a[4]), .b(b[4]), .carryIn(cout[3]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS5( .out(temp[5]), .carryOut(cout[5]), .a(a[5]), .b(b[5]), .carryIn(cout[4]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS6( .out(temp[6]), .carryOut(cout[6]), .a(a[6]), .b(b[6]), .carryIn(cout[5]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS7( .out(temp[7]), .carryOut(cout[7]), .a(a[7]), .b(b[7]), .carryIn(cout[6]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS8( .out(temp[8]), .carryOut(cout[8]), .a(a[8]), .b(b[8]), .carryIn(cout[7]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS9( .out(temp[9]), .carryOut(cout[9]), .a(a[9]), .b(b[9]), .carryIn(cout[8]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS10( .out(temp[10]), .carryOut(cout[10]), .a(a[10]), .b(b[10]), .carryIn(cout[9]), .signal(signal), .invertb(invertb), .less(less) );

  ALU_Bit_Slice U_ABS11( .out(temp[11]), .carryOut(cout[11]), .a(a[11]), .b(b[11]), .carryIn(cout[10]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS12( .out(temp[12]), .carryOut(cout[12]), .a(a[12]), .b(b[12]), .carryIn(cout[11]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS13( .out(temp[13]), .carryOut(cout[13]), .a(a[13]), .b(b[13]), .carryIn(cout[12]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS14( .out(temp[14]), .carryOut(cout[14]), .a(a[14]), .b(b[14]), .carryIn(cout[13]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS15( .out(temp[15]), .carryOut(cout[15]), .a(a[15]), .b(b[15]), .carryIn(cout[14]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS16( .out(temp[16]), .carryOut(cout[16]), .a(a[16]), .b(b[16]), .carryIn(cout[15]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS17( .out(temp[17]), .carryOut(cout[17]), .a(a[17]), .b(b[17]), .carryIn(cout[16]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS18( .out(temp[18]), .carryOut(cout[18]), .a(a[18]), .b(b[18]), .carryIn(cout[17]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS19( .out(temp[19]), .carryOut(cout[19]), .a(a[19]), .b(b[19]), .carryIn(cout[18]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS20( .out(temp[20]), .carryOut(cout[20]), .a(a[20]), .b(b[20]), .carryIn(cout[19]), .signal(signal), .invertb(invertb), .less(less) );

  ALU_Bit_Slice U_ABS21( .out(temp[21]), .carryOut(cout[21]), .a(a[21]), .b(b[21]), .carryIn(cout[20]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS22( .out(temp[22]), .carryOut(cout[22]), .a(a[22]), .b(b[22]), .carryIn(cout[21]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS23( .out(temp[23]), .carryOut(cout[23]), .a(a[23]), .b(b[23]), .carryIn(cout[22]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS24( .out(temp[24]), .carryOut(cout[24]), .a(a[24]), .b(b[24]), .carryIn(cout[23]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS25( .out(temp[25]), .carryOut(cout[25]), .a(a[25]), .b(b[25]), .carryIn(cout[24]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS26( .out(temp[26]), .carryOut(cout[26]), .a(a[26]), .b(b[26]), .carryIn(cout[25]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS27( .out(temp[27]), .carryOut(cout[27]), .a(a[27]), .b(b[27]), .carryIn(cout[26]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS28( .out(temp[28]), .carryOut(cout[28]), .a(a[28]), .b(b[28]), .carryIn(cout[27]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS29( .out(temp[29]), .carryOut(cout[29]), .a(a[29]), .b(b[29]), .carryIn(cout[28]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS30( .out(temp[30]), .carryOut(cout[30]), .a(a[30]), .b(b[30]), .carryIn(cout[29]), .signal(signal), .invertb(invertb), .less(less) );
  ALU_Bit_Slice U_ABS31( .out(temp[31]), .carryOut(cout[31]), .a(a[31]), .b(b[31]), .carryIn(cout[30]), .signal(signal), .invertb(invertb), .less(less) );
  
  assign zero = ( signal == 6'b110 && temp == 0 ) ? 1 : 0 ;
  
  assign out = ( signal == 6'b000 ) ? temp :
	             ( signal == 6'b001 ) ? temp :
	             ( signal == 6'b010 ) ? temp :
	             ( signal == 6'b110 ) ? temp :
	             ( signal == 6'b111 && temp[31] == 1 ) ? 1 :
	             ( signal == 6'b111 && temp[31] == 0 ) ? 0 :
                                                    32'b0;
endmodule
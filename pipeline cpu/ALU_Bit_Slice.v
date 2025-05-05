module ALU_Bit_Slice( out, carryOut, a, b, carryIn, signal, invertb, less );
  input a, b, carryIn, invertb, less;
  input [2:0] signal;
  output out, carryOut;
  
  wire AND, OR, sum, cout, temp;
  
  and( AND, a, b );
  or( OR, a, b );
  
  xor( temp, b, invertb );
  FA U_FA( .carryOut(carryOut), .sum(sum) , .a(a), .b(temp), .carryIn(carryIn) );
  
  assign out = ( signal == 3'b000 ) ? AND  :  // AND
               ( signal == 3'b001 ) ? OR   :  // OR
               ( signal == 3'b010 ) ? sum  :  // ADD
               ( signal == 3'b110 ) ? sum  :  // SUB
               ( signal == 3'b111 ) ? sum  :  // SLT
                                         1'b0 ;

  
endmodule
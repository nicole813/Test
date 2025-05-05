module FA( carryOut, sum, a, b, carryIn );
  input a, b, carryIn;
  output carryOut, sum;
  
  wire t1, t2, t3, t4;
  
  // calculate sum 
  xor( t1, a, b );
  xor( sum, t1, carryIn );
  
  // calculate carry out
  or( t2, a, b );          // a | b
  and( t3, t2, carryIn );  // ( a | b ) & carryIn
  and( t4, a, b );         // a & b
  or( carryOut, t3, t4 );  // ( ( a | b ) & carryIn ) | ( a & b )
    
endmodule
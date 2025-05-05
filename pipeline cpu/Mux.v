module Mux( out, MuxtoMem, ALU, Hi, Lo, SHT );
  input [31:0] ALU, Hi, Lo, SHT;
  input [1:0] MuxtoMem;
  output [31:0] out;
  
  wire [31:0] out;
  
  assign out = ( MuxtoMem == 2'b00 ) ? ALU  : 
               ( MuxtoMem == 2'b01 ) ? Hi  : 
               ( MuxtoMem == 2'b10 ) ? Lo  : 
               ( MuxtoMem == 2'b11 ) ? SHT  : 
                                       32'b0;
                       
endmodule
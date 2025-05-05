module Multiplier( clk, dataA, dataB, signal, ALUop, out, rst );
  input clk, rst;
  input [1:0] ALUop ;
  input [5:0] signal;
  input [31:0] dataA, dataB;
  output [63:0] out;
  reg [63:0] out;
  
  reg [31:0] MCND;
  reg [32:0] product, MPY;
  reg [64:0] temp;
  
  always@( signal )
  begin
    MCND = ( signal == 6'b011001 ) ? dataA : 32'b0;
  end
  
  always@( signal, ALUop )
  begin
    MPY = ( signal == 6'b011001 && ALUop == 2'b11 ) ? dataB : 32'b0;
  end
  
  always@( posedge clk or rst )
  begin
    if ( rst == 1'b1 )
    begin
      temp <= 65'b0;
      product <= 33'b0;
    end
    else
    begin
      if ( signal == 6'b011001 && ALUop == 2'b11 )
      begin
        if ( MPY[0] == 1'b1 ) 
        begin
          product = product + MCND;
          temp[64:32] = product;
        end 

        temp <= temp >> 1;
        MPY <= MPY >> 1;
        product <= product >> 1;
      end

    end

  end

  always@( temp )
  begin
    out <= temp[63:0];
  end
  
endmodule
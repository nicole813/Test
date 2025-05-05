//-----------------------------------------------------------------------------
// Title         : 2-1 multiplexer
//-----------------------------------------------------------------------------

module mux2( sel, a, b, y );
    parameter bitwidth=32;
    input sel;
    input  [bitwidth-1:0] a, b;
    output [bitwidth-1:0] y;
    
    reg [bitwidth-1:0] y;

    
    always@( sel, a,  b ) begin
      if (sel == 1)
        y <= b ;
      else if (sel == 0)
        y <= a ;
      else
        y <= a ;
    end
    /*
    always@( sel ) begin
      $display( "(mux2)-sel %d sel = %d, a = %d, b = %d, y = %d", $time/10-1, sel, a, b, y );  
    end
        
    always@( a ) begin
      $display( "(mux2)-a   %d sel = %d, a = %d, b = %d, y = %d", $time/10-1, sel, a, b, y );
    end
        
    always@( b ) begin
      $display( "(mux2)-b   %d sel = %d, a = %d, b = %d, y = %d", $time/10-1, sel, a, b, y );
    end
      
    always@( y ) begin
      $display( "(mux2)-y   %d sel = %d, a = %d, b = %d, y = %d", $time/10-1, sel, a, b, y );
    end
    */
endmodule

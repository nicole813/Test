/*
	Title:	ALU Control Unit
	Author: Garfield (Computer System and Architecture Lab, ICE, CYCU)
	Input Port
		1. ALUOp: 控制alu是要用+還是-或是其他指令
		2. Funct: 如果是其他指令則用這邊6碼判斷
	Output Port
		1. ALUOperation: 最後解碼完成之指令
*/

module alu_ctl( clk, ALUOp, Funct, ALUOperation, MUXOperation, Signal, en_reg );
    input clk;
    input [1:0] ALUOp;
    input [5:0] Funct;
    output [2:0] ALUOperation ;
    output [1:0] MUXOperation ;
    output en_reg;
    output [5:0] Signal;
    reg    [2:0] ALUOperation;
    reg    [1:0] MUXOperation;
    reg    [5:0] counter, temp;
    reg en_reg;

    // symbolic constants for instruction function code
    parameter F_add = 6'd32;
    parameter F_sub = 6'd34;
    parameter F_and = 6'd36;
    parameter F_or  = 6'd37;
    parameter F_slt = 6'd42;
    parameter F_sll = 6'd0;
    parameter F_multu = 6'd25;
    parameter F_hi = 6'd16;
    parameter F_lo = 6'd18;
    parameter F_jr = 6'd8;

    // symbolic constants for ALU Operations
    parameter ALU_add = 3'b010;
    parameter ALU_sub = 3'b110;
    parameter ALU_and = 3'b000;
    parameter ALU_or  = 3'b001;
    parameter ALU_slt = 3'b111;

    always @( ALUOp or Funct )
    begin
      if ( ALUOp == 2'b11 ) temp = F_multu ;
      else temp = Funct ;
      
        case (ALUOp) 
            2'b00 : 
            begin
              ALUOperation = ALU_add;
              MUXOperation = 2'b00 ;
            end
            2'b01 : 
            begin
              ALUOperation = ALU_sub;
              MUXOperation = 2'b00 ;
            end
            2'b10 : case (Funct) 
                        F_add : 
                        begin
                          ALUOperation = ALU_add;
                          MUXOperation = 2'b00 ;
                        end
                        F_sub : 
                        begin
                          ALUOperation = ALU_sub;
                          MUXOperation = 2'b00 ;
                        end
                        F_and :
                        begin 
                          ALUOperation = ALU_and;
                          MUXOperation = 2'b00 ;
                        end
                        F_or  : 
                        begin
                          ALUOperation = ALU_or;
                          MUXOperation = 2'b00 ;
                        end
                        F_slt : 
                        begin
                          ALUOperation = ALU_slt;
                          MUXOperation = 2'b00 ;
                        end
                        F_hi : 
                        begin
                          ALUOperation = 3'bxxx;
                          MUXOperation = 2'b01 ;
                        end
                        F_lo : 
                        begin
                          ALUOperation = 3'bxxx;
                          MUXOperation = 2'b10 ;
                        end
                        F_sll : 
                        begin
                          $display( "(alu_ctl) into sll" ) ;
                          ALUOperation = 3'bxxx;
                          MUXOperation = 2'b11 ;
                        end
                        default 
                        begin
                          ALUOperation = 3'bxxx;
                          MUXOperation = 2'b00 ;
                        end
                    endcase
            2'b11 :  // nop
            begin
              ALUOperation = 3'bxxx;
              MUXOperation = 2'b01 ;
            end
            default 
            begin
              ALUOperation = 3'bxxx;
              MUXOperation = 2'bxx ;
            end
        endcase

    end
    
    always@( Funct )
    begin
      if ( Funct == F_multu )
      begin
        counter = 0 ;
        //en_reg <= 0;
      end
  
    end
    
    always@( posedge clk )
    begin
      
      if ( ALUOp == 2'b11 )
        temp = F_multu ;
      else
        temp = Funct ;
      
      if ( temp == F_multu )
      begin
        counter = counter + 1 ;
        if ( counter == 32 )
        begin
          //temp = 6'b111111 ; // Open HiLo reg for Mux
          //en_reg <= 1;
        end
      end
  
    end

    assign Signal = temp;

    
endmodule



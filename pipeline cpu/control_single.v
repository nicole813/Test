/*
	Title: MIPS Single-Cycle Control Unit
	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)
	
	Input Port
		1. opcode: ???????????????????
	Input Port
		1. RegDst: ??RFMUX
		2. ALUSrc: ??ALUMUX
		3. MemtoReg: ??WRMUX
		4. RegWrite: ??????????
		5. MemRead:  ??????????
		6. MemWrite: ??????????
		7. Branch: ?ALU???zero???AND????PCMUX
		8. ALUOp: ???ALU Control
*/
module control_single( instr, control_E, control_M, control_W, Jump );
    input[31:0] instr;
    
    output [4:0] control_E;
    output [2:0] control_M;
    output [1:0] control_W;
    output Jump;
    
    wire[5:0] opcode, Funct;
    reg RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, JRop;
    reg[1:0] ALUOp;
    reg [4:0] control_E;
    reg [2:0] control_M;
    reg [1:0] control_W;
    
    // reg RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump;
    // reg[1:0] ALUOp;

    parameter R_FORMAT = 6'd0;
    parameter LW = 6'd35;
    parameter SW = 6'd43;
    parameter BEQ = 6'd4;
    parameter ANDI = 6'd12;
    parameter J = 6'd2;
    parameter JR = 6'd8;
    
    assign opcode = instr[31:26] ;
    assign Funct = instr[5:0] ;

    always @( opcode, Funct ) begin
        case ( opcode )
          R_FORMAT : 
          begin
            if ( Funct == JR ) begin
				      //$display("(control_single)  into JR");
              RegDst = 1'bx; ALUSrc = 1'bx; MemtoReg = 1'bx; RegWrite = 1'b0; MemRead = 1'b0; 
				      MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; JRop = 1'b1;
				    end
            else if ( instr == 32'b0 ) begin
				      //$display("(control_single)  into nop");
              RegDst = 1'b0; ALUSrc = 1'b0; MemtoReg = 1'b0; RegWrite = 1'b0; MemRead = 1'b0; 
				      MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b11; JRop = 1'b0;
				    end
				    else begin
				      //$display("(control_single)  into R-type");
				      RegDst = 1'b1; ALUSrc = 1'b0; MemtoReg = 1'b1; RegWrite = 1'b1; MemRead = 1'b0; 
				      MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b10; JRop = 1'b0;
				    end
				    
          end
          LW :
          begin
				    //$display("(control_single)  into LW");
            RegDst = 1'b0; ALUSrc = 1'b1; MemtoReg = 1'b0; RegWrite = 1'b1; MemRead = 1'b1; 
				    MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; JRop = 1'b0;
          end
          SW :
          begin
				    //$display("(control_single)  into SW");
            RegDst = 1'bx; ALUSrc = 1'b1; MemtoReg = 1'bx; RegWrite = 1'b0; MemRead = 1'b0; 
				    MemWrite = 1'b1; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; JRop = 1'b0;
          end
          BEQ :
          begin
				    //$display("(control_single)  into BEQ");
            RegDst = 1'bx; ALUSrc = 1'b0; MemtoReg = 1'bx; RegWrite = 1'b0; MemRead = 1'b0; 
				    MemWrite = 1'b0; Branch = 1'b1; Jump = 1'b0; ALUOp = 2'b01; JRop = 1'b0;
          end
          ANDI :
          begin
				    //$display("(control_single)  into ANDI");
            RegDst = 1'b0; ALUSrc = 1'b1; MemtoReg = 1'b0; RegWrite = 1'b1; MemRead = 1'b0; 
			     	MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; JRop = 1'b0;
          end
          J :
	        begin
				    //$display("(control_single)  into J");
	          RegDst = 1'bx; ALUSrc = 1'b0; MemtoReg = 1'bx; RegWrite = 1'b0; MemRead = 1'b0; 
				    MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b1; ALUOp = 2'b01; JRop = 1'b0;
	        end
          default
          begin
				    $display("control_single unimplemented opcode %d", opcode);
				    RegDst=1'bx; ALUSrc=1'bx; MemtoReg=1'bx; RegWrite=1'bx; MemRead=1'bx; 
				    MemWrite=1'bx; Branch=1'bx; Jump = 1'bx; ALUOp = 2'bxx; JRop= 1'bx;
          end

        endcase
        
        control_E = { ALUSrc, RegDst, JRop, ALUOp };// ALUSrc[4], RegDst[3], Jump[2], ALUOp[1:0]
        control_M = { Branch, MemWrite, MemRead };// Branch[3], MemWrite[1], MemRead[0]
        control_W = { MemtoReg, RegWrite };// MemtoReg[1], RegWrite[0]
    end

endmodule

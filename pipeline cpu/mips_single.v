//	Title: MIPS Single-Cycle Processor
//	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)
module mips_single( clk, rst );
    input clk, rst;
	
    // instruction bus
    wire[31:0] instr;
	
    // break out important fields from instruction
    wire [5:0] opcode, funct, Signal;
    wire [4:0] rs, rt, rd, shamt;
    wire [15:0] immed;
    wire [31:0] extend_immed, b_offset;
    wire [25:0] jumpoffset;
	
    // datapath signals
    wire [4:0] rfile_wn;
    wire [31:0] rfile_rd1, rfile_rd2, rfile_wd, alu_b, alu_out, b_tgt, pc_next, pc_next2, out,
                pc, pc_incr, dmem_rdata, jump_addr, branch_addr, sll_out, hi_out, lo_out;
    wire [63:0] multu_out;

    // control signals
    wire RegWrite, Branch, PCSrc, RegDst, MemtoReg, MemRead, MemWrite, ALUSrc, Zero, Jump, JR;
    wire [1:0] ALUOp, MuxtoMem;
    wire [2:0] Operation;
    wire enregWire;
    reg en_reg;
	
	  wire [31:0] out_pc, pc_ex, out_instr, RD1_next, RD2_next, RD2_next2, wd, pc_mem, 
	              extend_immed_next, Muxout_next, Muxout_next2, shamt_next;
	  wire [4:0] rt_next, rd_next, wn_next, wn_next2;
    wire [4:0] control_E;
    wire [2:0] control_M, M_next;
    wire [1:0] control_W, W_next, W_next2;
    wire Zero_next;
	
    assign opcode = out_instr[31:26];
    assign rs = out_instr[25:21];
    assign rt = out_instr[20:16];
    assign rd = out_instr[15:11];
    assign shamt = out_instr[10:6];
    assign funct = out_instr[5:0];
    assign immed = out_instr[15:0];
    assign jumpoffset = out_instr[25:0];
    
    initial begin
      en_reg = 1 ;
    end
    
    always @ ( enregWire ) begin
      en_reg <= enregWire ;
    end
    /*
    always @ ( out_instr ) begin
      $display( "instr: %b", out_instr ) ;
      $display( "       %d %d %d %d\n", opcode, rs, rt, immed ) ;
    end
    */
    
    // branch offset shifter
    assign b_offset = extend_immed_next << 2;
	
    // jump offset shifter & concatenation
    assign jump_addr = { pc_incr[31:28], jumpoffset <<2 };
    
    // module instantiations
	
    reg32 PC( .clk(clk), .rst(rst), .en_reg(en_reg), .d_in(pc_next2), .d_out(pc) );
    // sign-extender
    sign_extend SignExt( .immed_in(immed), .ext_immed_out(extend_immed), .opcode(opcode) );
	
    add32 PCADD( .a(pc), .b(32'd4), .result(pc_incr) );

    add32 BRADD( .a(pc_ex), .b(b_offset), .result(b_tgt) );

    ALU alu( .signal(Operation), .a(RD1_next), .b(alu_b), .out(alu_out), .zero(Zero) );

    and BR_AND(PCSrc, Zero_next, Branch);

    mux2 #(5) RFMUX( .sel(RegDst), .a(rt_next), .b(rd_next), .y(rfile_wn) );
    
    mux2 #(32) PCMUX( .sel(PCSrc), .a(pc_incr), .b(pc_mem), .y(branch_addr) );
	
    mux2 #(32) JMUX( .sel(Jump), .a(branch_addr), .b(jump_addr), .y(pc_next) );
    
    mux2 #(32) JRMUX( .sel(JR), .a(pc_next), .b(RD1_next), .y(pc_next2) );
	
    mux2 #(32) ALUMUX( .sel(ALUSrc), .a(RD2_next), .b(extend_immed_next), .y(alu_b) );

    mux2 #(32) WRMUX( .sel(MemtoReg), .a(wd), .b(Muxout_next2), .y(rfile_wd) );

    control_single CTL(.instr(out_instr), .control_E(control_E), .control_M(control_M), .control_W(control_W), .Jump(Jump) );

    alu_ctl ALUCTL( .clk(clk), .ALUOp(ALUOp), .Funct(extend_immed_next[5:0]), .ALUOperation(Operation), .MUXOperation(MuxtoMem), .Signal(Signal), .en_reg(enregWire) );
	

    reg_file RegFile( .clk(clk), .RegWrite(RegWrite), .RN1(rs), .RN2(rt), .WN(wn_next2), 
					            .WD(rfile_wd), .RD1(rfile_rd1), .RD2(rfile_rd2) );

    memory InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr) );

    memory DatMem( .clk(clk), .MemRead(MemRead), .MemWrite(MemWrite), .wd(RD2_next2), 
                   .addr(Muxout_next), .rd(dmem_rdata) );  

    Multiplier multiplier( .clk(clk), .dataA(RD1_next), .dataB(alu_b), .signal(Signal), .ALUop(ALUOp), .out(multu_out), .rst(rst) );				   
    Shifter shifter( .out(sll_out), .dataA(RD2_next), .dataB(shamt_next), .rst(rst), .signal(Signal) );
    HiLo hilo( .clk(clk), .MulAns(multu_out), .Signal(Signal), .Hi(hi_out), .Lo(lo_out), .rst(rst) );
    Mux mux( .out(out), .MuxtoMem(MuxtoMem), .ALU(alu_out), .Hi(hi_out), .Lo(lo_out), .SHT(sll_out) );
    
    IFID ifid( .clk(clk), .pc(pc_incr), .instr(instr), .out_pc( out_pc ), .out_instr( out_instr ) );
    
    IDEX idex( .clk(clk), .rt(rt), .rd(rd), .RD1(rfile_rd1), .RD2(rfile_rd2), .extend_signed(extend_immed), .pc(out_pc), .shamt( shamt ),
               .control_E(control_E), .control_M(control_M), .control_W(control_W),
               .out_rt(rt_next), .out_rd(rd_next), .out_RD1(RD1_next), .out_RD2(RD2_next), .out_extend_signal(extend_immed_next),
               .out_pc(pc_ex), .out_M(M_next), .out_W(W_next), .out_shamt(shamt_next),
               .ALUSrc(ALUSrc), .RegDst(RegDst), .jr(JR), .ALUop(ALUOp) );
               
    EXMEM exmem( .clk(clk), .pc(b_tgt), .Muxout(out), .RD2(RD2_next), .wn(rfile_wn), .control_M(M_next), .control_W(W_next), .zero(Zero),
                 .out_pc(pc_mem), .out_Muxout(Muxout_next), .out_RD2(RD2_next2), .out_wn(wn_next), .out_W(W_next2), .out_zero(Zero_next),
                 .branch(Branch), .MemWrite(MemWrite), .MemRead(MemRead) );
                 
    MEMWB memwb( .clk(clk), .control_W(W_next2), .wn(wn_next), .Muxout(Muxout_next), .rd(dmem_rdata), 
                 .out_rd(wd), .out_Muxout(Muxout_next2), .out_wn(wn_next2), .MemtoReg(MemtoReg), .RegWrite(RegWrite) );
    
endmodule
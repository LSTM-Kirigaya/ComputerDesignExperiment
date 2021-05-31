module controller #( 
    /*
        field of all one bit signal
    */
    parameter T          = 1'b1,
    parameter F          = 1'b0,
    /*
        field of use_stage
        0 : be used in ID
        1 : be used in EX
    */
    parameter ID = 1'b0,
    parameter EX = 1'b1,
    /*
        LS_bit field
        value to tell the difference between word, half word and btye
    */
    parameter NONE       = 2'b00,
    parameter WORD       = 2'b01,
    parameter HALF       = 2'b10,
    parameter BYTE       = 2'b11,    
    /*
        Branch field
        tag to distinguish Branch
    */
    parameter BEQ        = 4'b0000,              // branch equal
    parameter BNE        = 4'b0001,              // branch not equal 
    parameter BGEZ       = 4'b0010,              // branch greater than or equal to zero
    parameter BGTZ       = 4'b0011,              // branch greater than zero
    parameter BLEZ       = 4'b0100,              // branch less than or equal to zero
    parameter BLTZ       = 4'b0101,              // branch less than zero
    parameter BGEZAL     = 4'b0110,              // branch greater than or equal to zero and link
    parameter BLTZAL     = 4'b0111,              // branch less than zero and link
    parameter NO_BRANCH  = 4'b1000,              // no branch
    /*
        RegDst field
        tag to decide which register may be updated
    */
    parameter RT         = 3'b000,              // to GPR[rt]
    parameter RD         = 3'b001,              // to GPR[rd]
    parameter RA         = 3'b010,              // to GPR[31]
    parameter HI         = 3'b011,              // to GPR[32]
    parameter LO         = 3'b100,              // to GPR[33]
    parameter PROD       = 3'b101,              // to HI and LO 
    /*
        DataDst field
        tag to decide what may be wirtten to regfile
    */
    parameter ALU_OUT    = 3'b000,
    parameter PC_ADD_OUT = 3'b001,
    parameter HIGH_OUT   = 3'b010,
    parameter LOW_OUT    = 3'b011,
    parameter CP0_OUT    = 3'b100, 

    /*
        ALUOp field
        tag to decide which operation will be done in alu
    */
    parameter USE_R_TYPE = 4'b0000,
    parameter USE_ADD    = 4'b0001,
    parameter USE_ADDU   = 4'b0010,
    parameter USE_SUB    = 4'b0011,
    parameter USE_SUBU   = 4'b0100,
    parameter USE_SLT    = 4'b0101,
    parameter USE_SLTU   = 4'b0110,
    parameter USE_AND    = 4'b0111,
    parameter USE_OR     = 4'b1000,
    parameter USE_NOR    = 4'b1001,
    parameter USE_XOR    = 4'b1010,
    parameter USE_LUI    = 4'b1011,

    /*
        field of ExcCode
    */
    parameter NO_EXC     = 4'b0000
    // TODO : finish interface with cp0
)(
    input      [ 5: 0] opcode,
    input      [ 4: 0] rs,
    input      [ 4: 0] rt,
    input      [ 5: 0] funct,
    output reg         use_stage,
    output reg [ 1: 0] LS_bit,
    output reg [ 2: 0] RegDst,
    output reg [ 2: 0] DataDst,
    output reg         MemtoReg,    
    output reg [ 3: 0] ALUOp,
    output reg         MemWrite,
    output reg         ALUSrc,
    output reg         ShamtSrc,
    output reg         RegWrite,
    output reg         Ext_op,                      // 1 : signed ext  0 : unsigned ext
    output reg [ 3: 0] ExcCode,
    output reg [ 3: 0] Branch,
    output reg         Jump,
    output reg         Jr
);
    /*
        opcode field
    */
    parameter opcode_is_RType  = 6'b000000;

    // conditional transfer
    parameter opcode_is_BEQ    = 6'b000100;
    parameter opcode_is_BNE    = 6'b000101;
    parameter opcode_is_BGTZ   = 6'b000111;
    parameter opcode_is_BLEZ   = 6'b000110;
    parameter opcode_is_REGIMM = 6'b000001;
    // when   opcode_is_REGIMM, rt
    parameter rt_is_BGEZ       = 5'b00001;
    parameter rt_is_BLTZ       = 5'b00000;
    parameter rt_is_BGEZAL     = 5'b10001;
    parameter rt_is_BLTZAL     = 5'b10000;   

    // I type R op
    parameter opcode_is_ADDI   = 6'b001000;
    parameter opcode_is_ADDIU  = 6'b001001;
    parameter opcode_is_SLTI   = 6'b001010;
    parameter opcode_is_SLTIU  = 6'b001011;
    parameter opcode_is_ANDI   = 6'b001100;
    parameter opcode_is_LUI    = 6'b001111;
    parameter opcode_is_ORI    = 6'b001101;
    parameter opcode_is_XORI   = 6'b001110;

    // load and save
    parameter opcode_is_LW     = 6'b100011;
    parameter opcode_is_LH     = 6'b100001;
    parameter opcode_is_LHU    = 6'b100101;
    parameter opcode_is_LB     = 6'b100000;
    parameter opcode_is_LBU    = 6'b100100;
    parameter opcode_is_SW     = 6'b101011;
    parameter opcode_is_SH     = 6'b101001;
    parameter opcode_is_SB     = 6'b101000;

    // J Type
    parameter opcode_is_J      = 6'b000010;
    parameter opcode_is_JAL    = 6'b000011;

    // self trap
    parameter opcode_is_COP0   = 6'b010000;
    // COP0 field
    parameter rs_is_MFC0       = 5'b00000;
    parameter rs_is_MTC0       = 5'b00100;
    parameter funct_is_ERET    = 6'b011000;     

    /*
        funct code field
    */
    parameter funct_is_MULT    = 6'b011000;
    parameter funct_is_MULTU   = 6'b011001;
    parameter funct_is_DIV     = 6'b011010;
    parameter funct_is_DIVU    = 6'b011011;
    parameter funct_is_JR      = 6'b001000;             // PC ← GPR[rs]                               rd :       data :                                       
    parameter funct_is_SLLV    = 6'b000100;             // GPR[rd] ← GPR[rt] << GPR[rs] (logical)     rd : rd      data : alu                             
    parameter funct_is_SRLV    = 6'b000110;             // GPR[rd] ← GPR[rt] >> GPR[rs] (logical)     rd : rd      data : alu                          
    parameter funct_is_SRAV    = 6'b000111;             // GPR[rd] ← GPR[rt] >> GPR[rs] (arithmetic)  rd : rd      data : alu                             
    parameter funct_is_MFHI    = 6'b010000;             // GPR[rd] ← HI                               rd : rd      data : high_out
    parameter funct_is_MFLO    = 6'b010010;             // GPR[rd] ← LO                               rd : rd      data : low_out   
    parameter funct_is_MTHI    = 6'b010001;             // HI ← GPR[rs]                               rd : 32      data : alu
    parameter funct_is_MTLO    = 6'b010011;             // LO ← GPR[rs]                               rd : 33      data : alu
    // MTHI & MTLO can be seen as HI ← alu_out ← GPR[rs]

    `define SIGNAL {use_stage, LS_bit, RegDst, DataDst, MemtoReg, ALUOp, MemWrite, ALUSrc, ShamtSrc, RegWrite, Ext_op, ExcCode, Branch, Jump, Jr}

    always @(*) begin
        case (opcode)
            opcode_is_RType : begin
                case (funct) 
                    funct_is_MULT  : `SIGNAL = {EX, NONE, PROD, ALU_OUT , F, USE_R_TYPE, F, F, F, T, F, NO_EXC, NO_BRANCH, F, F};
                    funct_is_MULTU : `SIGNAL = {EX, NONE, PROD, ALU_OUT , F, USE_R_TYPE, F, F, F, T, F, NO_EXC, NO_BRANCH, F, F};
                    funct_is_DIV   : `SIGNAL = {EX, NONE, PROD, ALU_OUT , F, USE_R_TYPE, F, F, F, T, F, NO_EXC, NO_BRANCH, F, F};
                    funct_is_DIVU  : `SIGNAL = {EX, NONE, PROD, ALU_OUT , F, USE_R_TYPE, F, F, F, T, F, NO_EXC, NO_BRANCH, F, F};
                    funct_is_JR    : `SIGNAL = {ID, NONE, RD  , ALU_OUT , F, USE_R_TYPE, F, F, F, F, F, NO_EXC, NO_BRANCH, F, T};
                    funct_is_SLLV  : `SIGNAL = {EX, NONE, RD  , ALU_OUT , F, USE_R_TYPE, F, F, T, T, F, NO_EXC, NO_BRANCH, F, F};
                    funct_is_SRLV  : `SIGNAL = {EX, NONE, RD  , ALU_OUT , F, USE_R_TYPE, F, F, T, T, F, NO_EXC, NO_BRANCH, F, F};
                    funct_is_SRAV  : `SIGNAL = {EX, NONE, RD  , ALU_OUT , F, USE_R_TYPE, F, F, T, T, F, NO_EXC, NO_BRANCH, F, F};
                    funct_is_MFHI  : `SIGNAL = {EX, NONE, RD  , HIGH_OUT, F, USE_R_TYPE, F, F, F, T, F, NO_EXC, NO_BRANCH, F, F};
                    funct_is_MFLO  : `SIGNAL = {EX, NONE, RD  , LOW_OUT , F, USE_R_TYPE, F, F, F, T, F, NO_EXC, NO_BRANCH, F, F};
                    funct_is_MTHI  : `SIGNAL = {EX, NONE, HI  , ALU_OUT , F, USE_R_TYPE, F, F, F, T, F, NO_EXC, NO_BRANCH, F, F};
                    funct_is_MTLO  : `SIGNAL = {EX, NONE, LO  , ALU_OUT , F, USE_R_TYPE, F, F, F, T, F, NO_EXC, NO_BRANCH, F, F};
                    default        : `SIGNAL = {EX, NONE, RD  , ALU_OUT , F, USE_R_TYPE, F, F, F, T, F, NO_EXC, NO_BRANCH, F, F};
                endcase
            end
            opcode_is_BEQ    : `SIGNAL = {ID, NONE, RD, ALU_OUT, F, USE_R_TYPE, F, F, F, F, T, NO_EXC, BEQ , F, F};
            opcode_is_BNE    : `SIGNAL = {ID, NONE, RD, ALU_OUT, F, USE_R_TYPE, F, F, F, F, T, NO_EXC, BNE , F, F};
            opcode_is_BGTZ   : `SIGNAL = {ID, NONE, RD, ALU_OUT, F, USE_R_TYPE, F, F, F, F, T, NO_EXC, BGTZ, F, F};
            opcode_is_BLEZ   : `SIGNAL = {ID, NONE, RD, ALU_OUT, F, USE_R_TYPE, F, F, F, F, T, NO_EXC, BLEZ, F, F};
            opcode_is_REGIMM : begin
                case (rt)
                    rt_is_BGEZ   : `SIGNAL = {ID, NONE, RD, ALU_OUT   , F, USE_R_TYPE, F, F, F, F, T, NO_EXC, BGEZ  , F, F};
                    rt_is_BLTZ   : `SIGNAL = {ID, NONE, RD, ALU_OUT   , F, USE_R_TYPE, F, F, F, F, T, NO_EXC, BLTZ  , F, F};
                    rt_is_BGEZAL : `SIGNAL = {ID, NONE, RA, PC_ADD_OUT, F, USE_R_TYPE, F, F, F, T, T, NO_EXC, BGEZAL, F, F};
                    rt_is_BLTZAL : `SIGNAL = {ID, NONE, RA, PC_ADD_OUT, F, USE_R_TYPE, F, F, F, T, T, NO_EXC, BLTZAL, F, F}; 
                endcase
            end

            opcode_is_ADDI   : `SIGNAL = {EX, NONE, RT, ALU_OUT, F, USE_ADD , F, T, F, T, T, NO_EXC, NO_BRANCH, F, F};
            opcode_is_ADDIU  : `SIGNAL = {EX, NONE, RT, ALU_OUT, F, USE_ADDU, F, T, F, T, T, NO_EXC, NO_BRANCH, F, F};
            opcode_is_SLTI   : `SIGNAL = {EX, NONE, RT, ALU_OUT, F, USE_SLT , F, T, F, T, T, NO_EXC, NO_BRANCH, F, F};
            opcode_is_SLTIU  : `SIGNAL = {EX, NONE, RT, ALU_OUT, F, USE_SLTU, F, T, F, T, T, NO_EXC, NO_BRANCH, F, F};
            opcode_is_ANDI   : `SIGNAL = {EX, NONE, RT, ALU_OUT, F, USE_AND , F, T, F, T, F, NO_EXC, NO_BRANCH, F, F};
            opcode_is_ORI    : `SIGNAL = {EX, NONE, RT, ALU_OUT, F, USE_OR  , F, T, F, T, F, NO_EXC, NO_BRANCH, F, F};
            opcode_is_XORI   : `SIGNAL = {EX, NONE, RT, ALU_OUT, F, USE_XOR , F, T, F, T, F, NO_EXC, NO_BRANCH, F, F};        
            opcode_is_LUI    : `SIGNAL = {EX, NONE, RT, ALU_OUT, F, USE_LUI , F, T, F, T, F, NO_EXC, NO_BRANCH, F, F};

            opcode_is_LW     : `SIGNAL = {EX, WORD, RT, ALU_OUT, T, USE_ADD , F, T, F, T, T, NO_EXC, NO_BRANCH, F, F};
            opcode_is_LH     : `SIGNAL = {EX, HALF, RT, ALU_OUT, T, USE_ADD , F, T, F, T, T, NO_EXC, NO_BRANCH, F, F};        
            opcode_is_LHU    : `SIGNAL = {EX, HALF, RT, ALU_OUT, T, USE_ADD , F, T, F, T, F, NO_EXC, NO_BRANCH, F, F};
            opcode_is_LB     : `SIGNAL = {EX, BYTE, RT, ALU_OUT, T, USE_ADD , F, T, F, T, T, NO_EXC, NO_BRANCH, F, F};
            opcode_is_LBU    : `SIGNAL = {EX, BYTE, RT, ALU_OUT, T, USE_ADD , F, T, F, T, F, NO_EXC, NO_BRANCH, F, F};
            opcode_is_SW     : `SIGNAL = {EX, WORD, RT, ALU_OUT, F, USE_ADD , T, T, F, F, T, NO_EXC, NO_BRANCH, F, F};
            opcode_is_SH     : `SIGNAL = {EX, HALF, RT, ALU_OUT, F, USE_ADD , T, T, F, F, T, NO_EXC, NO_BRANCH, F, F};
            opcode_is_SB     : `SIGNAL = {EX, BYTE, RT, ALU_OUT, F, USE_ADD , T, T, F, F, T, NO_EXC, NO_BRANCH, F, F};

            opcode_is_J      : `SIGNAL = {ID, NONE, RD, ALU_OUT   , F, USE_ADD , F, T, F, F, F, NO_EXC, NO_BRANCH, T, F};
            opcode_is_JAL    : `SIGNAL = {ID, NONE, RA, PC_ADD_OUT, F, USE_ADD , F, T, F, T, F, NO_EXC, NO_BRANCH, T, F};
        
            opcode_is_COP0 : begin
                case (rs)
                    // TODO : finish the signal, the completed SIGNAL is incorrect
                    rs_is_MFC0 : `SIGNAL = {ID, NONE, RA, PC_ADD_OUT, F, USE_ADD , F, T, F, T, F, NO_EXC, NO_BRANCH, T, F};
                    rs_is_MTC0 : `SIGNAL = {ID, NONE, RA, PC_ADD_OUT, F, USE_ADD , F, T, F, T, F, NO_EXC, NO_BRANCH, T, F};
                    default : begin
                        if (funct == funct_is_ERET)
                            `SIGNAL = {ID, NONE, RA, PC_ADD_OUT, F, USE_ADD , F, T, F, T, F, NO_EXC, NO_BRANCH, T, F};
                    end
                endcase
            end
        endcase
    end


endmodule //controller
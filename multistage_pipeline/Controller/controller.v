module controller(
    opcode, 
    funct,
    LS_bit,
    RegDst, 
    Branch, 
    MemtoReg, 
    ALUOp, 
    MemWrite, 
    ALUSrc, 
    RegWrite, 
    Jump, 
    Ext_op, 
    PctoReg,
    JR
    );

    input      [ 5: 0] opcode;         // 6-bit opcode, which is instr[31:26]         
    input      [ 5: 0] funct;

    // outputs are all signals
    output reg [ 1: 0] LS_bit;          // 00 : word         01 : half word   10 : byte
    output reg         RegDst;   
    output reg [ 1: 0] Branch;          // 00 : not branch   01 : beq         10 : bne
    output reg         MemtoReg;
    output reg [ 3: 0] ALUOp;
    output reg         MemWrite;
    output reg         ALUSrc;
    output reg         RegWrite;
    output reg         Jump;
    output reg         Ext_op;
    output reg         PctoReg;
    output reg         JR;

    // for easy use 
    `define SIGNAL {LS_bit, RegDst, Branch, MemtoReg, ALUSrc, ALUOp, MemWrite, RegWrite, Jump, Ext_op, PctoReg, JR}
    parameter T = 1'b1;
    parameter F = 1'b0;

    /* opcode field */
    parameter opcode_is_RType  = 6'b000000;

    // conditional transfer
    parameter opcode_is_BEQ    = 6'b000100;
    parameter opcode_is_BNE    = 6'b000101;

    // I type R op
    parameter opcode_is_ADDI   = 6'b001000;
    parameter opcode_is_ADDIU  = 6'b001001;
    parameter opcode_is_ANDI   = 6'b001100;
    parameter opcode_is_LUI    = 6'b001111;
    parameter opcode_is_ORI    = 6'b001101;
    parameter opcode_is_XORI   = 6'b001110;
    parameter opcode_is_SLTI   = 6'b001010;
    parameter opcode_is_SLTIU  = 6'b001011;

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


    parameter WORD  = 2'b00;
    parameter HALF  = 2'b01;
    parameter BYTE  = 2'b10; 
    parameter NONE  = 2'b11;


    /* SIGNAL :

        LS_bit, RegDst, Branch, MemtoReg, ALUSrc, ALUOp, MemWrite, RegWrite, Jump, Ext_op, PctoReg, JR
    
    */
    always @(*) 
    begin
        if (opcode == opcode_is_RType)    // R type operation, use funct
            if (funct == 6'b001000)         // this the funct code of jr
                `SIGNAL = {NONE, T, 2'b00, F, F, 4'b0010, F, T, F, F, F, T};
            else 
                `SIGNAL = {NONE, T, 2'b00, F, F, 4'b0010, F, T, F, F, F, F};        
        else
            case(opcode) 
        /*
                About ALUOp of I type and J type:
                0010: R type
                0000: use add
                0001: use minus
                0011: load to upper 16-bit
                0101: use and
                0100: use or
                0110: use xor
                1010: use nor
                1000: use slt
        */
                opcode_is_BEQ   : `SIGNAL = {NONE, F, 2'b01, F, F, 4'b0001, F, F, F, F, T, F};
                opcode_is_BNE   : `SIGNAL = {NONE, F, 2'b10, F, F, 4'b0001, F, F, F, F, T, F};

                opcode_is_ADDI  : `SIGNAL = {NONE, F, 2'b00, F, T, 4'b0000, F, T, F, F, F, F};
                opcode_is_ADDIU : `SIGNAL = {NONE, F, 2'b00, F, T, 4'b0000, F, T, F, T, F, F};
                opcode_is_ANDI  : `SIGNAL = {NONE, F, 2'b00, F, T, 4'b0101, F, T, F, F, F, F};
                opcode_is_LUI   : `SIGNAL = {NONE, F, 2'b00, F, T, 4'b0011, F, T, F, F, F, F};
                opcode_is_ORI   : `SIGNAL = {NONE, F, 2'b00, F, T, 4'b0100, F, T, F, F, F, F};
                opcode_is_XORI  : `SIGNAL = {NONE, F, 2'b00, F, T, 4'b0110, F, T, F, F, F, F};
                opcode_is_SLTI  : `SIGNAL = {NONE, F, 2'b00, F, T, 4'b1000, F, T, F, F, F, F};
                opcode_is_SLTIU : `SIGNAL = {NONE, F, 2'b00, F, T, 4'b1000, F, T, F, T, F, F};
                
                opcode_is_LW    : `SIGNAL = {WORD, F, 2'b00, T, T, 4'b0000, F, T, F, F, F, F};
                opcode_is_LH    : `SIGNAL = {HALF, F, 2'b00, T, T, 4'b0000, F, T, F, F, F, F};
                opcode_is_LHU   : `SIGNAL = {HALF, F, 2'b00, T, T, 4'b0000, F, T, F, T, F, F};
                opcode_is_LB    : `SIGNAL = {BYTE, F, 2'b00, T, T, 4'b0000, F, T, F, F, F, F};
                opcode_is_LBU   : `SIGNAL = {BYTE, F, 2'b00, T, T, 4'b0000, F, T, F, T, F, F};
                opcode_is_SW    : `SIGNAL = {WORD, F, 2'b00, F, T, 4'b0000, T, F, F, F, F, F};
                opcode_is_SH    : `SIGNAL = {HALF, F, 2'b00, F, T, 4'b0000, T, F, F, F, F, F};
                opcode_is_SB    : `SIGNAL = {BYTE, F, 2'b00, F, T, 4'b0000, T, F, F, F, F, F};
    
                opcode_is_J     : `SIGNAL = {NONE, F, 2'b00, F, F, 4'b0000, F, F, T, F, F, F};
                opcode_is_JAL   : `SIGNAL = {NONE, F, 2'b00, F, F, 4'b0000, F, T, T, F, T, F};
            endcase    
    end
endmodule



/*
    jal: R[31] = PC + 8;, PC = jumpAddr
*/
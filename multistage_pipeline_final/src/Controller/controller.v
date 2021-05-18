module controller #(
    // value to tell the difference between word, half word and btye
    parameter NONE = 2'b00,
    parameter WORD = 2'b01,
    parameter HALF = 2'b10,
    parameter BYTE = 2'b11,
    // simple tag
    parameter T    = 1'b1,
    parameter F    = 1'b0,
    // tag to distingush Branch
    parameter BEQ    = 3'b000,              // branch equal
    parameter BNE    = 3'b001,              // branch not equal 
    parameter BGEZ   = 3'b010,              // branch greater than or equal to zero
    parameter BGTZ   = 3'b011,              // branch greater than zero
    parameter BLEZ   = 3'b100,              // branch less than or equal to zero
    parameter BLTZ   = 3'b101,              // branch less than zero
    parameter BGEZAL = 3'b110,              // branch greater than or equal to zero and link
    parameter BLTZAL = 3'b111               // branch less than zero and link
)(
    input      [ 5: 0] opcode,
    input      [ 4: 0] rt,
    input      [ 5: 0] funct,
    output reg [ 1: 0] LS_bit,
    output reg [ 2: 0] RegDst,
    output reg         MemtoReg,
    output reg [ 3: 0] ALUOp,
    output reg         MemWrite,
    output reg         ALUSrc,
    output reg         ShamtSrc,
    output reg         RegWrite,
    output reg         Ext_op,
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




endmodule //controller
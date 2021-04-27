module controller(opcode, RegDst, Branch, MemtoReg, ALUOp, 
    MemWrite, ALUSrc, RegWrite, Jump, Ext_op);

    input   [31:26] opcode;         // 6-bit opcode, which is instr[31:26]         

    // outputs are all signals
    output reg         RegDst;   
    output reg         Branch;
    output reg         MemtoReg;
    output reg [ 3: 0] ALUOp;
    output reg         MemWrite;
    output reg         ALUSrc;
    output reg         RegWrite;
    output reg         Jump;
    output reg         Ext_op;

    // for easy use 
    `define SIGNAL {RegDst, Branch, MemtoReg, ALUSrc, ALUOp, MemWrite, RegWrite, Jump, Ext_op}
    parameter T = 1'b1;
    parameter F = 1'b0;

    // opcode field
    parameter ADDI   = 6'b001000;
    parameter ADDIU  = 6'b001001;
    parameter BEQ    = 6'b000100;
    parameter J      = 6'b000010;
    parameter LW     = 6'b100011;
    parameter SW     = 6'b101011;
    parameter LUI    = 6'b001111;
    parameter ORI    = 6'b001101;

    always @(*) 
    begin
        if (opcode == 6'b000000)    // R type operation, use funct
            `SIGNAL = {T, F, F, F, 4'b0010, F, T, F, F};
        else
            case(opcode) 
                // About ALUOp of I type and J type:
                // 000: use add
                // 001: use minus
                // 011: load to upper 16-bit
                // 100: use or
                ADDI  : `SIGNAL = {F, F, F, T, 4'b0000, F, T, F, F};
                ADDIU : `SIGNAL = {F, F, F, T, 4'b0000, F, T, F, T};
                BEQ   : `SIGNAL = {F, T, F, F, 4'b0001, F, F, F, F};
                J     : `SIGNAL = {F, F, F, F, 4'b0000, F, F, T, F};
                LW    : `SIGNAL = {F, F, T, T, 4'b0000, F, T, F, F};
                SW    : `SIGNAL = {F, F, F, T, 4'b0000, T, F, F, F};
                LUI   : `SIGNAL = {F, F, F, T, 4'b0011, F, T, F, F};
                ORI   : `SIGNAL = {F, F, F, T, 4'b0100, F, T, F, F};
            endcase    
    end
endmodule
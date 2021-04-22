module controller(opcode, funct, RegDst, Branch, MemtoReg, ALUOp, 
    MemWrite, ALUSrc, RegWrite, Jump);

    input   [31:26] opcode;         // 6-bit opcode, which is instr[31:26]
    input   [ 5: 0] funct;          

    // outputs are all signals
    output reg         RegDst;   
    output reg         Branch;
    output reg         MemtoReg;
    output reg [ 1: 0] ALUOp;
    output reg         MemWrite;
    output reg         ALUSrc;
    output reg         RegWrite;
    output reg         Jump;

    // for easy use 
    `define SIGNAL {RegDst, Branch, MemtoReg, ALUSrc, ALUOp, MemWrite, RegWrite, Jump}
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

    always @(*) 
    begin
        if (opcode == 6'b000000)    // R type operation, use funct
            `SIGNAL = {T, F, F, F, 2'b10, F, T, F};
        else
            case(opcode)
                ADDI  : `SIGNAL = {F, F, F, T, 2'b00, F, T, F};
                ADDIU : `SIGNAL = {F, F, F, T, 2'b00, F, T, F};
                BEQ   : `SIGNAL = {F, T, F, F, 2'b01, F, F, F};
                J     : `SIGNAL = {F, F, F, F, 2'b00, F, F, T};
                LW    : `SIGNAL = {F, F, T, T, 2'b00, F, T, F};
                SW    : `SIGNAL = {F, F, F, T, 2'b00, T, F, F};
                LUI   : `SIGNAL = {F, F, F, T, 2'b11, F, T, F};
            endcase    
    end
endmodule
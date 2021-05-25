module alu_ctrl #(
    /*
        ALUOp field
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
        alu_ctrl_out field
    */
    parameter ADD_OP     = 5'b00000,
    parameter ADDU_OP    = 5'b00001,
    parameter SUB_OP     = 5'b00010,
    parameter SUBU_OP    = 5'b00011,
    parameter STL_OP     = 5'b00100,
    parameter STLU_OP    = 5'b00101,
    parameter MULT_OP    = 5'b00110,
    parameter MULTU_OP   = 5'b00111,
    parameter DIV_OP     = 5'b01000,
    parameter DIVU_OP    = 5'b01001,
    parameter AND_OP     = 5'b01010,
    parameter OR_OP      = 5'b01011,
    parameter NOR_OP     = 5'b01100,
    parameter XOR_OP     = 5'b01101,
    parameter LUI_OP     = 5'b01110,
    parameter SLL_OP     = 5'b01111,
    parameter SRL_OP     = 5'b10000,
    parameter SRA_OP     = 5'b10001,
    parameter MTHI_OP    = 5'b10010,
    parameter MTLO_OP    = 5'b10011                 
)(
    input      [ 3: 0] ID_EX_ALUOp,
    input      [25: 0] ID_EX_instr26,          // funct extracted from this
    output reg [ 4: 0] alu_ctrl_out
);

    /*
        funct field
    */
    parameter funct_is_ADD    = 6'b100000;
    parameter funct_is_ADDU   = 6'b100001;
    parameter funct_is_SUB    = 6'b100010;
    parameter funct_is_SUBU   = 6'b100011;
    parameter funct_is_SLT    = 6'b101010;
    parameter funct_is_SLTU   = 6'b101011;
    parameter funct_is_MULT   = 6'b011000;
    parameter funct_is_MULTU  = 6'b011001;
    parameter funct_is_DIV    = 6'b011010;
    parameter funct_is_DIVU   = 6'b011011;
    parameter funct_is_AND    = 6'b100100;
    parameter funct_is_OR     = 6'b100101;
    parameter funct_is_NOR    = 6'b100111;
    parameter funct_is_XOR    = 6'b100110;
    parameter funct_is_SLL    = 6'b000000;
    parameter funct_is_SLLV   = 6'b000100;
    parameter funct_is_SRL    = 6'b000010;
    parameter funct_is_SRLV   = 6'b000110; 
    parameter funct_is_SRA    = 6'b000011;
    parameter funct_is_SRAV   = 6'b000111; 
    parameter funct_is_MTHI   = 6'b010001;
    parameter funct_is_MTLO   = 6'b010011;  


    always @(*) begin
        case (ID_EX_ALUOp)
            USE_R_TYPE : begin
                case (ID_EX_instr26[ 5: 0])
                    funct_is_ADD    : alu_ctrl_out = ADD_OP;
                    funct_is_ADDU   : alu_ctrl_out = ADDU_OP;
                    funct_is_SUB    : alu_ctrl_out = SUB_OP;
                    funct_is_SLT    : alu_ctrl_out = STL_OP;
                    funct_is_SLTU   : alu_ctrl_out = STLU_OP;
                    funct_is_MULT   : alu_ctrl_out = MULT_OP;
                    funct_is_MULTU  : alu_ctrl_out = MULTU_OP;
                    funct_is_DIV    : alu_ctrl_out = DIV_OP;
                    funct_is_DIVU   : alu_ctrl_out = DIVU_OP;
                    funct_is_AND    : alu_ctrl_out = AND_OP;
                    funct_is_OR     : alu_ctrl_out = OR_OP;
                    funct_is_NOR    : alu_ctrl_out = NOR_OP;
                    funct_is_XOR    : alu_ctrl_out = XOR_OP;
                    funct_is_SLL    : alu_ctrl_out = SLL_OP;
                    funct_is_SLLV   : alu_ctrl_out = SLL_OP;
                    funct_is_SRL    : alu_ctrl_out = SRL_OP;
                    funct_is_SRLV   : alu_ctrl_out = SRL_OP;
                    funct_is_SRA    : alu_ctrl_out = SRA_OP;
                    funct_is_SRAV   : alu_ctrl_out = SRA_OP; 
                    funct_is_MTHI   : alu_ctrl_out = MTHI_OP;
                    funct_is_MTLO   : alu_ctrl_out = MTLO_OP;   
                endcase
            end
            USE_ADD   : alu_ctrl_out = ADD_OP;
            USE_ADDU  : alu_ctrl_out = ADDU_OP;
            USE_SUB   : alu_ctrl_out = SUB_OP;
            USE_SUBU  : alu_ctrl_out = SUBU_OP;
            USE_SLT   : alu_ctrl_out = STL_OP;
            USE_SLTU  : alu_ctrl_out = STLU_OP;
            USE_AND   : alu_ctrl_out = AND_OP;
            USE_OR    : alu_ctrl_out = OR_OP;
            USE_NOR   : alu_ctrl_out = NOR_OP;
            USE_XOR   : alu_ctrl_out = XOR_OP;
            USE_LUI   : alu_ctrl_out = LUI_OP;
        endcase
    end         



endmodule //alu_ctrl
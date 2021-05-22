module alu #(
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
    parameter SRA_OP     = 5'b10001 
)(
    input      [ 4: 0] alu_ctrl_out,
    input      [31: 0] op1,
    input      [31: 0] op2,
    input      [ 4: 0] shamt,
    output reg [31: 0] alu_out,
    output reg         overflow,
    output reg         divideZero
);
    reg [32: 0] temp; 

    always @(*) begin
        case (alu_ctrl_out)
            ADD_OP  : begin
                temp = {op1[31], op1} + {op2[31], op2};
                if (temp[32:0] == temp[31:0])
                begin
                    alu_out = temp;
                    overflow = 1'b0;
                end
                else 
                    overflow = 1'b1;
            end

            ADDU_OP : begin
                
            end
        endcase
    end

endmodule // alu
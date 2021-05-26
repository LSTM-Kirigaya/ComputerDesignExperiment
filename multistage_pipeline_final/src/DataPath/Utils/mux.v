module mux1 #(
    parameter RT         = 3'b000,              // to GPR[rt]
    parameter RD         = 3'b001,              // to GPR[rd]
    parameter RA         = 3'b010,              // to GPR[31]
    parameter HI         = 3'b011,              // to GPR[32]
    parameter LO         = 3'b100,              // to GPR[33]
    parameter PROD       = 3'b101               // to HI and LO 
)(
    input       [ 2: 0] ID_EX_RegDst,
    input       [25: 0] ID_EX_instr26,
    output reg  [ 5: 0] mux1_out
);

    always @(*) begin
        case (ID_EX_RegDst)
            RT      : mux1_out = ID_EX_instr26[20:16];
            RD      : mux1_out = ID_EX_instr26[15:11];
            RA      : mux1_out = 31;
            HI      : mux1_out = 32;
            LO      : mux1_out = 33;
            PROD    : mux1_out = 34;
        endcase
    end

endmodule // mux1

module mux2 (
    input      [ 1: 0] Forward2A,
    input      [31: 0] ID_EX_mux8_out,
    input      [31: 0] mux6_out,
    input      [31: 0] EX_MEM_mux5_out,
    output reg [31: 0] mux2_out
);  
    always @(*) begin
        case (Forward2A)
            2'b10 : mux2_out = EX_MEM_mux5_out;
            2'b01 : mux2_out = mux6_out;
            2'b00 : mux2_out = ID_EX_mux8_out;
        endcase    
    end
endmodule // mux2

module mux3 (
    input      [ 1: 0] Forward2B,
    input      [31: 0] ID_EX_mux9_out,
    input      [31: 0] mux6_out,
    input      [31: 0] EX_MEM_mux5_out,
    output reg [31: 0] mux3_out
);
    always @(*) begin
        case (Forward2B)
            2'b10 : mux3_out = EX_MEM_mux5_out;
            2'b01 : mux3_out = mux6_out;
            2'b00 : mux3_out = ID_EX_mux9_out;
        endcase
    end
endmodule // mux3


module mux4 (
    input              ID_EX_ALUSrc,
    input      [31: 0] ID_EX_Ext_out,
    input      [31: 0] mux3_out,
    output reg [31: 0] mux4_out
);
    always @(*) begin
        case (ID_EX_ALUSrc)
            1'b1 : mux4_out = ID_EX_Ext_out;
            1'b0 : mux4_out = mux3_out;
        endcase
    end
endmodule // mux4

module mux5 (
    input      [ 2: 0] ID_EX_DataDst,
    input      [31: 0] mux11_out,
    input      [31: 0] mux12_out,
    input      [31: 0] ID_EX_pc_add_out,
    input      [31: 0] alu_out,
    output reg [31: 0] mux5_out
);
    always @(*) begin
        case (ID_EX_DataDst)
            3'b011 : mux5_out = mux11_out;
            3'b010 : mux5_out = mux12_out;
            3'b001 : mux5_out = ID_EX_pc_add_out;
            3'b000 : mux5_out = alu_out;
        endcase
    end
endmodule // mux5

module mux6 (
    input              MEM_WB_MemtoReg,
    input      [31: 0] MEM_WB_dm_out,
    input      [31: 0] MEM_WB_mux5_out,
    output reg [31: 0] mux6_out
);
    always @(*) begin
        if (MEM_WB_MemtoReg)
            mux6_out = MEM_WB_dm_out;
        else 
            mux6_out = MEM_WB_mux5_out;
    end
endmodule // mux6

module mux7 (
    input               OR3_out,

    input       [ 1: 0] LS_bit,
    input       [ 2: 0] RegDst,
    input       [ 2: 0] DataDst,
    input               MemtoReg,
    input       [ 3: 0] ALUOp,
    input               MemWrite,
    input               ALUSrc,
    input               ShamtSrc,
    input               RegWrite,
    input               Ext_op,
    input       [ 3: 0] ExcCode,

    output reg  [ 1: 0] mux7_LS_bit,
    output reg  [ 2: 0] mux7_RegDst,
    output reg  [ 2: 0] mux7_DataDst,
    output reg          mux7_MemtoReg,
    output reg  [ 3: 0] mux7_ALUOp,
    output reg          mux7_MemWrite,
    output reg          mux7_ALUSrc,
    output reg          mux7_ShamtSrc,
    output reg          mux7_RegWrite,
    output reg          mux7_Ext_op,
    output reg  [ 3: 0] mux7_ExcCode
);

    always @(*) begin
        if (OR3_out)            // if block
        begin
            mux7_LS_bit    =  2'b00;          
            mux7_RegDst    =  3'b000;      
            mux7_DataDst   =  3'b000;     
            mux7_MemtoReg  =  1'b0;     
            mux7_ALUOp     =  4'b0000;  
            mux7_MemWrite  =  1'b0;     
            mux7_ALUSrc    =  1'b0;   
            mux7_ShamtSrc  =  1'b0;     
            mux7_RegWrite  =  1'b0;     
            mux7_Ext_op    =  1'b0;   
            mux7_ExcCode   =  4'b0000;    
        end
        else begin
            mux7_LS_bit    =  LS_bit;      
            mux7_RegDst    =  RegDst;   
            mux7_DataDst   =  DataDst;   
            mux7_MemtoReg  =  MemtoReg; 
            mux7_ALUOp     =  ALUOp; 
            mux7_MemWrite  =  MemWrite; 
            mux7_ALUSrc    =  ALUSrc;
            mux7_ShamtSrc  =  ShamtSrc; 
            mux7_RegWrite  =  RegWrite; 
            mux7_Ext_op    =  Ext_op;
            mux7_ExcCode   =  ExcCode;   
        end
    end
endmodule // mux7

module mux8 (
    input      [ 1: 0] Forward1A,
    input      [31: 0] regfile_out1,
    input      [31: 0] EX_MEM_mux5_out,
    input      [31: 0] mux6_out,
    output reg [31: 0] mux8_out
);
    always @(*) begin
        case(Forward1A)
            2'b10 : mux8_out = EX_MEM_mux5_out;
            2'b01 : mux8_out = mux6_out;
            3'b00 : mux8_out = regfile_out1;
        endcase
    end
endmodule // mux8


module mux9 (
    input      [ 1: 0] Forward1B,
    input      [31: 0] regfile_out2,
    input      [31: 0] EX_MEM_mux5_out,
    input      [31: 0] mux6_out,
    output reg [31: 0] mux9_out
);
    always @(*) begin
        case(Forward1B)
            2'b10 : mux9_out = EX_MEM_mux5_out;
            2'b01 : mux9_out = mux6_out;
            2'b00 : mux9_out = regfile_out2;
        endcase
    end
endmodule // mux9


module mux10 (
    input               ShamtSrc,
    input       [25: 0] ID_EX_instr26,
    input       [ 4: 0] mux2_out,
    output  reg [ 4: 0] mux10_out
);
    always @(*) begin
        case (ShamtSrc)
            1'b0 : mux10_out = ID_EX_instr26[10: 6];
            1'b1 : mux10_out = mux2_out;
        endcase
    end

endmodule // mux10


// forward LO
module mux11 (
    input      [ 2: 0] Forward3A,
    input      [31: 0] ID_EX_low_out,
    input      [31: 0] EX_MEM_mux5_out,
    input      [31: 0] MEM_WB_mux5_out,
    input      [63: 0] EX_MEM_prod,
    input      [63: 0] MEM_WB_prod,
    output reg [31: 0] mux11_out
);

    always @(*) begin
        case (Forward3A)
            3'b100 : mux11_out = EX_MEM_prod[31: 0];
            3'b011 : mux11_out = MEM_WB_prod[31: 0];
            3'b010 : mux11_out = EX_MEM_mux5_out;
            3'b001 : mux11_out = MEM_WB_mux5_out;
            3'b000 : mux11_out = ID_EX_low_out;
        endcase
    end

endmodule // mux11

// forward HI
module mux12 (
    input      [ 2: 0] Forward3B,
    input      [31: 0] ID_EX_high_out,
    input      [31: 0] EX_MEM_mux5_out,
    input      [31: 0] MEM_WB_mux5_out,
    input      [63: 0] EX_MEM_prod,
    input      [63: 0] MEM_WB_prod,
    output reg [31: 0] mux12_out
);
    always @(*) begin
        case (Forward3B)
            3'b100 : mux12_out = EX_MEM_prod[63: 32];
            3'b011 : mux12_out = MEM_WB_prod[63: 32];
            3'b010 : mux12_out = EX_MEM_mux5_out;
            3'b001 : mux12_out = MEM_WB_mux5_out;
            3'b000 : mux12_out = ID_EX_high_out;
        endcase
    end
endmodule // mux12
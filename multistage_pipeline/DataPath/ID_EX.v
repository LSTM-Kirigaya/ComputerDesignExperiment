module ID_EX (clock, RegDst, Branch, MemtoReg, ALUOp, 
    MemWrite, ALUSrc, RegWrite, Jump, Ext_op,
    IF_ID_pc_add_out, regfile_out1, regfile_out2, 
    I1, I2, I3, ID_EX_out);

    input          clock;

    // input of controller
    input          RegDst;   
    input          Branch;
    input          MemtoReg;
    input  [ 3: 0] ALUOp;
    input          MemWrite;
    input          ALUSrc;
    input          RegWrite;
    input          Jump;
    input          Ext_op;

    // input of regfile
    input  [31: 0] regfile_out1;
    input  [31: 0] regfile_out2;

    // input of IF/ID
    input  [31: 0] IF_ID_pc_add_out;

    // input of instruction left
    input  [15: 0] I1;
    input  [ 4: 0] I2;
    input  [ 4: 0] I3;

    output reg [133:0] ID_EX_out;

    always @(posedge clock) begin
        ID_EX_out = {RegDst, Branch, MemtoReg, ALUOp, 
            MemWrite, ALUSrc, RegWrite, Jump, Ext_op,
            IF_ID_pc_add_out, regfile_out1, regfile_out2, 
            I1, I2, I3};
    end

endmodule //ID_EX

// starting index and end of each instruction
/*

    ID_EX_out[0]      :  RegDst
    ID_EX_out[1]      :  Branch
    ID_EX_out[2]      :  MemtoReg
    ID_EX_out[6:3]    :  ALUOp
    ID_EX_out[7]      :  MemWrite
    ID_EX_out[8]      :  ALUSrc
    ID_EX_out[9]      :  RegWrite
    ID_EX_out[10]     :  Jump
    ID_EX_out[11]     :  Ext_op
    ID_EX_out[43:12]  :  regfile_out1
    ID_EX_out[75:44]  :  regfile_out2
    ID_EX_out[107:76] :  IF_ID_pc_add_out
    ID_EX_out[123:108]:  I1
    ID_EX_out[128:124]:  I2
    ID_EX_out[133:129]:  I3

*/
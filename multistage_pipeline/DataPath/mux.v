// mux between IF and ID
module mux1(rt, rd, RegDst, DstReg);
    input      [4:0] rt;           // instr[20:16] I
    input      [4:0] rd;           // instr[15:11] R
    input            RegDst;       // signal
    output reg [4:0] DstReg;       // selected register
    
    always @(*) 
        if (RegDst)
            DstReg <= rd;
        else 
            DstReg <= rt;

endmodule


// mux between ID and EX
module mux2(out2, Ext, ALUSrc, DstData);
    input      [31:0] out2;        // out2 of regfile
    input      [31:0] Ext;         // immediate number
    input             ALUSrc;      // signal
    output reg [31:0] DstData;     // selected data

    always @(*)
    begin
        if (ALUSrc)
            DstData <= Ext;
        else
            DstData <= out2;
        // $display("mux2_out:%h", DstData);
    end

endmodule

// mux between MEM and WB
module mux3(dm_out, alu_out, MemtoReg, mux3_out);
    input       [31:0] dm_out;      // result of dm
    input       [31:0] alu_out;     // result of alu
    input              MemtoReg;    // signal
    output reg  [31:0] mux3_out;   // selected data

    always @(*)
        if (MemtoReg)
            mux3_out <= dm_out;
        else
            mux3_out <= alu_out;

endmodule

module mux4(mux3_out, MEM_WB_pc_add_out, PctoReg, mux4_out);
    input       [31:0] mux3_out;
    input       [31:0] MEM_WB_pc_add_out;
    input              PctoReg;
    output reg  [31:0] mux4_out;

    always @(*) begin
        if (PctoReg)
            mux4_out <= MEM_WB_pc_add_out;
        else 
            mux4_out <= mux3_out;
    end
endmodule

// choose RegDst (nornal or 31)
module mux5(MEM_WB_mux1_out, PctoReg, mux5_out);
    input       [ 4: 0] MEM_WB_mux1_out;
    input               PctoReg;
    output reg  [ 4: 0] mux5_out;

    always @(*) begin
        if (PctoReg)
            mux5_out <= 5'b11111;       // select rs
        else 
            mux5_out <= MEM_WB_mux1_out; 
    end
endmodule //mux5
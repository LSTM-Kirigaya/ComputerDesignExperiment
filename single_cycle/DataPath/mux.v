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
module mux3(dm_out, alu_out, MemtoReg, WriteData);
    input       [31:0] dm_out;      // result of dm
    input       [31:0] alu_out;     // result of alu
    input              MemtoReg;    // signal
    output reg  [31:0] WriteData;   // selected data

    always @(*)
        if (MemtoReg)
            WriteData <= dm_out;
        else
            WriteData <= alu_out;

endmodule
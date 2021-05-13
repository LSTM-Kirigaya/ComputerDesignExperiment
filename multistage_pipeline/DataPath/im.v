module im_4k(pc, out_instr);

    input   [31: 0]  pc;             // pc point
    output  [31: 0]  out_instr;      // 32-bit instruction read from IM

    reg     [31: 0]  im[1023: 0];    // all the instructions restored in IM

    initial 
        $readmemh("./data/test_r_text", im, 0, 1023);    

    assign out_instr = im[pc[11:2]];

    always @(out_instr)         // print current instruction only when out_instr is changed
    begin
        // $display("\033[32mload instruction: \033[34m%h\033[32m  pc[11: 2]:%d\033[0m", out_instr, pc[11:2]);
        // if (out_instr[31:26] == 6'b0)
        //     $display("\033[31m-> this is a R Type, whose rs = %d, rt = %d\033[0m", out_instr[25:21], out_instr[20:16]);
    end
endmodule

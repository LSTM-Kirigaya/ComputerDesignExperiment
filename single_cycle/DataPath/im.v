module im_4k(pc, out_instr);

    input   [31: 0]  pc;             // pc point
    output  [31: 0]  out_instr;      // 32-bit instruction read from IM

    reg     [31: 0]  im[1023: 0];    // all the instructions restored in IM

    initial 
        $readmemh("./data/.text", im, 0, 1023);    

    assign out_instr = im[pc[11:2]];

    always @(out_instr)         // print current instruction only when out_instr is changed
        $display("successfully load instruction:%b", out_instr);

endmodule

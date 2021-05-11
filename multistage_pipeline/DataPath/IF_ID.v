module IF_ID (
    clock, 
    pc_add_out, 
    im_out, 
    
    IF_ID_pc_add_out,
    IF_ID_im_out
    );

    input               clock;
    input      [31: 0]  pc_add_out;
    input      [31: 0]  im_out;

    output reg [31: 0]  IF_ID_pc_add_out;
    output reg [31: 0]  IF_ID_im_out;

    always @(posedge clock) 
    begin
        IF_ID_pc_add_out  <=  pc_add_out;
        IF_ID_im_out      <=  im_out;
    end
        
endmodule //IF_ID

// starting index and end of each instruction
/*

    IF_ID_out[31: 0]  :    pc_add_out
    IF_ID_out[63:32]  :    im_out    

*/
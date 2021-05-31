module IF_ID #(
    parameter NOP = 32'h20080000            // addi $t0, $zero, 0
)(
    input              clock,
    input              reset,
    input              OR2_out,
    input              OR4_out,
    input      [31: 0] pc_add_out,
    input      [31: 0] im_out,
    output reg [31: 0] IF_ID_pc_add_out,
    output reg [31: 0] IF_ID_im_out
);
    /*
        OR2_out : IF_ID_Stall
        OR4_out : IF_Flush
    */
    always @(posedge clock) 
    begin
        if (!OR2_out)                // update iff IF_ID_Write
        begin
            if (OR4_out)
                IF_ID_im_out = NOP;  // use NOP to flush and the pc_add_out won't be used later, so we don't care about pc_add_out there
            else
                IF_ID_im_out = im_out;
            IF_ID_pc_add_out = pc_add_out;
        end
    end

endmodule //IF_ID
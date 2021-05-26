module im_8k (
    input          clock,
    input          reset,
    input  [31: 0] pc_out,
    output [31: 0] im_out
);
    reg    [31: 0] im[2047: 0];             // instruction memory, which is an instruction pool

    always @(posedge clock or negedge reset) begin
        $readmemh("./data/test_r_text", im, 0, 2047);
    end

    assign im_out = im[pc_out[11: 2]];
    
endmodule // im_8k
module dm_8k #(
    parameter NONE       = 2'b00,
    parameter WORD       = 2'b01,
    parameter HALF       = 2'b10,
    parameter BYTE       = 2'b11
)(
    input               clock,
    input               reset,
    input       [ 1: 0] EX_MEM_LS_bit,
    input               EX_MEM_MemWrite,
    input               EX_MEM_Ext_op,
    input       [31: 0] EX_MEM_mux5_out,
    input       [31: 0] EX_MEM_mux3_out,
    output reg  [31: 0] dm_out
);

    reg         [31: 0] dm[2048: 0];
    reg         [15: 0] temp;

    always @(posedge clock or negedge reset) begin
        $readmemh("./data/test_load_save_data", dm, 0, 2048);
    end


    // save word if MemWrite
    always @(*) begin      
        if (EX_MEM_MemWrite && EX_MEM_LS_bit != NONE) begin
            case (EX_MEM_LS_bit)
                WORD : begin
                    dm[EX_MEM_mux5_out[11: 2]] = EX_MEM_mux3_out;
                end
                HALF : begin
                    case (EX_MEM_mux5_out[1])
                        1'b0 : dm[EX_MEM_mux5_out[11: 2]][15: 0] = EX_MEM_mux3_out[15: 0];
                        1'b1 : dm[EX_MEM_mux5_out[11: 2]][31:16] = EX_MEM_mux3_out[15: 0];
                    endcase
                end
                BYTE : begin
                    case (EX_MEM_mux5_out[ 1: 0])
                        2'b00 : dm[EX_MEM_mux5_out[11: 2]][ 7: 0] = EX_MEM_mux3_out[ 7: 0];
                        2'b01 : dm[EX_MEM_mux5_out[11: 2]][15: 8] = EX_MEM_mux3_out[ 7: 0];
                        2'b10 : dm[EX_MEM_mux5_out[11: 2]][23:16] = EX_MEM_mux3_out[ 7: 0];
                        2'b11 : dm[EX_MEM_mux5_out[11: 2]][31:24] = EX_MEM_mux3_out[ 7: 0];
                    endcase
                end
            endcase
        end
    end

    // load word if LS_bit && !MemWrite
    always @(*) begin
        if (!EX_MEM_MemWrite && EX_MEM_LS_bit != NONE) begin
            case (EX_MEM_LS_bit)
                WORD : begin
                    dm_out = dm[EX_MEM_mux5_out[11: 2]];
                end
                HALF : begin
                    case (EX_MEM_mux5_out[1])
                        1'b0 : temp = dm[EX_MEM_mux5_out[11: 2]][15: 0];
                        1'b1 : temp = dm[EX_MEM_mux5_out[11: 2]][31:16];
                    endcase

                    if (EX_MEM_Ext_op)
                        dm_out = {{16{temp[15]}}, temp};
                    else 
                        dm_out = {{16{1'b0}}, temp};
                end
                BYTE : begin
                    case (EX_MEM_mux5_out[ 1: 0])
                        2'b00 : temp = dm[EX_MEM_mux5_out[11: 2]][ 7: 0];
                        2'b01 : temp = dm[EX_MEM_mux5_out[11: 2]][15: 8];
                        2'b10 : temp = dm[EX_MEM_mux5_out[11: 2]][23:16];
                        2'b11 : temp = dm[EX_MEM_mux5_out[11: 2]][31:24];
                    endcase

                    if (EX_MEM_Ext_op)
                        dm_out = {{24{temp[7]}}, temp[ 7: 0]};
                    else 
                        dm_out = {{24{1'b0}}, temp[ 7: 0]};
                end
            endcase
        end
    end

endmodule // dm_8k
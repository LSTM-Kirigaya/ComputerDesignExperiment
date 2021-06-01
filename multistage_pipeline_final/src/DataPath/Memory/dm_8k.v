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

    always @(posedge reset) begin
        $readmemh("./data/r_data", dm, 0, 2048);
        // TODO : change size of dm if there is load save command
    end

    reg         [31: 0] debug_save;
    reg         [31: 0] debug_load;

    wire         [31: 0] n1;
    wire         [31: 0] n2;
    wire         [31: 0] n3;
    wire         [31: 0] n4;
    wire         [31: 0] n5;
    wire         [31: 0] n6;


    // save word if MemWrite
    always @(*) begin      
        if (EX_MEM_MemWrite && EX_MEM_LS_bit != NONE) begin
            case (EX_MEM_LS_bit)
                WORD : begin
                    debug_save = EX_MEM_mux3_out;
                    dm[EX_MEM_mux5_out[11: 2]] = EX_MEM_mux3_out;
                end
                HALF : begin
                    debug_save = EX_MEM_mux3_out[15: 0];
                    case (EX_MEM_mux5_out[1])
                        1'b0 : dm[EX_MEM_mux5_out[11: 2]][15: 0] = EX_MEM_mux3_out[15: 0];
                        1'b1 : dm[EX_MEM_mux5_out[11: 2]][31:16] = EX_MEM_mux3_out[15: 0];
                    endcase
                end
                BYTE : begin
                    debug_save = EX_MEM_mux3_out[ 7: 0];
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
                    debug_load = EX_MEM_mux5_out[11: 2];
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

    always @(dm[0] or dm[1] or dm[2] or dm[3] or dm[4] or dm[5])        // for debug
    begin
        for (integer i = 0; i < 6; i = i + 1)
            $write("%d", dm[i]);
            $display(" ");
    end

endmodule // dm_8k
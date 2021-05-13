module dm_4k(
    clock, 
    EX_MEM_alu_out, 
    EX_MEM_regfile_out2, 
    LS_bit,
    MemWrite, 
    Ext_op,
    dm_out
    );

    input       [31:0] EX_MEM_alu_out;     // result of alu
    input       [31:0] EX_MEM_regfile_out2;               // result of im
    input       [ 1:0] LS_bit;
    input              MemWrite;           // signal
    input              clock;              // signal
    input              Ext_op;
    output reg  [31:0] dm_out;             // result

    reg         [31:0] dm [1023:0];
    reg        [15: 0] temp;

    initial 
        $readmemh("./data/test_load_save_data", dm, 0, 1023);  
    
    // for LS_bit
    parameter WORD  = 2'b00;
    parameter HALF  = 2'b01;
    parameter BYTE  = 2'b10; 

    

    always @(negedge clock) 
        if (MemWrite)               // save data
        begin
            case(LS_bit)
                WORD : dm[EX_MEM_alu_out[11: 2]] = EX_MEM_regfile_out2[31: 0];
                HALF : 
                case(EX_MEM_alu_out[1])              // ensure which half word in the whole word to process
                    1'b0  :  dm[EX_MEM_alu_out[11: 2]][15: 0] = EX_MEM_regfile_out2[15: 0];
                    1'b1  :  dm[EX_MEM_alu_out[11: 2]][31:16] = EX_MEM_regfile_out2[15: 0];
                endcase
                BYTE : 
                case(EX_MEM_alu_out[ 1: 0])
                    2'b00 : dm[EX_MEM_alu_out[11: 2]][ 7: 0] = EX_MEM_regfile_out2[ 7: 0];
                    2'b01 : dm[EX_MEM_alu_out[11: 2]][15: 8] = EX_MEM_regfile_out2[ 7: 0];
                    2'b10 : dm[EX_MEM_alu_out[11: 2]][23:16] = EX_MEM_regfile_out2[ 7: 0];
                    2'b11 : dm[EX_MEM_alu_out[11: 2]][31:24] = EX_MEM_regfile_out2[ 7: 0];
                endcase
            endcase
            // $display("%d", EX_MEM_regfile_out2);
        end

    always @(dm[0] or dm[1] or dm[2] or dm[3] or dm[4] or dm[5])        // for debug
    begin
        for (integer i = 0; i < 6; i = i + 1)
            $write("%h ", dm[i]);
            $display(" ");
    end
    
    always @(*) 
    begin               // load data
        case(LS_bit)
            WORD : dm_out = dm[EX_MEM_alu_out[11: 2]];
            HALF : 
            begin 
                case(EX_MEM_alu_out[1])              // ensure which half word in the whole word to process
                    1'b0  :  temp = dm[EX_MEM_alu_out[11: 2]][15: 0];
                    1'b1  :  temp = dm[EX_MEM_alu_out[11: 2]][31: 16];
                endcase

                if (Ext_op)
                    dm_out = {{16{temp[15]}}, temp};
                else
                    dm_out = {{16{1'b0}}, temp};
            end
            BYTE : 
            begin 
                case(EX_MEM_alu_out[ 1: 0])          // ensure which byte in the whole word to process
                    2'b00 : temp = dm[EX_MEM_alu_out[11: 2]][ 7: 0];
                    2'b01 : temp = dm[EX_MEM_alu_out[11: 2]][15: 8];
                    2'b10 : temp = dm[EX_MEM_alu_out[11: 2]][23:16];
                    2'b11 : temp = dm[EX_MEM_alu_out[11: 2]][31:24];
                endcase
                if (Ext_op)
                    dm_out = {{24{temp[7]}}, temp[ 7: 0]};
                else 
                    dm_out = {{24{1'b0}}, temp[ 7: 0]};
            end
        endcase
    end

endmodule

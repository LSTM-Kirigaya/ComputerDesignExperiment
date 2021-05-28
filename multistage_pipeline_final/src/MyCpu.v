`include "./src/Controller/controller.v"
`include "./src/DataPath/datapath.v"

module MyCpu (
    input       clock,
    input       reset
);

    wire [31: 0] 	IF_ID_im_out;
    wire         	use_stage;
    wire [ 1: 0] 	LS_bit;
    wire [ 2: 0] 	RegDst;
    wire [ 2: 0] 	DataDst;
    wire         	MemtoReg;
    wire [ 3: 0] 	ALUOp;
    wire         	MemWrite;
    wire         	ALUSrc;
    wire         	ShamtSrc;
    wire         	RegWrite;
    wire         	Ext_op;
    wire [ 3: 0] 	ExcCode;
    wire [ 3: 0] 	Branch;
    wire         	Jump;
    wire         	Jr;

    datapath u_datapath(
        //input
        .clock        		( clock        		),
        .reset        		( reset        		),
        .use_stage    		( use_stage    		),
        .LS_bit       		( LS_bit       		),
        .RegDst       		( RegDst       		),
        .DataDst      		( DataDst      		),
        .MemtoReg     		( MemtoReg     		),
        .ALUOp        		( ALUOp        		),
        .MemWrite     		( MemWrite     		),
        .ALUSrc       		( ALUSrc       		),
        .ShamtSrc     		( ShamtSrc     		),
        .RegWrite     		( RegWrite     		),
        .Ext_op       		( Ext_op       		),
        .ExcCode      		( ExcCode      		),
        .Branch       		( Branch       		),
        .Jump         		( Jump         		),
        .Jr           		( Jr           		),

        //output
        .IF_ID_im_out 		( IF_ID_im_out 		)
    );


    // comtroller
    controller #(
        .T                		( 1'b1      		),
        .F                		( 1'b0      		),
        .ID               		( 1'b0      		),
        .EX               		( 1'b1      		),
        .NONE             		( 2'b00     		),
        .WORD             		( 2'b01     		),
        .HALF             		( 2'b10     		),
        .BYTE             		( 2'b11     		),
        .BEQ              		( 4'b0000   		),
        .BNE              		( 4'b0001   		),
        .BGEZ             		( 4'b0010   		),
        .BGTZ             		( 4'b0011   		),
        .BLEZ             		( 4'b0100   		),
        .BLTZ             		( 4'b0101   		),
        .BGEZAL           		( 4'b0110   		),
        .BLTZAL           		( 4'b0111   		),
        .NO_BRANCH        		( 4'b1000   		),
        .RT               		( 3'b000    		),
        .RD               		( 3'b001    		),
        .RA               		( 3'b010    		),
        .HI               		( 3'b011    		),
        .LO               		( 3'b100    		),
        .PROD             		( 3'b101    		),
        .ALU_OUT          		( 3'b000    		),
        .PC_ADD_OUT       		( 3'b001    		),
        .HIGH_OUT         		( 3'b010    		),
        .LOW_OUT          		( 3'b011    		),
        .CP0_OUT          		( 3'b100    		),
        .USE_R_TYPE       		( 4'b0000   		),
        .USE_ADD          		( 4'b0001   		),
        .USE_ADDU         		( 4'b0010   		),
        .USE_SUB          		( 4'b0011   		),
        .USE_SUBU         		( 4'b0100   		),
        .USE_SLT          		( 4'b0101   		),
        .USE_SLTU         		( 4'b0110   		),
        .USE_AND          		( 4'b0111   		),
        .USE_OR           		( 4'b1000   		),
        .USE_NOR          		( 4'b1001   		),
        .USE_XOR          		( 4'b1010   		),
        .USE_LUI          		( 4'b1011   		),
        .NO_EXC           		( 4'b0000   		),
        .opcode_is_RType  		( 6'b000000 		),
        .opcode_is_BEQ    		( 6'b000100 		),
        .opcode_is_BNE    		( 6'b000101 		),
        .opcode_is_BGTZ   		( 6'b000111 		),
        .opcode_is_BLEZ   		( 6'b000110 		),
        .opcode_is_REGIMM 		( 6'b000001 		),
        .rt_is_BGEZ       		( 5'b00001  		),
        .rt_is_BLTZ       		( 5'b00000  		),
        .rt_is_BGEZAL     		( 5'b10001  		),
        .rt_is_BLTZAL     		( 5'b10000  		),
        .opcode_is_ADDI   		( 6'b001000 		),
        .opcode_is_ADDIU  		( 6'b001001 		),
        .opcode_is_SLTI   		( 6'b001010 		),
        .opcode_is_SLTIU  		( 6'b001011 		),
        .opcode_is_ANDI   		( 6'b001100 		),
        .opcode_is_LUI    		( 6'b001111 		),
        .opcode_is_ORI    		( 6'b001101 		),
        .opcode_is_XORI   		( 6'b001110 		),
        .opcode_is_LW     		( 6'b100011 		),
        .opcode_is_LH     		( 6'b100001 		),
        .opcode_is_LHU    		( 6'b100101 		),
        .opcode_is_LB     		( 6'b100000 		),
        .opcode_is_LBU    		( 6'b100100 		),
        .opcode_is_SW     		( 6'b101011 		),
        .opcode_is_SH     		( 6'b101001 		),
        .opcode_is_SB     		( 6'b101000 		),
        .opcode_is_J      		( 6'b000010 		),
        .opcode_is_JAL    		( 6'b000011 		),
        .opcode_is_COP0   		( 6'b010000 		),
        .rs_is_MFC0       		( 5'b00000  		),
        .rs_is_MTC0       		( 5'b00100  		),
        .funct_is_ERET    		( 6'b011000 		),
        .funct_is_MULT    		( 6'b011000 		),
        .funct_is_MULTU   		( 6'b011001 		),
        .funct_is_DIV     		( 6'b011010 		),
        .funct_is_DIVU    		( 6'b011011 		),
        .funct_is_JR      		( 6'b001000 		),
        .funct_is_SLLV    		( 6'b000100 		),
        .funct_is_SRLV    		( 6'b000110 		),
        .funct_is_SRAV    		( 6'b000111 		),
        .funct_is_MFHI    		( 6'b010000 		),
        .funct_is_MFLO    		( 6'b010010 		),
        .funct_is_MTHI    		( 6'b010001 		),
        .funct_is_MTLO    		( 6'b010011 		))
    u_controller(
        //input
        .opcode    		( IF_ID_im_out[31:26]),
        .rs        		( IF_ID_im_out[25:21]),
        .rt        		( IF_ID_im_out[20:16]),
        .funct     		( IF_ID_im_out[ 5: 0]),

        //output
        .use_stage 		( use_stage 		),
        .LS_bit    		( LS_bit    		),
        .RegDst    		( RegDst    		),
        .DataDst   		( DataDst   		),
        .MemtoReg  		( MemtoReg  		),
        .ALUOp     		( ALUOp     		),
        .MemWrite  		( MemWrite  		),
        .ALUSrc    		( ALUSrc    		),
        .ShamtSrc  		( ShamtSrc  		),
        .RegWrite  		( RegWrite  		),
        .Ext_op    		( Ext_op    		),
        .ExcCode   		( ExcCode   		),
        .Branch    		( Branch    		),
        .Jump      		( Jump      		),
        .Jr        		( Jr        		)
    );



endmodule //MyCpu
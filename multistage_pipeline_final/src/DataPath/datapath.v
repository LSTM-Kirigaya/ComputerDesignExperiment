`include "./src/DataPath/Pipe/IF_ID.v"
`include "./src/DataPath/Pipe/ID_EX.v"
`include "./src/DataPath/Pipe/EX_MEM.v"
`include "./src/DataPath/Pipe/MEM_WB.v"
`include "./src/DataPath/Memory/dm_8k.v"
`include "./src/DataPath/Memory/im_8k.v"
`include "./src/DataPath/Hazard/ForwardUnit.v"
`include "./src/DataPath/Hazard/HDU.v"
`include "./src/DataPath/Utils/alu_ctrl.v"
`include "./src/DataPath/Utils/alu.v"
`include "./src/DataPath/Utils/BU.v"
`include "./src/DataPath/Utils/Ext.v"
`include "./src/DataPath/Utils/FU.v"
`include "./src/DataPath/Utils/mux.v"
`include "./src/DataPath/Utils/npc.v"
`include "./src/DataPath/Utils/OR.v"
`include "./src/DataPath/Utils/pc_add.v"
`include "./src/DataPath/Utils/pc.v"
`include "./src/DataPath/Utils/regfile.v"

module datapath (
    input          clock,
    input          reset,
    input          use_stage,
    input  [ 1: 0] LS_bit,
    input  [ 2: 0] RegDst,
    input  [ 2: 0] DataDst,
    input          MemtoReg,    
    input  [ 3: 0] ALUOp,
    input          MemWrite,
    input          ALUSrc,
    input          ShamtSrc,
    input          RegWrite,
    input          Ext_op,              // 1 : signed ext  0 : unsigned ext
    input  [ 3: 0] ExcCode,
    input  [ 3: 0] Branch,
    input          Jump,
    input          Jr,
    output [31: 0] IF_ID_im_out 
);

    /*
        IF module
    */
    wire [31: 0] 	npc_out;
    wire [31: 0] 	pc_out;
    wire [31: 0] 	pc_add_out;
    wire [31: 0] 	im_out;
    wire   	        OR1_out;
    wire   	        OR2_out;
    wire   	        OR3_out;
    wire        	OR4_out;
    wire [31: 0] 	IF_ID_pc_add_out;
    wire [31: 0] 	IF_ID_im_out;
    wire   	        Skip_IF_Flush;
    wire [31: 0] 	Ext_out;
    wire   	        PcStall1;
    wire   	        IF_ID_Stall1;
    wire   	        HDU1_block;
    wire   	        PcStall2;
    wire   	        IF_ID_Stall2;
    wire   	        HDU2_block;
    wire [ 1: 0] 	mux7_LS_bit;
    wire [ 2: 0] 	mux7_RegDst;
    wire [ 2: 0] 	mux7_DataDst;
    wire         	mux7_MemtoReg;
    wire [ 3: 0] 	mux7_ALUOp;
    wire         	mux7_MemWrite;
    wire         	mux7_ALUSrc;
    wire         	mux7_ShamtSrc;
    wire         	mux7_RegWrite;
    wire         	mux7_Ext_op;
    wire [ 3: 0] 	mux7_ExcCode;
    wire [31: 0] 	low_out;
    wire [31: 0] 	high_out;
    wire [31: 0] 	regfile_out1;
    wire [31: 0] 	regfile_out2;
    wire [31: 0] 	mux8_out;
    wire [31: 0] 	mux9_out;
    wire   	        BU_out;
    wire [ 1: 0] 	Forward1A;
    wire [ 1: 0] 	Forward1B;

    wire [ 1: 0] 	ID_EX_LS_bit;
    wire [ 2: 0] 	ID_EX_RegDst;
    wire [ 2: 0] 	ID_EX_DataDst;
    wire         	ID_EX_MemtoReg;
    wire [ 3: 0] 	ID_EX_ALUOp;
    wire         	ID_EX_MemWrite;
    wire         	ID_EX_ALUSrc;
    wire         	ID_EX_ShamtSrc;
    wire         	ID_EX_RegWrite;
    wire         	ID_EX_Ext_op;
    wire [ 3: 0] 	ID_EX_ExcCode;
    wire [31: 0] 	ID_EX_low_out;
    wire [31: 0] 	ID_EX_high_out;
    wire [31: 0] 	ID_EX_pc_add_out;
    wire [31: 0] 	ID_EX_mux8_out;
    wire [31: 0] 	ID_EX_mux9_out;
    
    wire [31: 0] 	ID_EX_Ext_out;
    wire [25: 0] 	ID_EX_instr26;

    wire [31: 0] 	alu_out;
    wire [63: 0] 	prod;
    wire         	overflow;
    wire         	divideZero;
    wire [ 5: 0] 	mux1_out;
    wire [ 2: 0] 	Forward3A;
    wire [ 2: 0] 	Forward3B;
    wire [31: 0] 	mux11_out;
    wire [31: 0] 	mux12_out;
    wire [31: 0] 	mux2_out;
    wire [31: 0] 	mux3_out;
    wire [31: 0] 	mux4_out;
    wire [ 4: 0] 	alu_ctrl_out;
    wire [ 4: 0] 	mux10_out;
    wire [ 1: 0] 	Forward2A;
    wire [ 1: 0] 	Forward2B;
    wire [31: 0] 	mux5_out;
    wire [ 1: 0] 	EX_MEM_LS_bit;
    wire         	EX_MEM_MemtoReg;
    wire         	EX_MEM_MemWrite;
    wire         	EX_MEM_RegWrite;
    wire         	EX_MEM_Ext_op;
    wire [63: 0] 	EX_MEM_prod;
    wire [31: 0] 	EX_MEM_mux5_out;
    wire [31: 0] 	EX_MEM_mux3_out;
    wire [ 5: 0] 	EX_MEM_mux1_out;
    wire         	MEM_WB_MemtoReg;
    wire         	MEM_WB_RegWrite;
    wire [31: 0] 	MEM_WB_dm_out;
    wire [31: 0] 	MEM_WB_mux5_out;
    wire [ 5: 0] 	MEM_WB_mux1_out;
    wire [63: 0] 	MEM_WB_prod;
    wire [31: 0] 	mux6_out;



    npc u_npc(
        //input
        .Jr           		( Jr           		),
        .Jump         		( Jump         		),
        .BU_out       		( BU_out       		),
        .pc_add_out   		( pc_add_out   		),
        .IF_ID_im_out 		( IF_ID_im_out 		),
        .Ext_out      		( Ext_out      		),
        .mux8_out     		( mux8_out     		),

        //output
        .npc_out      		( npc_out      		)
    );

    

    pc #(
        .initial_addr 		( 32'h0000_3000 		))
    u_pc(
        //input
        .clock   		( clock   		),
        .reset   		( reset   		),
        .npc_out 		( npc_out 		),
        .OR1_out 		( OR1_out 		),

        //output
        .pc_out  		( pc_out  		)
    );



    pc_add u_pc_add(
        //input
        .pc_out     		( pc_out     		),

        //output
        .pc_add_out 		( pc_add_out 		)
    );

    

    im_8k u_im_8k(
        //input
        .clock  		( clock  		),
        .reset  		( reset  		),
        .pc_out 		( pc_out 		),

        //output
        .im_out 		( im_out 		)
    );

    

    OR1 u_OR1(
        //input
        .PcStall1 		( PcStall1 		),
        .PcStall2 		( PcStall2 		),

        //output
        .OR1_out  		( OR1_out  		)
    );

    

    OR2 u_OR2(
        //input
        .IF_ID_Stall1 		( IF_ID_Stall1 		),
        .IF_ID_Stall2 		( IF_ID_Stall2 		),

        //output
        .OR2_out      		( OR2_out      		)
    );

    /*
        ID module
    */
    

    IF_ID #(
        .NOP 		( 32'h20080000                                  		))
    u_IF_ID(
        //input
        .clock            		( clock            		),
        .reset            		( reset            		),
        .OR2_out          		( OR2_out          		),
        .OR4_out          		( OR4_out          		),
        .pc_add_out       		( pc_add_out       		),
        .im_out           		( im_out           		),

        //output
        .IF_ID_pc_add_out 		( IF_ID_pc_add_out 		),
        .IF_ID_im_out     		( IF_ID_im_out     		)
    );

    

    OR3 u_OR3(
        //input
        .HDU1_block  		( HDU1_block  		),
        .HDU2_block  		( HDU2_block  		),
        .Cause_block 		( Cause_block 		),

        //output
        .OR3_out     		( OR3_out     		)
    );

    

    OR4 u_OR4(
        //input
        .Skip_IF_Flush  		( Skip_IF_Flush  		),
        .Cause_IF_Flush 		( Cause_IF_Flush 		),

        //output
        .OR4_out        		( OR4_out        		)
    );

    

    FU u_FU(
        //input
        .BU_out        		( BU_out        		),
        .Jump          		( Jump          		),
        .Jr            		( Jr            		),

        //output
        .Skip_IF_Flush 		( Skip_IF_Flush 		)
    );

    

    Ext u_Ext(
        //input
        .Ext_op       		( Ext_op       		),
        .IF_ID_im_out 		( IF_ID_im_out 		),

        //output
        .Ext_out      		( Ext_out      		)
    );

    

    HDU1 u_HDU1(
        //input
        .clock                  ( clock                 ),
        .reset                  ( reset                 ),
        .use_stage       		( use_stage       		),
        .ID_EX_RegWrite  		( ID_EX_RegWrite  		),
        .EX_MEM_LS_bit   		( EX_MEM_LS_bit   		),
        .EX_MEM_MemWrite 		( EX_MEM_MemWrite 		),
        .rs              		( IF_ID_im_out[25:21] 	),
        .rt              		( IF_ID_im_out[20:16]  	),
        .mux1_out        		( mux1_out        		),
        .EX_MEM_mux1_out 		( EX_MEM_mux1_out 		),

        //output
        .PcStall1        		( PcStall1        		),
        .IF_ID_Stall1    		( IF_ID_Stall1    		),
        .HDU1_block      		( HDU1_block      		)
    );

    
    HDU2 u_HDU2(
        //input
        .clock                  ( clock                 ),
        .reset                  ( reset                 ),
        .use_stage      		( use_stage      		),
        .ID_EX_LS_bit   		( ID_EX_LS_bit   		),
        .ID_EX_MemWrite 		( ID_EX_MemWrite 		),
        .rs             		( IF_ID_im_out[25:21] 	),
        .rt             		( IF_ID_im_out[20:16]  	),
        .mux1_out       		( mux1_out       		),

        //output
        .PcStall2       		( PcStall2       		),
        .IF_ID_Stall2   		( IF_ID_Stall2   		),
        .HDU2_block     		( HDU2_block     		)
    );

    

    mux7 u_mux7(
        //input
        .OR3_out       		( OR3_out       		),
        .LS_bit        		( LS_bit        		),
        .RegDst        		( RegDst        		),
        .DataDst       		( DataDst       		),
        .MemtoReg      		( MemtoReg      		),
        .ALUOp         		( ALUOp         		),
        .MemWrite      		( MemWrite      		),
        .ALUSrc        		( ALUSrc        		),
        .ShamtSrc      		( ShamtSrc      		),
        .RegWrite      		( RegWrite      		),
        .Ext_op        		( Ext_op        		),
        .ExcCode       		( ExcCode       		),

        //output
        .mux7_LS_bit   		( mux7_LS_bit   		),
        .mux7_RegDst   		( mux7_RegDst   		),
        .mux7_DataDst  		( mux7_DataDst  		),
        .mux7_MemtoReg 		( mux7_MemtoReg 		),
        .mux7_ALUOp    		( mux7_ALUOp    		),
        .mux7_MemWrite 		( mux7_MemWrite 		),
        .mux7_ALUSrc   		( mux7_ALUSrc   		),
        .mux7_ShamtSrc 		( mux7_ShamtSrc 		),
        .mux7_RegWrite 		( mux7_RegWrite 		),
        .mux7_Ext_op   		( mux7_Ext_op   		),
        .mux7_ExcCode  		( mux7_ExcCode  		)
    );


    regfile u_regfile(
        //input
        .clock           		( clock           		),
        .reset           		( reset           		),
        .MEM_WB_RegWrite 		( MEM_WB_RegWrite 		),
        .rs              		( IF_ID_im_out[25:21]   ),
        .rt              		( IF_ID_im_out[20:16]   ),
        .MEM_WB_mux1_out 		( MEM_WB_mux1_out 		),
        .mux6_out        		( mux6_out        		),
        .MEM_WB_prod     		( MEM_WB_prod     		),

        //output
        .low_out         		( low_out         		),
        .high_out        		( high_out        		),
        .regfile_out1    		( regfile_out1    		),
        .regfile_out2    		( regfile_out2    		)
    );

    

    mux8 u_mux8(
        //input
        .Forward1A       		( Forward1A       		),
        .regfile_out1    		( regfile_out1    		),
        .EX_MEM_mux5_out 		( EX_MEM_mux5_out 		),
        .mux6_out        		( mux6_out        		),

        //output
        .mux8_out        		( mux8_out        		)

        //inout
    );

    

    mux9 u_mux9(
        //input
        .Forward1B       		( Forward1B       		),
        .regfile_out2    		( regfile_out2    		),
        .EX_MEM_mux5_out 		( EX_MEM_mux5_out 		),
        .mux6_out        		( mux6_out        		),

        //output
        .mux9_out        		( mux9_out        		)
    );

    

    BU #(
        .BEQ       		( 4'b0000                            		),
        .BNE       		( 4'b0001                            		),
        .BGEZ      		( 4'b0010                            		),
        .BGTZ      		( 4'b0011                            		),
        .BLEZ      		( 4'b0100                            		),
        .BLTZ      		( 4'b0101                            		),
        .BGEZAL    		( 4'b0110                            		),
        .BLTZAL    		( 4'b0111                            		),
        .NO_BRANCH 		( 4'b1000                            		))
    u_BU(
        //input
        .Branch   		( Branch   		),
        .mux8_out 		( mux8_out 		),
        .mux9_out 		( mux9_out 		),

        //output
        .BU_out   		( BU_out   		)
    );


    ForwardUnit1 u_ForwardUnit1(
        //input
        .rs              		( IF_ID_im_out[25:21]  	),
        .rt              		( IF_ID_im_out[20:16]  	),
        .EX_MEM_RegWrite 		( EX_MEM_RegWrite 		),
        .EX_MEM_mux1_out 		( EX_MEM_mux1_out 		),
        .MEM_WB_RegWrite 		( MEM_WB_RegWrite 		),
        .MEM_WB_mux1_out 		( MEM_WB_mux1_out 		),

        //output
        .Forward1A       		( Forward1A       		),
        .Forward1B       		( Forward1B       		)
    );

    // EX module
    ID_EX u_ID_EX(
        //input
        .clock            		( clock            		),
        .reset            		( reset            		),
        .mux7_LS_bit      		( mux7_LS_bit      		),
        .mux7_RegDst      		( mux7_RegDst      		),
        .mux7_DataDst     		( mux7_DataDst     		),
        .mux7_MemtoReg    		( mux7_MemtoReg    		),
        .mux7_ALUOp       		( mux7_ALUOp       		),
        .mux7_MemWrite    		( mux7_MemWrite    		),
        .mux7_ALUSrc      		( mux7_ALUSrc      		),
        .mux7_ShamtSrc    		( mux7_ShamtSrc    		),
        .mux7_RegWrite    		( mux7_RegWrite    		),
        .mux7_Ext_op      		( mux7_Ext_op      		),
        .mux7_ExcCode     		( mux7_ExcCode     		),
        .low_out          		( low_out          		),
        .high_out         		( high_out         		),
        .IF_ID_pc_add_out 		( IF_ID_pc_add_out 		),
        .mux8_out         		( mux8_out         		),
        .mux9_out         		( mux9_out         		),
        .Ext_out          		( Ext_out          		),
        .instr26     		    ( IF_ID_im_out[25: 0]   ),

        //output
        .ID_EX_LS_bit     		( ID_EX_LS_bit     		),
        .ID_EX_RegDst     		( ID_EX_RegDst     		),
        .ID_EX_DataDst    		( ID_EX_DataDst    		),
        .ID_EX_MemtoReg   		( ID_EX_MemtoReg   		),
        .ID_EX_ALUOp      		( ID_EX_ALUOp      		),
        .ID_EX_MemWrite   		( ID_EX_MemWrite   		),
        .ID_EX_ALUSrc     		( ID_EX_ALUSrc     		),
        .ID_EX_ShamtSrc   		( ID_EX_ShamtSrc   		),
        .ID_EX_RegWrite   		( ID_EX_RegWrite   		),
        .ID_EX_Ext_op     		( ID_EX_Ext_op     		),
        .ID_EX_ExcCode    		( ID_EX_ExcCode    		),
        .ID_EX_low_out    		( ID_EX_low_out    		),
        .ID_EX_high_out   		( ID_EX_high_out   		),
        .ID_EX_pc_add_out 		( ID_EX_pc_add_out 		),
        .ID_EX_mux8_out   		( ID_EX_mux8_out   		),
        .ID_EX_mux9_out   		( ID_EX_mux9_out   		),
        .ID_EX_Ext_out    		( ID_EX_Ext_out    		),
        .ID_EX_instr26    		( ID_EX_instr26    		)
    );

    

    ForwardUnit3 u_ForwardUnit3(
        //input
        .EX_MEM_RegWrite 		( EX_MEM_RegWrite 		),
        .EX_MEM_mux1_out 		( EX_MEM_mux1_out 		),
        .MEM_WB_RegWrite 		( MEM_WB_RegWrite 		),
        .MEM_WB_mux1_out 		( MEM_WB_mux1_out 		),
        .EX_MEM_prod     		( EX_MEM_prod     		),
        .MEM_WB_prod     		( MEM_WB_prod     		),

        //output
        .Forward3A       		( Forward3A       		),
        .Forward3B       		( Forward3B       		)

        //inout
    );

    

    mux11 u_mux11(
        //input
        .Forward3A      		( Forward3A      		),
        .ID_EX_low_out  		( ID_EX_low_out  		),
        .EX_MEM_mux5_out 		( EX_MEM_mux5_out 		),
        .MEM_WB_mux5_out 		( MEM_WB_mux5_out 		),
        .EX_MEM_prod    		( EX_MEM_prod    		),
        .MEM_WB_prod    		( MEM_WB_prod    		),

        //output
        .mux11_out      		( mux11_out      		)

        //inout
    );

    

    mux12 u_mux12(
        //input
        .Forward3B      		( Forward3B      		),
        .ID_EX_high_out 		( ID_EX_high_out 		),
        .EX_MEM_mux5_out 		( EX_MEM_mux5_out 		),
        .MEM_WB_mux5_out 		( MEM_WB_mux5_out 		),
        .EX_MEM_prod    		( EX_MEM_prod    		),
        .MEM_WB_prod    		( MEM_WB_prod    		),

        //output
        .mux12_out      		( mux12_out      		)

        //inout
    );

    mux2 u_mux2(
        //input
        .Forward2A       		( Forward2A       		),
        .ID_EX_mux8_out  		( ID_EX_mux8_out  		),
        .mux6_out        		( mux6_out        		),
        .EX_MEM_mux5_out 		( EX_MEM_mux5_out 		),

        //output
        .mux2_out        		( mux2_out        		)
    );


    mux3 u_mux3(
        //input
        .Forward2B       		( Forward2B       		),
        .ID_EX_mux9_out  		( ID_EX_mux9_out  		),
        .mux6_out        		( mux6_out        		),
        .EX_MEM_mux5_out 		( EX_MEM_mux5_out 		),

        //output
        .mux3_out        		( mux3_out        		)
    );

    
    mux4 u_mux4(
        //input
        .ID_EX_ALUSrc  		( ID_EX_ALUSrc  		),
        .ID_EX_Ext_out 		( ID_EX_Ext_out 		),
        .mux3_out      		( mux3_out      		),

        //output
        .mux4_out      		( mux4_out      		)
    );

    
    alu_ctrl #(
        .USE_R_TYPE     		( 4'b0000                   		),
        .USE_ADD        		( 4'b0001                   		),
        .USE_ADDU       		( 4'b0010                   		),
        .USE_SUB        		( 4'b0011                   		),
        .USE_SUBU       		( 4'b0100                   		),
        .USE_SLT        		( 4'b0101                   		),
        .USE_SLTU       		( 4'b0110                   		),
        .USE_AND        		( 4'b0111                   		),
        .USE_OR         		( 4'b1000                   		),
        .USE_NOR        		( 4'b1001                   		),
        .USE_XOR        		( 4'b1010                   		),
        .USE_LUI        		( 4'b1011                   		),
        .ADD_OP         		( 5'b00000                  		),
        .ADDU_OP        		( 5'b00001                  		),
        .SUB_OP         		( 5'b00010                  		),
        .SUBU_OP        		( 5'b00011                  		),
        .STL_OP         		( 5'b00100                  		),
        .STLU_OP        		( 5'b00101                  		),
        .MULT_OP        		( 5'b00110                  		),
        .MULTU_OP       		( 5'b00111                  		),
        .DIV_OP         		( 5'b01000                  		),
        .DIVU_OP        		( 5'b01001                  		),
        .AND_OP         		( 5'b01010                  		),
        .OR_OP          		( 5'b01011                  		),
        .NOR_OP         		( 5'b01100                  		),
        .XOR_OP         		( 5'b01101                  		),
        .LUI_OP         		( 5'b01110                  		),
        .SLL_OP         		( 5'b01111                  		),
        .SRL_OP         		( 5'b10000                  		),
        .SRA_OP         		( 5'b10001                  		),
        .MTHI_OP        		( 5'b10010                  		),
        .MTLO_OP        		( 5'b10011                  		),
        .funct_is_ADD   		( 6'b100000                 		),
        .funct_is_ADDU  		( 6'b100001                 		),
        .funct_is_SUB   		( 6'b100010                 		),
        .funct_is_SUBU  		( 6'b100011                 		),
        .funct_is_SLT   		( 6'b101010                 		),
        .funct_is_SLTU  		( 6'b101011                 		),
        .funct_is_MULT  		( 6'b011000                 		),
        .funct_is_MULTU 		( 6'b011001                 		),
        .funct_is_DIV   		( 6'b011010                 		),
        .funct_is_DIVU  		( 6'b011011                 		),
        .funct_is_AND   		( 6'b100100                 		),
        .funct_is_OR    		( 6'b100101                 		),
        .funct_is_NOR   		( 6'b100111                 		),
        .funct_is_XOR   		( 6'b100110                 		),
        .funct_is_SLL   		( 6'b000000                 		),
        .funct_is_SLLV  		( 6'b000100                 		),
        .funct_is_SRL   		( 6'b000010                 		),
        .funct_is_SRLV  		( 6'b000110                 		),
        .funct_is_SRA   		( 6'b000011                 		),
        .funct_is_SRAV  		( 6'b000111                 		),
        .funct_is_MTHI  		( 6'b010001                 		),
        .funct_is_MTLO  		( 6'b010011                 		))
    u_alu_ctrl(
        //input
        .ID_EX_ALUOp   		( ID_EX_ALUOp   		),
        .ID_EX_instr26 		( ID_EX_instr26 		),

        //output
        .alu_ctrl_out  		( alu_ctrl_out  		)

        //inout
    );

    alu #(
        .ADD_OP   		( 5'b00000     		),
        .ADDU_OP  		( 5'b00001     		),
        .SUB_OP   		( 5'b00010     		),
        .SUBU_OP  		( 5'b00011     		),
        .SLT_OP   		( 5'b00100     		),
        .SLTU_OP  		( 5'b00101     		),
        .MULT_OP  		( 5'b00110     		),
        .MULTU_OP 		( 5'b00111     		),
        .DIV_OP   		( 5'b01000     		),
        .DIVU_OP  		( 5'b01001     		),
        .AND_OP   		( 5'b01010     		),
        .OR_OP    		( 5'b01011     		),
        .NOR_OP   		( 5'b01100     		),
        .XOR_OP   		( 5'b01101     		),
        .LUI_OP   		( 5'b01110     		),
        .SLL_OP   		( 5'b01111     		),
        .SRL_OP   		( 5'b10000     		),
        .SRA_OP   		( 5'b10001     		),
        .MTHI_OP  		( 5'b10010     		),
        .MTLO_OP  		( 5'b10011     		))
    u_alu(
        //input
        .clock        		( clock        		),
        .reset        		( reset        		),
        .alu_ctrl_out 		( alu_ctrl_out 		),
        .op1          		( mux2_out     		),
        .op2          		( mux4_out    		),
        .shamt        		( mux10_out    		),

        //output
        .alu_out      		( alu_out      		),
        .prod         		( prod         		),
        .overflow     		( overflow     		),
        .divideZero   		( divideZero   		)
    );

    

    mux1 #(
        .RT   		( 3'b000                                		),
        .RD   		( 3'b001                                		),
        .RA   		( 3'b010                                		),
        .HI   		( 3'b011                                		),
        .LO   		( 3'b100                                		),
        .PROD 		( 3'b101                                		))
    u_mux1(
        //input
        .ID_EX_RegDst  		( ID_EX_RegDst  		),
        .ID_EX_instr26 		( ID_EX_instr26 		),

        //output
        .mux1_out      		( mux1_out      		)
    );

    

    mux10 u_mux10(
        //input
        .ShamtSrc      		( ShamtSrc      		),
        .ID_EX_instr26 		( ID_EX_instr26 		),
        .mux2_out      		( mux2_out[ 4: 0] 		),

        //output
        .mux10_out     		( mux10_out     		)
    );


    ForwardUnit2 u_ForwardUnit2(
        //input
        .ID_EX_rs        		( ID_EX_instr26[25:21]  ),
        .ID_EX_rt        		( ID_EX_instr26[20:16]  ),
        .EX_MEM_RegWrite 		( EX_MEM_RegWrite 		),
        .EX_MEM_mux1_out 		( EX_MEM_mux1_out 		),
        .MEM_WB_RegWrite 		( MEM_WB_RegWrite 		),
        .MEM_WB_mux1_out 		( MEM_WB_mux1_out 		),

        //output
        .Forward2A       		( Forward2A       		),
        .Forward2B       		( Forward2B       		)
    );

    

    mux5 u_mux5(
        //input
        .ID_EX_DataDst    		( ID_EX_DataDst    		),
        .mux11_out    		( mux11_out    		),
        .mux12_out   		( mux12_out   		),
        .ID_EX_pc_add_out 		( ID_EX_pc_add_out 		),
        .alu_out          		( alu_out          		),

        //output
        .mux5_out         		( mux5_out         		)
    );

    /*
        MEM module
    */
    

    EX_MEM u_EX_MEM(
        //input
        .clock           		( clock           		),
        .reset           		( reset           		),
        .ID_EX_LS_bit    		( ID_EX_LS_bit    		),
        .ID_EX_MemtoReg  		( ID_EX_MemtoReg  		),
        .ID_EX_MemWrite  		( ID_EX_MemWrite  		),
        .ID_EX_RegWrite  		( ID_EX_RegWrite  		),
        .ID_EX_Ext_op    		( ID_EX_Ext_op    		),
        .prod            		( prod            		),
        .mux5_out        		( mux5_out        		),
        .mux3_out        		( mux3_out        		),
        .mux1_out        		( mux1_out        		),

        //output
        .EX_MEM_LS_bit   		( EX_MEM_LS_bit   		),
        .EX_MEM_MemtoReg 		( EX_MEM_MemtoReg 		),
        .EX_MEM_MemWrite 		( EX_MEM_MemWrite 		),
        .EX_MEM_RegWrite 		( EX_MEM_RegWrite 		),
        .EX_MEM_Ext_op   		( EX_MEM_Ext_op   		),
        .EX_MEM_prod     		( EX_MEM_prod     		),
        .EX_MEM_mux5_out 		( EX_MEM_mux5_out 		),
        .EX_MEM_mux3_out 		( EX_MEM_mux3_out 		),
        .EX_MEM_mux1_out 		( EX_MEM_mux1_out 		)
    );



    wire [31: 0] 	dm_out;

    dm_8k #(
        .NONE 		( 2'b00 		),
        .WORD 		( 2'b01 		),
        .HALF 		( 2'b10 		),
        .BYTE 		( 2'b11 		))
    u_dm_8k(
        //input
        .clock           		( clock           		),
        .reset           		( reset           		),
        .EX_MEM_LS_bit   		( EX_MEM_LS_bit   		),
        .EX_MEM_MemWrite 		( EX_MEM_MemWrite 		),
        .EX_MEM_Ext_op   		( EX_MEM_Ext_op   		),
        .EX_MEM_mux5_out 		( EX_MEM_mux5_out 		),
        .EX_MEM_mux3_out 		( EX_MEM_mux3_out 		),

        //output
        .dm_out          		( dm_out          		)
    );

    

    MEM_WB u_MEM_WB(
        //input
        .clock           		( clock           		),
        .reset           		( reset           		),
        .EX_MEM_MemtoReg 		( EX_MEM_MemtoReg 		),
        .EX_MEM_RegWrite 		( EX_MEM_RegWrite 		),
        .dm_out          		( dm_out          		),
        .EX_MEM_mux5_out 		( EX_MEM_mux5_out 		),
        .EX_MEM_mux1_out 		( EX_MEM_mux1_out 		),
        .EX_MEM_prod     		( EX_MEM_prod     		),

        //output
        .MEM_WB_MemtoReg 		( MEM_WB_MemtoReg 		),
        .MEM_WB_RegWrite 		( MEM_WB_RegWrite 		),
        .MEM_WB_dm_out   		( MEM_WB_dm_out   		),
        .MEM_WB_mux5_out 		( MEM_WB_mux5_out 		),
        .MEM_WB_mux1_out 		( MEM_WB_mux1_out 		),
        .MEM_WB_prod     		( MEM_WB_prod     		)
    );


    mux6 u_mux6(
        //input
        .MEM_WB_MemtoReg 		( MEM_WB_MemtoReg 		),
        .MEM_WB_dm_out   		( MEM_WB_dm_out   		),
        .MEM_WB_mux5_out 		( MEM_WB_mux5_out 		),

        //output
        .mux6_out        		( mux6_out        		)
    );

endmodule // datapath
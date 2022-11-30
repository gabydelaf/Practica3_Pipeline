/******************************************************************
* Description
*	This is control unit for the RISC-V Microprocessor. The control unit is 
*	in charge of generation of the control signals. Its only input 
*	corresponds to opcode from the instruction bus.
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	16/08/2021
******************************************************************/
module Control
(
	input [6:0]OP_i,
	input disable_i,
	
	output reg Branch_o,
	output reg Mem_Read_o,
	output reg Mem_to_Reg_o,
	output reg Mem_Write_o,
	output reg ALU_Src_o,
	output reg Reg_Write_o,
	output reg [2:0]ALU_Op_o
);

localparam R_Type				= 7'h33;
localparam I_Type_LOGIC 	= 7'h13;
localparam U_Type				= 7'h37;
localparam I_Type			 	= 7'h03;//tipo para lw
localparam S_Type				= 7'h23;//tipo s para sw
localparam SB_Type			= 7'h63;//tipo para branches
localparam I_Type_JALR		= 7'h67;//tipo para JALR
localparam UJ_Type			= 7'h6F;//tipo para JAL

reg [8:0] control_values;

always@(OP_i) begin
	case(OP_i)//                         876_54_3_210
		
		R_Type: 			control_values= 9'b001_00_0_000;
		I_Type_LOGIC: 	control_values= 9'b001_00_1_001;
		U_Type:			control_values= 9'b001_00_1_010;
		I_Type:			control_values= 9'b011_10_1_011;//valores de control para lw
		S_Type:			control_values= 9'b000_01_1_100;//valores de control para tipo S
		SB_Type:			control_values= 9'b100_00_1_101;//gen inmediato y branch encendido
		I_Type_JALR:	control_values= 9'b101_00_1_110;//branch encendido e inmediato encendido, escribir en registro
		UJ_Type:			control_values= 9'b101_00_1_111;
		
		default:
			control_values= 9'b000_00_000;
		endcase
end	


always@(disable_i, control_values)
	begin
		if(disable_i)	
			begin
			Branch_o = 0;
			Mem_to_Reg_o = 0;
			Reg_Write_o = 0;
			Mem_Read_o = 0;
			Mem_Write_o = 0;
			ALU_Src_o = 0;
			ALU_Op_o = 0;	
			
			end
		else
			begin
				Branch_o = control_values[8];

				Mem_to_Reg_o = control_values[7];

				Reg_Write_o = control_values[6];

				Mem_Read_o = control_values[5];

				Mem_Write_o = control_values[4];

				ALU_Src_o = control_values[3];
					
				ALU_Op_o = control_values[2:0];	
			end
	end
endmodule



/******************************************************************
* Description
*	This is a register that is used for implementing pipeline stall 
*	1.0
* Author:
*	Gabriela de la Fuente & Daniel Gutiérrez
******************************************************************/
module Register_ID_EX
#(
	parameter N = 32
)
(
	input clk,
	input reset,
	input reset_hazard,
	input enable,
	input branch, //entrada del branch control
	input [6:0] OP_i,//entrada para el branch control
	input [2:0] funct3_i, //entrada del branch control
	
	output reg [6:0] OP_o,//salida para el branch control
	output reg [2:0] funct3_o, //salida para branch control
	

	input mem_read,
	input mem_write,
	input  [N-1:0] pc,
	input  [N-1:0] DataInput1,
	input  [N-1:0] DataInput2,
	input  [N-1:0] imm,
	input	 [3:0] alu_op,
	input  [N-1:0] pc4,
	input src,

	input Reg_Write_i,
	input	[4:0] write_register_i,
	input [4:0] rs1_i,
	input [4:0] rs2_i,
	
	output reg [4:0] rs1_o,
	output reg [4:0] rs2_o,
	output reg [4:0] write_register_o,
	output reg Reg_Write_o,

	output reg src_o,
	output reg [N-1:0] pc4_o,
	
	output reg [3:0] alu_op_o,
	output reg branch_o,
	output reg mem_read_o,
	output reg mem_write_o,
	output reg [N-1:0] pc_o,
	output reg [N-1:0] DataOutput1,
	output reg [N-1:0] DataOutput2,
	output reg [N-1:0] imm_o
);

always@(negedge reset or negedge clk) begin
	if(reset==0)
		begin
		pc_o <= 0;
		DataOutput1<=0;
		DataOutput2<=0;
		imm_o<=0;
		alu_op_o<=0;
		branch_o<=0;
		mem_read_o<=0;
		mem_write_o<=0;
		pc4_o<=0;
		src_o<=0;
		Reg_Write_o <= 0;
		write_register_o<=0;
		rs1_o<=0;
		rs2_o<=0;
		funct3_o<=0;
		OP_o<=0;
		end
	else
		if(reset_hazard==1)
			begin
			pc_o <= 0;
			DataOutput1<=0;
			DataOutput2<=0;
			imm_o<=0;
			alu_op_o<=0;
			branch_o<=0;
			mem_read_o<=0;
			mem_write_o<=0;
			pc4_o<=0;
			src_o<=0;
			Reg_Write_o <= 0;
			write_register_o<=0;
			rs1_o<=0;
			rs2_o<=0;
			funct3_o<=0;
			OP_o<=0;
			end
			
	else	
		if(enable==1)
			begin
			pc_o<=pc;
			DataOutput1<=DataInput1;
			DataOutput2<=DataInput2;
			imm_o<=imm;
			alu_op_o<=alu_op;
			branch_o<=branch;
			mem_read_o<=mem_read;
			mem_write_o<=mem_write;
			pc4_o<=pc4;
			src_o<=src;
			Reg_Write_o<=Reg_Write_i;
			write_register_o<=write_register_i;
			rs1_o<=rs1_i;
			rs2_o<=rs2_i;
			funct3_o<=funct3_i;
			OP_o<=OP_i;
			end
end

endmodule
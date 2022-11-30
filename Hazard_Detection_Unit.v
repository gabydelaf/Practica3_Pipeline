/******************************************************************
* Description
*	This is a register that is used for implementing Forwarding Unit
*	1.0
* Author:
*	Gabriela de la Fuente & Daniel Gutiérrez
******************************************************************/
module Hazard_Detection_Unit
(	
	input MemRead_EX_i,
	input branch_i,
	input [4:0] rd_EX_i,
	input [4:0] rs1_ID_i,
	input [4:0] rs2_ID_i,
	
	output reg disable_control,
	output reg disable_pc,
	output reg enable_IF_ID,
	
	output reg reset_IF_ID,
	output reg reset_ID_EX,
	output reg reset_EX_MEM
	
);

always @(MemRead_EX_i,rd_EX_i, rs1_ID_i, rs2_ID_i)//always para checar dependencia de rs1 o rs2 en un lw
	begin
	if((MemRead_EX_i == 1) && (rd_EX_i != 0) && ((rs1_ID_i == rd_EX_i) || (rs2_ID_i == rd_EX_i)))
	
			begin
				disable_control = 1; //habilitar disables, deshabilitar enable xD
				disable_pc = 1;
				enable_IF_ID = 0;
			end

	else
		begin
		disable_control = 0; //se queda todo igual si no hay dependencia
		disable_pc = 0;
		enable_IF_ID = 1;
		end
		
	end
	
always @(branch_i) //always para checar si hay un branch
	begin
		if(branch_i == 1) //si hay resetear los registros
			begin
				reset_IF_ID = 1;
				reset_ID_EX = 1;
				reset_EX_MEM = 1;
			end
		else
			begin  			//si no, no xD
				reset_IF_ID = 0;
				reset_ID_EX = 0;
				reset_EX_MEM = 0;
			end
	
	end
   

endmodule
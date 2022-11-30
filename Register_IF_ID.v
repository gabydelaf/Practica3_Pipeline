/******************************************************************
* Description
*	This is a register that is used for implementing pipeline stall 
*	1.0
* Author:
*	Gabriela de la Fuente & Daniel Gutiérrez
******************************************************************/
module Register_IF_ID
#(
	parameter N = 32
)
(
	input clk,
	input reset,
	input reset_hazard,
	input enable,
	input  [N-1:0] pc,	//PC
	input  [N-1:0] inst_bus,	//Instruction_BUS
	input  [N-1:0] pc4,
	
	output reg [N-1:0] pc4_o,
	output reg [N-1:0] pc_o,
	output reg [N-1:0] inst_bus_o
);


always@(negedge reset or negedge clk) begin
	if(reset==0)
		begin
		pc_o <= 0;
		inst_bus_o <= 0;
		pc4_o <= 0;
		end
	else
		if(reset_hazard==1)//si hay reset de hazard : flush síncrono
		begin
		pc_o <= 0;
		inst_bus_o <= 0;
		pc4_o <= 0;
		end
	else	
		if(enable==1)
		begin
			pc_o<=pc; //funciona cada flanco de bajada, toma los datos de entrada
			inst_bus_o<=inst_bus;
			pc4_o<=pc4;
		end
end


endmodule
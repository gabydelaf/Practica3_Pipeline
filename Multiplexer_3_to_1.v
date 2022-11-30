/******************************************************************
* Description
*	This is a register that is used for implementing pipeline stall 
*	1.0
* Author:
*	Gabriela de la Fuente & Daniel Gutiérrez
******************************************************************/

module Multiplexer_3_to_1
#(
	parameter NBits = 32
)
(   
	input [1:0]Selector_i,
	input [NBits-1:0] Mux_Data_0_i,
	input [NBits-1:0] Mux_Data_1_i,
	input [NBits-1:0] Mux_Data_2_i,

	output reg [NBits-1:0] Mux_Output_o

);



always@(Selector_i,Mux_Data_2_i  ,Mux_Data_1_i ,Mux_Data_0_i) 
begin
		if(Selector_i== 2'b01)
			Mux_Output_o = Mux_Data_1_i;
		else if(Selector_i== 2'b10)
			Mux_Output_o = Mux_Data_2_i;
		else
			Mux_Output_o = Mux_Data_0_i;
	end
endmodule

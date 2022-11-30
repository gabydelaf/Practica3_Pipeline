/******************************************************************
* Description
*	This is a register that is used for implementing Forwarding Unit
*	1.0
* Author:
*	Gabriela de la Fuente & Daniel Gutiérrez
******************************************************************/
module Forwarding_Unit
(
	input RegWrite_MEM_i,
	input RegWrite_WB_i,
	input [4:0] rd_MEM_i,
	input [4:0] rd_WB_i,
	input [4:0] rs1_i,
	input [4:0] rs2_i,
	
	output reg [1:0] sel_rs1,
	output reg [1:0] sel_rs2
	
);


always@(RegWrite_MEM_i, RegWrite_WB_i, sel_rs1, rs1_i, rd_MEM_i, rd_WB_i)begin //always para checar si hay dependencia
      
       if(rs1_i == rd_MEM_i && rd_MEM_i != 0 && RegWrite_MEM_i != 0)  
            sel_rs1 = 2'b01; //si rs1 coincide con rd de MEM y rd de MEM es !=0, opción 1
       else if(rs1_i == rd_WB_i && rd_WB_i != 0 && RegWrite_WB_i != 0)
            sel_rs1 = 2'b10; //si rs2 coincide con rd de WB y es diferente de 0, opción 2
        else
            sel_rs1 = 2'b00;
end


 always@(RegWrite_MEM_i, RegWrite_WB_i, sel_rs2, rs2_i, rd_MEM_i, rd_WB_i)begin

       if(rs2_i == rd_MEM_i && rd_MEM_i != 0 && RegWrite_MEM_i != 0)
            sel_rs2 = 2'b01;//si rs2 coincide con rd de MEM y rd de MEM es !=0, opción 1
       else if(rs2_i == rd_WB_i && rd_WB_i != 0 && RegWrite_WB_i != 0)
            sel_rs2 = 2'b10;//si rs2 coincide con rd de MEM y rd de MEM es !=0, opción 2
        else
            sel_rs2 = 2'b00; //si no hay dependencia opción 0
end


endmodule
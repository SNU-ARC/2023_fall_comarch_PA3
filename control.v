/*-----------------------------------------------------------------------------

4190.308-001 Computer Architecture

Instructor: Prof. Jae W. Lee (jaewlee@snu.ac.kr)

Homework #3: RISC-V Pipeline in Verilog

Description:
	Pipeline control signal generator

-----------------------------------------------------------------------------*/

module pipeline_ctl
(
	//From ID unit: opcode and register
	input [6:0] opcode,
	input [2:0] funct3,
	input [6:0] funct7,
	input hazarded, // for control hazard mux

	//To others-
	output reg alu_src,
	output reg mem_to_reg,
	output reg reg_write,
	output reg mem_read,
	output reg mem_write,
	output reg [2:0] alu_operation,
	output reg halt
);
	//Operator 
	parameter R_FORMAT	= 7'b0110011;
	parameter I_FORMAT	= 7'b0010011;
	parameter LOAD		= 7'b0000011;
	parameter STORE		= 7'b0100011;
	parameter SB 			= 7'b1100011;

	always @(opcode, funct3, funct7)
	begin
	    if(opcode == R_FORMAT)
		begin
			alu_src <= 1'b0;
			mem_to_reg <= 1'b0;
			reg_write <= 1'b1;
			mem_read <= 1'b0;
			mem_write <= 1'b0;
			halt <= 1'b0;
			alu_operation <= (funct3 != 3'b000) ? (funct3==3'b111 ? alu.BIT_AND : 
					(funct3==3'b110 ? alu.BIT_OR : (funct3==3'b100 ? alu.BIT_XOR :alu.ALU_NOP))
					):
					(funct7 == 7'h20 ? alu.SUB_64 : (funct7 == 7'h0 ? alu.ADD_64 : alu.ALU_NOP));
		end
		else if(opcode == I_FORMAT)
		begin
			alu_src <= 1'b1;
			mem_to_reg <= 1'b0;
			reg_write <= 1'b1;
			mem_read <= 1'b0;
			mem_write <= 1'b0;
			halt <= 1'b0;
			alu_operation <= ((funct3 != 3'b000) ? (funct3 == 3'b111 ? alu.BIT_AND : 
			(funct3 == 3'b110 ? alu.BIT_OR : (funct3 == 3'b100 ? alu.BIT_XOR : alu.ALU_NOP))): alu.ADD_64);
		end
		else if(opcode == LOAD)
		begin
			alu_src <= 1'b1;	
			mem_to_reg <= 1'b1;
			reg_write <= 1'b1;
			mem_read <= 1'b1;
			mem_write <= 1'b0;
			halt <= 1'b0;
			alu_operation <= alu.ADD_64;
		end
		else if(opcode == STORE)
		begin
			alu_src <= 1'b1;
			mem_to_reg <= 1'bx;
			reg_write <= 1'b0;
			mem_read <= 1'b0;
			mem_write <= 1'b1;
			halt <= 1'b0;
			alu_operation <= alu.ADD_64;

		end
		else if(opcode == 7'h0)	//NOP
		begin
			alu_src <= 1'b0;
			mem_to_reg <= 1'b0;
			reg_write <= 1'b0;
			mem_read <= 1'b0;
			mem_write <= 1'b0;
			halt <= 1'b0;
			alu_operation <= alu.ALU_NOP;
			
		end
		else	//HALT
		begin
			halt <= 1'b1;
			mem_write <= 1'b0;
		end
	end

endmodule

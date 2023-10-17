/*-----------------------------------------------------------------------------

4190.308-001 Computer Architecture

Instructor: Prof. Jae W. Lee (jaewlee@snu.ac.kr)

Homework #3: RISC-V Pipeline in Verilog

Description:
	Instruction decoding unit.

-----------------------------------------------------------------------------*/

module inst_decoder
(
	input [31:0] inst,

	output [6:0] opcode,
	output [2:0] funct3,
	output [6:0] funct7,

	output [4:0] rs1,
	output [4:0] rs2,
	output [4:0] rd,

	output [63:0] imm64
);

	wire [51:0] sign_extended;

	//Unchanged across instruction type
	assign opcode = inst[6:0];
	assign funct3 = inst[14:12];
	assign funct7 = inst[31:25];

	assign rs1 = inst[19:15];
	assign rs2 = inst[24:20];
	assign rd = inst[11:7];


	//OPcode
	//R, I, S, U
	//I: 31:20 Sext
	//S: 31:25 - 11:7 Sext
	
	//0110011(R): Add, Sub, And, Or, Xor, Slt, Sltu, SRA
	//0010011(I): Addi, Andi, Ori, Xori, Slti, Sltiu
	//0000011(I): LW
	//0100011(S): SW
	//1100011(S): Beq, Bne, Blt, Bge, Bltu, Bgeu

	assign sign_extended = inst[31] ? 52'hfffffffffffff : 52'h0;
	assign imm64 =	((opcode == 7'b0110011) ? 64'h0 : 				//R type (IMM = DC)
			((opcode[6:5] == 2'b00) ? {sign_extended, inst[31:20]} :	//I type
			{sign_extended, inst[31:25], inst[11:7]}));			//SW: S type, I-imm
	
endmodule


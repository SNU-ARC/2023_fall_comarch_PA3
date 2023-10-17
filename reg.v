/*-----------------------------------------------------------------------------

4190.308-001 Computer Architecture

Instructor: Prof. Jae W. Lee (jaewlee@snu.ac.kr)

Homework #3: RISC-V Pipeline in Verilog

Description:
	64-bit register file for RISC-V pipeline.

-----------------------------------------------------------------------------*/

module reg_file
(
	input clk,
	input [4:0] rs1,
	input [4:0] rs2,
	output [63:0] rs1_data,
	output [63:0] rs2_data,

	input [4:0] rd,
	input write,
	input [63:0] write_data
);

	reg [63:0] registers[31:1];

	always @(posedge clk)
	begin
		if(rd != 0 && write)
		begin
			$display("reg[%d] = 0x%x", rd, write_data);
			registers[rd] <= write_data;
		end
	end

	assign rs1_data = ((rs1 != 0) ? registers[rs1] : 64'h0);
	assign rs2_data = ((rs2 != 0) ? registers[rs2] : 64'h0);

endmodule

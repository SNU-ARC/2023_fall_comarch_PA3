/*-----------------------------------------------------------------------------

4190.308-001 Computer Architecture

Instructor: Prof. Jae W. Lee (jaewlee@snu.ac.kr)

Homework #3: RISC-V Pipeline in Verilog

Description:
	This top module provides initial reset signal.

-----------------------------------------------------------------------------*/

module tb();

	reg clk;
	reg reset;

	riscv_pipeline uut(.clk(clk), .reset(reset));

	initial
	begin
		clk <= 1;
		reset <= 1;
		#3;
		reset <= 0;
	end

	always #5 clk <= ~clk;

endmodule

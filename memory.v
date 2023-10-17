/*-----------------------------------------------------------------------------

4190.308-001 Computer Architecture

Instructor: Prof. Jae W. Lee (jaewlee@snu.ac.kr)

Homework #3: RISC-V Pipeline in Verilog

Description:
	rom64 module is simple 64-bit ROM for instruction memory.
	Output bit width is 32-bit for convinience.
	
	mem64 module is a simple memory module for data load/store

-----------------------------------------------------------------------------*/


module rom64
(
	input	[63:0] address,
	output	[31:0] data_out
);
	parameter FILE = "sample1.dat";
	parameter ROM64_BITMASK = 64'h1fc;

	reg	[31:0] data[127:0];	//address 8:2 is offset

	initial
	begin
		//Read inst memory file.
		$readmemh(rom64.FILE, data);
	end

	//64'h1fc: Bitmask for 8:2
	assign data_out = (address & (~(ROM64_BITMASK))) ? 32'h0 : data[address[8:2]];


endmodule

module mem64
(
	input	clk,
	input	write_enable,
	input	halt,

	input	[63:0] address,	//64-bit align required.
	input	[63:0] write_data,
	output	[63:0] read_data
);
	parameter FILE = "data.dat";
	parameter MEM64_BITMASK = 64'hf8;

	reg	[64:0] data[31:0];
	reg finish;

	initial
	begin
		//Read data memory file
		$readmemh(mem64.FILE, data);
	end

    // We need to wait one cycle to finish write-back stage.
	always @(posedge clk)
	begin
	   if(halt) finish <= 1;
	   if(finish) $finish;
	end
	
	always @(posedge clk)
	begin
		if(write_enable && (!(address & (~MEM64_BITMASK))))
		begin
			$display("M[%d] = 0x%x", address[7:3], write_data);
			data[address[7:3]] = write_data;
		end
	end

	//64'hf8: Bitmask for 7:3
	assign read_data = ((address & (~MEM64_BITMASK)) || write_enable) ? 64'h0 : data[address[7:3]];

endmodule

# 2023_fall_comarch_PA3

Code Description

1. alu.v
- Implementation of alu
- AND, OR, XOR, ADD, SUB Operations are supported

2. control.v
- Implementation of control unit
- AND(i) / OR(i) / XOR(i) / ADD(i) / SUB / Load / Store Instructions are supported

3. inst_decoder.v
- Implementation of instruction decoder
- AND(i) / OR(i) / XOR(i) / ADD(i) / SUB / Load / Store Instructions are supported
  
4. memory.v
- Implementation of data memory and instruction memroy
- Instruction Load / Data Load / Data Store function are supported

5. reg.v
- Implementation of register
- We assume that write is in the first half of the clock cycle,
and the read is in the second half, so the read delivers what is written

6. riscv_pipeline.v
- Implementation of base pipeline

7. tb.v
- Implementation of reference clock and reset signal

Test bench Description

- sample test bench : sample1.dat, sample2.dat, sample3.dat, sample4.dat
- evaulation test bench : branch.dat, dhazard.dat, perf1.dat, perf2.dat, perf3.dat

Helper program (riscv-assembler.tar)
- It converts code written in RISC-V assembly into binary format 

For more detailed explanations, please refer to the provided materials related to PA3

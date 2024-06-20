TODO: reg zero is const 0.

requisites:

alu: 2 in 16 bits, 1 out 16 bits, (flags), sel 2 bits,
     4 op including add, sub, no div;

regs: clk, rst, wr_en only, in 16 bits, out 16 bits;
bank: 2 sel_r 3 bits, 1 sel_wr 3 bits, in 16 bits, wr_en, clk, rst,
      2 out 16 bits; reg zero is const 0;
connect: alu_out -> bank_in, bank_out_a -> alu_in_a,
         (bank_out_b, toplevel const) -> mux -> alu_in_b,
         toplevel <-> clk, rst, wr_en, alu_out;
* adapt to acc!

rom: clk, addr 7 bits, out 12 bits;
states: fetch (read rom), decode/execute (update pc);
connect: pc_out -> uc (+1) -> pc_in, pc_out -> rom_addr, rom_out -> toplevel;
instrs: nop, jump (abs addr)

regs: instr;
rom: update to 16 bits;
states: fetch (read rom to instr reg), decode, execute;
instrs: 4 alu, li, mov, jump, nop;
opcodes: document;
top level: rst, clk, state, pc, instr_out, regs_out, acc_out, alu_out;
"processador_tb": program on lab 5, txt opcodes, txt program on assembly;

instrs: branch (rel addr), cmp;
flags: C (carry, unsigned) on add, sub, cmp, Z (zero);
"processador_tb": program on lab 6, txt program on assembly, (assembler?);

* addi and no subi, add and sub A, Rn; A (acc) on alu_mux and alu_out,
  apart from bank; ld to regs not alu, cmp, Z, j abs b rel, sub no borrow;
  R0-R7 are Rn Rm on instr; mov Rn, A and mov A, Rn; document constants as
  signed but implement as 2s complement; indicate flags on jump instrs;
  signal extension on constants; nop 897;

rom, bank, pc, instr, acc, alu, ctlu, state

fetch: pc is ready, update rom_out;
decode: rom_out is ready, read to instr;
execute: instr is ready, ctlu signals are ready,
         bank addresses, outs and in are ready, we can write;
         pc_next is ready, we can write;
         alu ins and out are ready, we can write to acc;

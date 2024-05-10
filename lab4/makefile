all:
	ghdl -a reg16bits.vhd
	ghdl -e reg16bits
	ghdl -a ctlu.vhd
	ghdl -e ctlu
	ghdl -a rom7x12.vhd
	ghdl -e rom7x12
	ghdl -a statemachine1bit.vhd
	ghdl -e statemachine1bit
	ghdl -a pc_ctlu_rom.vhd
	ghdl -e pc_ctlu_rom
	ghdl -a pc_ctlu_rom_tb.vhd
	ghdl -e pc_ctlu_rom_tb
	ghdl -r pc_ctlu_rom_tb --wave=pc_ctlu_rom_tb.ghw
	gtkwave pc_ctlu_rom_tb.ghw

clear:
	rm pc_ctlu_rom_tb.ghw work-obj93.cf

all:
	ghdl -a reg16bits.vhd
	ghdl -e reg16bits
	ghdl -a bank8reg16bits.vhd
	ghdl -e bank8reg16bits
	ghdl -a alu.vhd
	ghdl -e alu
	ghdl -a main.vhd
	ghdl -e main
	ghdl -a main_tb.vhd
	ghdl -e main_tb
	ghdl -r main_tb --wave=main_tb.ghw
	gtkwave main_tb.ghw

clear:
	rm main_tb.ghw work-obj93.cf

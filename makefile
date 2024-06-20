all:
	ghdl -a statemachine2bits.vhd
	ghdl -e statemachine2bits
	ghdl -a rom8x16.vhd
	ghdl -e rom8x16
	ghdl -a ram8x16.vhd
	ghdl -e ram8x16
	ghdl -a reg16bits.vhd
	ghdl -e reg16bits
	ghdl -a bank8reg16bits.vhd
	ghdl -e bank8reg16bits
	ghdl -a alu.vhd
	ghdl -e alu
	ghdl -a ctlu.vhd
	ghdl -e ctlu
	ghdl -a processador.vhd
	ghdl -e processador
	ghdl -a testbenches/processador_tb.vhd
	ghdl -e processador_tb
	ghdl -r processador_tb --wave=testbenches/processador_tb.ghw
	gtkwave testbenches/processador_tb.ghw

clear:
	rm testbenches/processador_tb.ghw work-obj93.cf

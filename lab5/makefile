all:
	ghdl -a statemachine2bits.vhd
	ghdl -e statemachine2bits
	ghdl -a statemachine2bits_tb.vhd
	ghdl -e statemachine2bits_tb
	ghdl -r statemachine2bits_tb --wave=statemachine2bits_tb.ghw
	gtkwave statemachine2bits_tb.ghw

clear:
	rm statemachine2bits_tb.ghw work-obj93.cf

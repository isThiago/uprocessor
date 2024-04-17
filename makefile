all:
	ghdl -a alu.vhd
	ghdl -e alu
	ghdl -a alu_tb.vhd
	ghdl -e alu_tb
	ghdl -r alu_tb --wave=alu_tb.ghw
	gtkwave alu_tb.ghw

clear:
	rm alu_tb.ghw work-obj93.cf

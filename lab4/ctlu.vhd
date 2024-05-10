library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- instr:
-- J format: address(7 MSB) & opcode(5 LSB);
-- nop: "000000000000";
-- jump: J format, opcode = "11111";

entity ctlu is
    port(
        instr: in unsigned(11 downto 0);
        pc: in unsigned(15 downto 0);
        pc_next: out unsigned(15 downto 0)
    );
end entity;

architecture a_ctlu of ctlu is
    signal opcode: unsigned(4 downto 0);
begin
    opcode <= instr(4 downto 0);
    pc_next <= "000000000" & instr(11 downto 5) when opcode = "11111" else
               pc + "0000000000000001";
end architecture;

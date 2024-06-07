library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctlu_tb is
end entity;

architecture a_ctlu_tb of ctlu_tb is
    component ctlu is
        port(
            instr: in unsigned(11 downto 0);
            pc: in unsigned(15 downto 0);
            pc_next: out unsigned(15 downto 0)
        );
    end component;
    signal instr: unsigned(11 downto 0);
    signal pc, pc_next: unsigned(15 downto 0);
begin
    uut: ctlu port map(instr => instr, pc => pc, pc_next => pc_next);
    process
    begin
        instr <= "000000000000";
        pc <= "0000000000000000";
        wait for 50 ns;
        pc <= "0000000000001111";
        wait for 50 ns;
        pc <= "0000000011111111";
        wait for 50 ns;
        pc <= "0000111111111111";
        wait for 50 ns;
        pc <= "1111111111111111";
        wait for 50 ns;
        instr <= "000000111111";
        pc <= "0000000000000000";
        wait for 50 ns;
        instr <= "000001011111";
        pc <= "0000000000001111";
        wait for 50 ns;
        instr <= "000010011111";
        pc <= "0000000011111111";
        wait for 50 ns;
        instr <= "000100011111";
        pc <= "0000111111111111";
        wait for 50 ns;
        instr <= "001000011111";
        pc <= "1111111111111111";
        wait for 50 ns;
        wait;
    end process;
end architecture;

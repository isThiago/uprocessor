library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end entity;

architecture a_alu_tb of alu_tb is
    component alu is
        port(
            a, b: in unsigned(15 downto 0);
            op: in unsigned(2 downto 0);
            res: out unsigned(15 downto 0);
            z, c: out std_logic
        );
    end component;
    signal a, b, res: unsigned(15 downto 0);
    signal op: unsigned(2 downto 0);
    signal z, c: std_logic;
begin
    uut: alu port map(
        a => a, b => b, op => op, res => res, z => z, c => c
    );
    process
    begin
        a <= "0000000000001101"; -- 0x000D (13)
        b <= "0000000000001000"; -- 0x0008 (8)
        op <= "000";             -- 0x0015 (21)
        wait for 50 ns;
        op <= "001";             -- 0xFFFB (-5 mod 2^16), C
        wait for 50 ns;
        op <= "010";             -- 0x0005 (5)
        wait for 50 ns;
        op <= "011";
        wait for 50 ns;
        op <= "100";
        wait for 50 ns;
        op <= "101";             -- 0x0068 (104)
        wait for 50 ns;

        a <= "0000000000001101"; -- 0x000D (13)
        b <= "0000000000010101"; -- 0x0015 (21)
        op <= "000";             -- 0x0022 (34)
        wait for 50 ns;
        op <= "001";             -- 0x0008 (8)
        wait for 50 ns;
        op <= "010";             -- 0xFFF8 (-8 mod 2^16), C
        wait for 50 ns;
        op <= "011";
        wait for 50 ns;
        op <= "100";
        wait for 50 ns;
        op <= "101";             -- 0x0111 (273)
        wait for 50 ns;

        -- test with carry on add and mul:
        a <= "1111111111111110"; -- 0xFFFE (-2 mod 2^16)
        b <= "1111111111111110"; -- 0xFFFE (-2 mod 2^16)
        op <= "000";             -- 0xFFFC (-4 mod 2^16), C
        wait for 50 ns;
        op <= "001";             -- 0x0000 (0), Z
        wait for 50 ns;
        op <= "010";             -- 0x0000 (0), Z
        wait for 50 ns;
        op <= "011";
        wait for 50 ns;
        op <= "100";
        wait for 50 ns;
        op <= "101";             -- 0x0004 (4), C
        wait for 50 ns;

        wait;
    end process;
end architecture;

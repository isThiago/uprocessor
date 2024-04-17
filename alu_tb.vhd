library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end entity;

architecture a_alu_tb of alu_tb is
    component alu is
        port(
            a, b: in unsigned(15 downto 0);
            op: in unsigned(1 downto 0);
            res: out unsigned(15 downto 0);
            eq, lt: out std_logic
        );
    end component;
    signal a, b, res: unsigned(15 downto 0);
    signal op: unsigned(1 downto 0);
    signal eq, lt: std_logic;
begin
    uut: alu port map(
        a => a, b => b, op => op, res => res, eq => eq, lt => lt
    );
    process
    begin
        -- ordinary test:
        a <= "0000000000001101"; -- 0x000D (13)
        b <= "0000000000001000"; -- 0x0008 (8)
        op <= "00";              -- 0x0015 (21)
        wait for 50 ns;
        op <= "01";              -- 0x0005 (5)
        wait for 50 ns;
        op <= "10";              -- 0x0068 (104)
        wait for 50 ns;
        op <= "11";              -- 0x0005
        wait for 50 ns;

        -- test with overflow on sub:
        a <= "0000000000001101"; -- 0x000D (13)
        b <= "0000000000010101"; -- 0x0015 (21)
        op <= "00";              -- 0x0022 (34)
        wait for 50 ns;
        op <= "01";              -- 0xFFF8 (-8)
        wait for 50 ns;
        op <= "10";              -- 0x0111 (273)
        wait for 50 ns;
        op <= "11";              -- 0x0018
        wait for 50 ns;

        -- test with overflow on add and mul:
        a <= "1111111111111110"; -- 0xFFFE (-2)
        b <= "1111111111111110"; -- 0xFFFE (-2)
        op <= "00";              -- 0xFFFC (-4)
        wait for 50 ns;
        op <= "01";              -- 0x0000 (0)
        wait for 50 ns;
        op <= "10";              -- 0x0004 (4)
        wait for 50 ns;
        op <= "11";              -- 0x0000
        wait for 50 ns;

        wait;
    end process;
end architecture;

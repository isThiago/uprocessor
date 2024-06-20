library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom8x16 is
    port(
        clk: in std_logic;
        addr: in unsigned(7 downto 0);
        data_out: out unsigned(15 downto 0)
    );
end entity;

architecture a_rom8x16 of rom8x16 is
    type mem is array(0 to 255) of unsigned(15 downto 0);
    constant data: mem := (
        0 => B"0000_0000_0111_1001",
        1 => B"0000_0000_1001_1001",
        2 => B"0000_0000_0000_1001",
        3 => B"0000_0000_0110_0000",
        4 => B"0000_0000_1000_0000",
        5 => B"0000_0000_1001_0011",
        6 => B"0000_0000_0110_0011",
        7 => B"0000_0000_0001_1000",
        8 => B"0000_0000_0111_0011",
        9 => B"0001_1110_0000_1001",
        10 => B"0000_0010_0111_0000",
        11 => B"1111_1011_1010_1101",
        12 => B"0000_0000_1000_0011",
        13 => B"0000_0000_1011_0011",
        others => (others => '0')
    );
begin
    process(clk)
    begin
        if rising_edge(clk) then
            data_out <= data(to_integer(addr));
        end if;
    end process;
end architecture;

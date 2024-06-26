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
        0 => B"0000_0000_0011_1001",
        1 => B"0000_0101_0101_1001",
        2 => B"0000_1001_0010_0100",
        3 => B"0000_0000_0010_0011",
        4 => B"0000_0000_0001_1000",
        5 => B"0000_0000_0011_0011",
        6 => B"0000_0011_0010_0000",
        7 => B"0000_0010_0100_0000",
        8 => B"1111_1101_0001_1101",
        9 => B"0000_0010_0011_1001",
        10 => B"0010_0000_1011_1001",
        11 => B"0000_0001_0110_0100",
        12 => B"0000_0000_0000_1001",
        13 => B"0000_0010_0110_0000",
        14 => B"0000_0110_0000_1101",
        15 => B"0000_0000_0010_0011",
        16 => B"0000_0000_0010_0010",
        17 => B"0000_0000_1001_0011",
        18 => B"0000_0010_1010_0000",
        19 => B"0000_0011_1101_1101",
        20 => B"0000_1100_0000_0100",
        21 => B"0000_0000_1000_0011",
        22 => B"0000_0000_0010_0000",
        23 => B"0000_0000_1001_0011",
        24 => B"0000_0010_1010_0000",
        25 => B"1111_1101_0010_1101",
        26 => B"0000_0000_0010_0011",
        27 => B"0000_0000_0001_1000",
        28 => B"0000_0000_0011_0011",
        29 => B"0000_0011_0010_0000",
        30 => B"0000_0010_0100_0000",
        31 => B"1111_0110_0001_1101",
        32 => B"0000_0010_0011_1001",
        33 => B"0000_0001_1110_0100",
        34 => B"0000_0000_0010_0011",
        35 => B"0000_0000_0001_1000",
        36 => B"0000_0000_0011_0011",
        37 => B"0000_0011_0010_0000",
        38 => B"0000_0010_0100_0000",
        39 => B"1111_1101_0001_1101",
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

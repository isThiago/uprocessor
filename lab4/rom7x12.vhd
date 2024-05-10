library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- instr:
-- J format: address(7 MSB) & opcode(5 LSB);
-- nop: "000000000000";
-- jump: J format, opcode = "11111";

entity rom7x12 is
    port(
        addr: in unsigned(6 downto 0);
        clk, r_en: in std_logic;
        data_out: out unsigned(11 downto 0)
    );
end entity;

architecture a_rom7x12 of rom7x12 is
    type mem is array(0 to 127) of unsigned(11 downto 0);
    -- execution: 0 1 3 4 2 6 7 3 4 2 6 7 ...
    constant data_rom: mem := (
        0 => "000000000000", -- nop
        1 => "000001111111", -- jump 0000011
        2 => "000011011111", -- jump 0000110
        3 => "000000000000", -- nop
        4 => "000001011111", -- jump 0000010
        5 => "000000000000", -- nop
        6 => "000000000000", -- nop
        7 => "000001111111", -- jump 0000011
        others => (others => '0')
    );
begin
    process(clk)
    begin
        if r_en = '1' and rising_edge(clk) then
            data_out <= data_rom(to_integer(addr));
        end if;
    end process;
end architecture;

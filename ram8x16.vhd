library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram8x16 is
    port(
        clk, wr_en: in std_logic;
        addr: in unsigned(7 downto 0);
        data_in: in unsigned(15 downto 0);
        data_out: out unsigned(15 downto 0)
    );
end entity;

architecture a_ram8x16 of ram8x16 is
    type mem is array (0 to 255) of unsigned(15 downto 0);
    signal data: mem;
begin
    process(clk, wr_en)
    begin
        if rising_edge(clk) then
            if wr_en = '1' then
                data(to_integer(addr)) <= data_in;
            end if;
        end if;
    end process;
    data_out <= data(to_integer(addr));
end architecture;

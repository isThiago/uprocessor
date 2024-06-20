library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity statemachine2bits is
    port(
        rst, clk: in std_logic;
        state: out unsigned(1 downto 0)
    );
end entity;

architecture a_statemachine2bits of statemachine2bits is
    signal state_s: unsigned(1 downto 0);
begin
    process(rst, clk)
    begin
        if rst = '1' then
            state_s <= "00";
        elsif rising_edge(clk) then
            if state_s = "10" then
                state_s <= "00";
            else
                state_s <= state_s + "01";
            end if;
        end if;
    end process;
    state <= state_s;
end architecture;

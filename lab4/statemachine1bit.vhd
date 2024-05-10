library ieee;
use ieee.std_logic_1164.all;

entity statemachine1bit is
    port(
        rst, clk: in std_logic;
        state: out std_logic
    );
end entity;

architecture a_statemachine1bit of statemachine1bit is
    signal data: std_logic;
begin
    process(rst, clk)
    begin
        if rst = '1' then
            data <= '0';
        elsif rising_edge(clk) then
            data <= not data;
        end if;
    end process;
    state <= data;
end architecture;

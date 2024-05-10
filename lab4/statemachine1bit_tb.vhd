library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity statemachine1bit_tb is
end entity;

architecture a_statemachine1bit_tb of statemachine1bit_tb is
    component statemachine1bit is
        port(
            rst, clk: in std_logic;
            state: out std_logic
        );
    end component;
    constant period_clk: time := 100 ns;
    signal finished: std_logic := '0';
    signal rst, clk, state: std_logic;
begin
    uut: statemachine1bit port map(
        rst => rst, clk => clk, state => state
    );

    global_rst: process
    begin
        rst <= '1';
        wait for 2 * period_clk;
        rst <= '0';
        wait; 
    end process;

    global_clk: process
    begin
        while finished /= '1' loop
            clk <= '0';
            wait for period_clk / 2;
            clk <= '1';
            wait for period_clk / 2;
        end loop;
        wait;
    end process;
    
    process
    begin
        wait for 10 *  period_clk;
        finished <= '1';
        wait;
    end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity statemachine2bits_tb is
end entity;

architecture a_statemachine2bits_tb of statemachine2bits_tb is
    component statemachine2bits is
        port(
            rst, clk: in std_logic;
            state: out unsigned(1 downto 0)
        );
    end component;
    constant period_clk: time := 100 ns;
    signal finished: std_logic := '0';
    signal rst, clk: std_logic;
    signal state: unsigned(1 downto 0);
begin
    uut: statemachine2bits port map(
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
    
    global_sim_time: process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process;

    process
    begin
        wait;
    end process;
end architecture;

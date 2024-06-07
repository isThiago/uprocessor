library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_ctlu_rom_tb is
end entity;

architecture a_pc_ctlu_rom_tb of pc_ctlu_rom_tb is
    component pc_ctlu_rom is
        port(
            rst, clk: in std_logic;
            data_out: out unsigned(11 downto 0)
        );
    end component;

    constant period_clk: time := 100 ns;
    signal finished: std_logic := '0';
    signal rst, clk: std_logic;
    signal data_out: unsigned(11 downto 0);

begin
    uut: pc_ctlu_rom port map(rst => rst, clk => clk, data_out => data_out);

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
        wait for 26 * period_clk;
        finished <= '1';
        wait;
    end process;
end architecture;

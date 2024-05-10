library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom7x12_tb is
end entity;

architecture a_rom7x12_tb of rom7x12_tb is
    component rom7x12 is
        port(
            addr: in unsigned(6 downto 0);
            clk, r_en: in std_logic;
            data_out: out unsigned(11 downto 0)
        );
    end component;
    constant period_clk: time := 100 ns;
    signal finished: std_logic := '0';
    signal addr: unsigned(6 downto 0);
    signal clk, r_en: std_logic;
    signal data_out: unsigned(11 downto 0);
begin
    uut: rom7x12 port map(
        addr => addr, clk => clk, r_en => r_en, data_out => data_out
    );

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
        r_en <= '1';
        addr <= "0000001";
        wait for period_clk;
        addr <= "0000010";
        wait for period_clk;
        addr <= "0000100";
        wait for period_clk;
        addr <= "0000101";
        wait for period_clk;
        addr <= "0000011";
        wait for period_clk;
        addr <= "0000110";
        wait for period_clk;
        addr <= "0000111";
        wait for period_clk;
        addr <= "0000000";
        wait for period_clk;
        finished <= '1';
        wait;
    end process;
end architecture;

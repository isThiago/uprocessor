library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom8x16_tb is
end entity;

architecture a_rom8x16_tb of rom8x16_tb is
    component rom8x16 is
        port(
            clk: in std_logic;
            addr: in unsigned(7 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;
    constant period_clk: time := 100 ns;
    signal finished: std_logic := '0';
    signal clk: std_logic;
    signal addr: unsigned(7 downto 0);
    signal data_out: unsigned(15 downto 0);
begin
    uut: rom8x16 port map(
        addr => addr, clk => clk, data_out => data_out
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

    global_sim_time: process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process;

    process
    begin
        addr <= "00000001";
        wait for period_clk;
        addr <= "00000010";
        wait for period_clk;
        addr <= "00000100";
        wait for period_clk;
        addr <= "00000101";
        wait for period_clk;
        addr <= "00000011";
        wait for period_clk;
        addr <= "00000110";
        wait for period_clk;
        addr <= "00000111";
        wait for period_clk;
        addr <= "00000000";
        wait for period_clk;
        wait;
    end process;
end architecture;

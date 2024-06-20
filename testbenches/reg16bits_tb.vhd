library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16bits_tb is
end entity;

architecture a_reg16bits_tb of reg16bits_tb is
    component reg16bits is
        port(
            rst, clk, wr_en: in std_logic;
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;
    constant period_clk: time := 100 ns;
    signal finished: std_logic := '0';
    signal rst, clk, wr_en: std_logic;
    signal data_in, data_out: unsigned(15 downto 0);
begin
    uut: reg16bits port map(
        rst => rst, clk => clk, wr_en => wr_en,
        data_in => data_in, data_out => data_out
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
        wait for 2 * period_clk;
        wr_en <= '0';
        data_in <= "1111111111111111";
        wait for 250 ns;
        wr_en <= '1';
        data_in <= "1111000011110000";
        wait for 250 ns;
        data_in <= "0000111100001111";
        wait for 250 ns;
        wait;
    end process;
end architecture;

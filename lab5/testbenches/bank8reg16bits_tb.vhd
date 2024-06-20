library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bank8reg16bits_tb is
end entity;

architecture a_bank8reg16bits_tb of bank8reg16bits_tb is
    component bank8reg16bits is
        port(
            rst, clk, wr_en: in std_logic;
            addr_r_a, addr_r_b, addr_w: in unsigned(2 downto 0);
            data_in: in unsigned(15 downto 0);
            data_out_a, data_out_b: out unsigned(15 downto 0)
        );
    end component;
    constant period_clk: time := 100 ns;
    signal finished: std_logic := '0';
    signal rst, clk, wr_en: std_logic;
    signal addr_r_a, addr_r_b, addr_w: unsigned(2 downto 0);
    signal data_in, data_out_a, data_out_b: unsigned(15 downto 0);
begin
    uut: bank8reg16bits port map(
        rst => rst, clk => clk, wr_en => wr_en,
        addr_r_a => addr_r_a, addr_r_b => addr_r_b, addr_w => addr_w,
        data_in => data_in, data_out_a => data_out_a, data_out_b => data_out_b
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
        addr_r_a <= "000";
        addr_r_b <= "000";
        addr_w <= "000";
        data_in <= "1111000011110000";
        wr_en <= '1';
        wait for period_clk;
        addr_r_a <= "000";
        addr_r_b <= "001";
        addr_w <= "001";
        data_in <= "1111000011110000";
        wr_en <= '0';
        wait for period_clk;
        addr_r_a <= "001";
        addr_r_b <= "000";
        addr_w <= "001";
        data_in <= "1111000011110000";
        wr_en <= '1';
        wait for period_clk;
        addr_r_a <= "101";
        addr_r_b <= "001";
        addr_w <= "101";
        data_in <= "0000111100001111";
        wr_en <= '1';
        wait for period_clk;
        wait;
    end process;
end architecture;

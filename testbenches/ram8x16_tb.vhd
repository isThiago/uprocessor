library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram8x16_tb is
end entity;

architecture a_ram8x16_tb of ram8x16_tb is
    component ram8x16 is
        port(
            clk, wr_en: in std_logic;
            addr: in unsigned(7 downto 0);
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;
    constant period_clk: time := 100 ns;
    signal finished: std_logic := '0';
    signal clk, wr_en: std_logic;
    signal addr: unsigned(7 downto 0);
    signal data_in, data_out: unsigned(15 downto 0);
begin
    uut: ram8x16 port map(
        clk => clk, wr_en => wr_en,
        addr => addr,
        data_in => data_in,
        data_out => data_out
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
        wr_en <= '1';
        addr <= B"0000_0001";
        data_in <= B"0000_0000_0000_0010";
        wait for period_clk;
        addr <= B"0000_0001";
        data_in <= B"0000_0000_0000_0011";
        wait for period_clk;
        addr <= B"0000_0010";
        data_in <= B"0000_0000_0000_0101";
        wait for period_clk;
        addr <= B"0000_0011";
        data_in <= B"0000_0000_0000_0111";
        wait for period_clk;
        addr <= B"0000_0101";
        data_in <= B"0000_0000_0000_1011";
        wait for period_clk;
        addr <= B"0000_1000";
        data_in <= B"0000_0000_0000_1101";
        wait for period_clk;
        addr <= B"0000_1101";
        data_in <= B"0000_0000_0001_0001";
        wait for period_clk;
        addr <= B"0001_0101";
        data_in <= B"0000_0000_0001_0011";
        wait for period_clk;

        wr_en <= '0';
        addr <= B"0000_0001";
        wait for period_clk;
        addr <= B"0000_0001";
        wait for period_clk;
        addr <= B"0000_0010";
        wait for period_clk;
        addr <= B"0000_0011";
        wait for period_clk;
        addr <= B"0000_0101";
        wait for period_clk;
        addr <= B"0000_1000";
        wait for period_clk;
        addr <= B"0000_1101";
        wait for period_clk;
        addr <= B"0001_0101";
        wait for period_clk;
        wait;
    end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bank8reg16bits_tb is
end entity;

architecture a_bank8reg16bits_tb of bank8reg16bits_tb is
    component bank8reg16bits is
        port(
            addr_r_a, addr_r_b, addr_w: in unsigned(2 downto 0);
            data_in: in unsigned(15 downto 0);
            rst, clk, wr_en: in std_logic;
            data_out_a, data_out_b: out unsigned(15 downto 0)
        );
    end component;
    constant period_clk: time := 100 ns;
    signal finished: std_logic := '0';
    signal addr_r_a, addr_r_b, addr_w: unsigned(2 downto 0);
    signal data_in, data_out_a, data_out_b: unsigned(15 downto 0);
    signal rst, clk, wr_en: std_logic;
begin
    uut: bank8reg16bits port map(
        addr_r_a -> addr_r_a, addr_r_b -> addr_r_b, addr_w -> addr_w,
        data_in -> data_in, data_out_a -> data_out_a, data_out_b -> data_out_b,
        rst -> rst, clk -> clk, wr_en -> wr_en
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
        finished <= '1';
    end process;
end architecture;
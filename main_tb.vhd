library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main_tb is
end entity;

architecture a_main_tb of main_tb is
    component main is
        port(
            addr_r_a, addr_r_b, addr_w: in unsigned(2 downto 0);
            cte, data_in: in unsigned(15 downto 0);
            rst, clk, wr_en: in std_logic;
            alu_src, op: in unsigned(1 downto 0);
            alu_out: out unsigned(15 downto 0);
            eq, lt: out std_logic
        );
    end component;

    constant period_clk: time := 100 ns;
    signal finished: std_logic := '0';
    signal addr_r_a, addr_r_b, addr_w: unsigned(2 downto 0);
    signal cte, data_in, alu_out: unsigned(15 downto 0);
    signal alu_src, op: unsigned(1 downto 0);
    signal rst, clk, wr_en, eq, lt: std_logic;

begin
    uut: main port map(
        addr_r_a => addr_r_a, addr_r_b => addr_r_b, addr_w => addr_w, cte => cte
                                                                               ,
                                                     -- dependencia de caminho ^
        data_in => data_in, rst => rst, clk => clk, wr_en => wr_en,
        alu_src => alu_src, op => op, alu_out => alu_out, eq => eq, lt => lt
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
        wait for 2 * period_clk;
        addr_w <= "001";
        data_in <= "0000000000001000";
        wr_en <= '1';
        wait for period_clk;
        addr_w <= "010";
        data_in <= "0000000000011000";
        addr_r_a <= "001";
        addr_r_b <= "010";
        alu_src <= "00";
        op <= "00";
        wait for period_clk;
        cte <= "0000000000000100";
        wr_en <= '0';
        alu_src <= "01";
        wait for period_clk;
        addr_r_a <= "010";
        alu_src <= "10";
        op <= "10";
        wait for period_clk;
        finished <= '1';
        wait;
    end process;
end architecture;

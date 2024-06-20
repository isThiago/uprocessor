library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bank8reg16bits is
    port(
        rst, clk, wr_en: in std_logic;
        addr_r_a, addr_r_b, addr_w: in unsigned(2 downto 0);
        data_in: in unsigned(15 downto 0);
        data_out_a, data_out_b: out unsigned(15 downto 0)
    );
end entity;

architecture a_bank8reg16bits of bank8reg16bits is
    component reg16bits is
        port(
            rst, clk, wr_en: in std_logic;
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;
    signal wr_en_0, wr_en_1, wr_en_2, wr_en_3,
           wr_en_4, wr_en_5, wr_en_6, wr_en_7: std_logic;
    signal data_out_0, data_out_1, data_out_2, data_out_3,
           data_out_4, data_out_5, data_out_6, data_out_7: unsigned(15 downto 0)
                                                                               ;
begin
    reg_0: reg16bits port map(
        rst => rst, clk => clk, wr_en => wr_en_0,
        data_in => data_in, data_out => data_out_0
    );
    reg_1: reg16bits port map(
        rst => rst, clk => clk, wr_en => wr_en_1,
        data_in => data_in, data_out => data_out_1
    );
    reg_2: reg16bits port map(
        rst => rst, clk => clk, wr_en => wr_en_2,
        data_in => data_in, data_out => data_out_2
    );
    reg_3: reg16bits port map(
        rst => rst, clk => clk, wr_en => wr_en_3,
        data_in => data_in, data_out => data_out_3
    );
    reg_4: reg16bits port map(
        rst => rst, clk => clk, wr_en => wr_en_4,
        data_in => data_in, data_out => data_out_4
    );
    reg_5: reg16bits port map(
        rst => rst, clk => clk, wr_en => wr_en_5,
        data_in => data_in, data_out => data_out_5
    );
    reg_6: reg16bits port map(
        rst => rst, clk => clk, wr_en => wr_en_6,
        data_in => data_in, data_out => data_out_6
    );
    reg_7: reg16bits port map(
        rst => rst, clk => clk, wr_en => wr_en_7,
        data_in => data_in, data_out => data_out_7
    );
    wr_en_0 <= '0';
    wr_en_1 <= '1' when wr_en = '1' and addr_w = "001" else
               '0';
    wr_en_2 <= '1' when wr_en = '1' and addr_w = "010" else
               '0';
    wr_en_3 <= '1' when wr_en = '1' and addr_w = "011" else
               '0';
    wr_en_4 <= '1' when wr_en = '1' and addr_w = "100" else
               '0';
    wr_en_5 <= '1' when wr_en = '1' and addr_w = "101" else
               '0';
    wr_en_6 <= '1' when wr_en = '1' and addr_w = "110" else
               '0';
    wr_en_7 <= '1' when wr_en = '1' and addr_w = "111" else
               '0';
    data_out_a <= data_out_0 when addr_r_a = "000" else
                  data_out_1 when addr_r_a = "001" else
                  data_out_2 when addr_r_a = "010" else
                  data_out_3 when addr_r_a = "011" else
                  data_out_4 when addr_r_a = "100" else
                  data_out_5 when addr_r_a = "101" else
                  data_out_6 when addr_r_a = "110" else
                  data_out_7 when addr_r_a = "111" else
                  "0000000000000000";
    data_out_b <= data_out_0 when addr_r_b = "000" else
                  data_out_1 when addr_r_b = "001" else
                  data_out_2 when addr_r_b = "010" else
                  data_out_3 when addr_r_b = "011" else
                  data_out_4 when addr_r_b = "100" else
                  data_out_5 when addr_r_b = "101" else
                  data_out_6 when addr_r_b = "110" else
                  data_out_7 when addr_r_b = "111" else
                  "0000000000000000";
end architecture;

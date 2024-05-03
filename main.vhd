library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main is
    port(
        addr_r_a, addr_r_b, addr_w: in unsigned(2 downto 0);
        cte, data_in: in unsigned(15 downto 0);
        rst, clk, wr_en: in std_logic;
        alu_src, op: in unsigned(1 downto 0);
        alu_out: out unsigned(15 downto 0);
        eq, lt: out std_logic
    );
end entity;

architecture a_main of main is
    component reg16bits is
        port(
            rst, clk, wr_en: in std_logic;
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;

    component bank8reg16bits is
        port(
            addr_r_a, addr_r_b, addr_w: in unsigned(2 downto 0);
            data_in: in unsigned(15 downto 0);
            rst, clk, wr_en: in std_logic;
            data_out_a, data_out_b: out unsigned(15 downto 0)
        );
    end component;

    component alu is
        port(
            a, b: in unsigned(15 downto 0);
            op: in unsigned(1 downto 0);
            res: out unsigned(15 downto 0);
            eq, lt: out std_logic
        );
    end component;

    signal acc_wr_en: std_logic := '1';
    signal alu_a, alu_b, alu_b_0, alu_b_1, alu_b_2,
           alu_res: unsigned(15 downto 0);

begin
    reg_acc: reg16bits port map(
        rst => rst, clk => clk, wr_en => acc_wr_en,
        data_in => alu_res, data_out => alu_b_2
    );
    bank_reg: bank8reg16bits port map(
        addr_r_a => addr_r_a, addr_r_b => addr_r_b, addr_w => addr_w,
        data_in => data_in, rst => rst, clk => clk, wr_en => wr_en,
        data_out_a => alu_a, data_out_b => alu_b_0
    );
    the_alu: alu port map(
        a => alu_a, b => alu_b, op => op, res => alu_res, eq => eq, lt => lt
    );
    alu_b <= alu_b_0 when alu_src = "00" else
             alu_b_1 when alu_src = "01" else
             alu_b_2 when alu_src = "10" else
             "0000000000000000";
    alu_b_1 <= cte;
    alu_out <= alu_res;
end architecture;

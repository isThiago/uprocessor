library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_ctlu is
    port(
        rst, clk: in std_logic;
        data_out: out unsigned(15 downto 0)
    );
end entity;

architecture a_pc_ctlu of pc_ctlu is
    component reg16bits is
        port(
            rst, clk, wr_en: in std_logic;
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;

    component ctlu is
        port(
            pc: in unsigned(15 downto 0);
            pc_next: out unsigned(15 downto 0)
        );
    end component;

    signal pc_wr_en: std_logic := '1';
    signal pc_in, pc_out: unsigned(15 downto 0);    

begin
    pc: reg16bits port map(
        rst => rst, clk => clk, wr_en => pc_wr_en,
        data_in => pc_in, data_out => pc_out
    );
    the_ctlu: ctlu port map(pc => pc_out, pc_next => pc_in);
    
    data_out <= pc_out;
end architecture;

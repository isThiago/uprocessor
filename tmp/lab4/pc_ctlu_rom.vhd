library ieee;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_ctlu_rom is
    port(
        rst, clk: in std_logic;
        data_out: out unsigned(11 downto 0)
    );
end entity;

architecture a_pc_ctlu_rom of pc_ctlu_rom is
    component reg16bits is
        port(
            rst, clk, wr_en: in std_logic;
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;

    component ctlu is
        port(
            instr: in unsigned(11 downto 0);
            pc: in unsigned(15 downto 0);
            pc_next: out unsigned(15 downto 0)
        );
    end component;

    component rom7x12 is
        port(
            addr: in unsigned(6 downto 0);
            clk, r_en: in std_logic;
            data_out: out unsigned(11 downto 0)
        );
    end component;

    component statemachine1bit is
        port(
            rst, clk: in std_logic;
            state: out std_logic
        );
    end component;

    signal pc_wr_en, rom_r_en, state: std_logic;
    signal pc_in, pc_out: unsigned(15 downto 0);
    signal instr: unsigned(11 downto 0);
    signal rom_addr: unsigned(6 downto 0);

begin
    pc: reg16bits port map(
        rst => rst, clk => clk, wr_en => pc_wr_en,
        data_in => pc_in, data_out => pc_out
    );
    the_ctlu: ctlu port map(instr => instr, pc => pc_out, pc_next => pc_in);
    the_rom: rom7x12 port map(
        addr => rom_addr, clk => clk, r_en => rom_r_en, data_out => instr
    );
    the_state_machine: statemachine1bit port map(
        rst => rst, clk => clk, state => state
    );
    
    pc_wr_en <= '1' when state = '1' else
                '0';
    rom_r_en <= '1' when state = '0' else
                '0';
    rom_addr <= pc_out(6 downto 0);
    data_out <= instr;
end architecture;

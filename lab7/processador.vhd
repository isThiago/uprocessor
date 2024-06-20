library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
    port(
        rst, clk: in std_logic;
        state: out unsigned(1 downto 0);
        pc_data_out, instr_data_out, acc_data_out, bank_data_out_a,
            bank_data_out_b, alu_res: out unsigned(15 downto 0)
    );
end entity;

architecture a_processador of processador is
    component statemachine2bits is
        port(
            rst, clk: in std_logic;
            state: out unsigned(1 downto 0)
        );
    end component;

    component rom8x16 is
        port(
            clk: in std_logic;
            addr: in unsigned(7 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;

    component ram8x16 is
        port(
            clk, wr_en: in std_logic;
            addr: in unsigned(7 downto 0);
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;

    component reg16bits is
        port(
            rst, clk, wr_en: in std_logic;
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;

    component bank8reg16bits is
        port(
            rst, clk, wr_en: in std_logic;
            addr_r_a, addr_r_b, addr_w: in unsigned(2 downto 0);
            data_in: in unsigned(15 downto 0);
            data_out_a, data_out_b: out unsigned(15 downto 0)
        );
    end component;

    component alu is
        port(
            a, b: in unsigned(15 downto 0);
            op: in unsigned(2 downto 0);
            res: out unsigned(15 downto 0);
            z, c: out std_logic
        );
    end component;

    component ctlu is
        port(
            state: in unsigned(1 downto 0);
            pc, instr: in unsigned(15 downto 0);
            z, c: in std_logic;
            ram_wr_en, pc_wr_en, instr_wr_en, acc_wr_en, flag_wr_en,
                bank_wr_en: out std_logic;
            pc_data_in, ext_imm: out unsigned(15 downto 0);
            acc_data_in_sel, bank_data_in_sel: out unsigned(1 downto 0);
            alu_a_sel: out std_logic;
            alu_op: out unsigned(2 downto 0);
            bank_addr_r_a, bank_addr_r_b, bank_addr_w: out unsigned(2 downto 0)
        );
    end component;

    constant zero16: unsigned(15 downto 0) := "0000000000000000";

    signal state_s: unsigned(1 downto 0);
    signal rom_addr_s: unsigned(7 downto 0);
    signal rom_data_out_s: unsigned(15 downto 0);
    signal ram_wr_en_s: std_logic;
    signal ram_addr_s: unsigned(7 downto 0);
    signal pc_wr_en_s: std_logic;
    signal pc_data_in_s: unsigned(15 downto 0);
    signal pc_data_out_s: unsigned(15 downto 0);
    signal instr_wr_en_s: std_logic;
    signal instr_data_out_s: unsigned(15 downto 0);
    signal acc_wr_en_s: std_logic;
    signal acc_data_in_s: unsigned(15 downto 0);
    signal acc_data_in_sel_s: unsigned(1 downto 0);
    signal acc_data_out_s: unsigned(15 downto 0);
    signal flag_wr_en_s: std_logic;
    signal z_data_in_s: unsigned(15 downto 0);
    signal z_data_out_s: unsigned(15 downto 0);
    signal c_data_in_s: unsigned(15 downto 0);
    signal c_data_out_s: unsigned(15 downto 0);
    signal bank_wr_en_s: std_logic;
    signal bank_addr_r_a_s: unsigned(2 downto 0);
    signal banK_addr_r_b_s: unsigned(2 downto 0);
    signal bank_addr_w_s: unsigned(2 downto 0);
    signal bank_data_in_s: unsigned(15 downto 0);
    signal bank_data_in_sel_s: unsigned(1 downto 0);
    signal bank_data_out_a_s: unsigned(15 downto 0);
    signal bank_data_out_b_s: unsigned(15 downto 0);
    signal alu_a_s: unsigned(15 downto 0);
    signal alu_a_sel_s: std_logic;
    signal alu_op_s: unsigned(2 downto 0);
    signal alu_res_s: unsigned(15 downto 0);
    signal alu_z_s: std_logic;
    signal alu_c_s: std_logic;
    signal ctlu_z_s: std_logic;
    signal ctlu_c_s: std_logic;
    signal ctlu_ext_imm_s: unsigned(15 downto 0);

    signal ram_data_out_s: unsigned(15 downto 0);

begin
    top_state_machine: statemachine2bits port map(
        rst => rst, clk => clk, state => state_s
    );
    top_rom: rom8x16 port map(
        clk => clk, addr => rom_addr_s, data_out => rom_data_out_s
    );
    top_ram: ram8x16 port map(
        clk => clk, wr_en => ram_wr_en_s, addr => ram_addr_s,
        data_in => bank_data_out_a_s, data_out => ram_data_out_s
    );
    top_pc_reg: reg16bits port map(
        rst => rst, clk => clk, wr_en => pc_wr_en_s, data_in => pc_data_in_s,
        data_out => pc_data_out_s
    );
    top_instr_reg: reg16bits port map(
        rst => rst, clk => clk, wr_en => instr_wr_en_s,
        data_in => rom_data_out_s, data_out => instr_data_out_s
    );
    top_acc_reg: reg16bits port map(
        rst => rst, clk => clk, wr_en => acc_wr_en_s, data_in => acc_data_in_s,
        data_out => acc_data_out_s
    );
    top_z_reg: reg16bits port map(
        rst => rst, clk => clk, wr_en => flag_wr_en_s, data_in => z_data_in_s,
        data_out => z_data_out_s
    );
    top_c_reg: reg16bits port map(
        rst => rst, clk => clk, wr_en => flag_wr_en_s, data_in => c_data_in_s,
        data_out => c_data_out_s
    );
    top_reg_bank: bank8reg16bits port map(
        rst => rst, clk => clk, wr_en => bank_wr_en_s,
        addr_r_a => bank_addr_r_a_s, addr_r_b => bank_addr_r_b_s,
        addr_w => bank_addr_w_s, data_in => bank_data_in_s,
        data_out_a => bank_data_out_a_s, data_out_b => bank_data_out_b_s
    );
    top_alu: alu port map(
        a => alu_a_s, b => acc_data_out_s, op => alu_op_s, res => alu_res_s,
        z => alu_z_s, c => alu_c_s
    );
    top_ctlu: ctlu port map(
        state => state_s,
        pc => pc_data_out_s, instr => instr_data_out_s,
        z => ctlu_z_s, c => ctlu_c_s,
        ram_wr_en => ram_wr_en_s, pc_wr_en => pc_wr_en_s,
        instr_wr_en => instr_wr_en_s, acc_wr_en => acc_wr_en_s,
        flag_wr_en => flag_wr_en_s, bank_wr_en => bank_wr_en_s,
        pc_data_in => pc_data_in_s, ext_imm => ctlu_ext_imm_s,
        acc_data_in_sel => acc_data_in_sel_s,
        bank_data_in_sel => bank_data_in_sel_s, alu_a_sel => alu_a_sel_s,
        alu_op => alu_op_s,
        bank_addr_r_a => bank_addr_r_a_s, bank_addr_r_b => banK_addr_r_b_s,
        bank_addr_w => bank_addr_w_s
    );

    state <= state_s;
    pc_data_out <= pc_data_out_s;
    instr_data_out <= instr_data_out_s;
    acc_data_out <= acc_data_out_s;
    bank_data_out_a <= bank_data_out_a_s;
    bank_data_out_b <= bank_data_out_b_s;
    alu_res <= alu_res_s;

    rom_addr_s <= pc_data_out_s(7 downto 0);
    ram_addr_s <= bank_data_out_b_s(7 downto 0);
    acc_data_in_s <= alu_res_s when acc_data_in_sel_s = "00" else
                     bank_data_out_a_s when acc_data_in_sel_s = "01" else
                     ctlu_ext_imm_s when acc_data_in_sel_s = "10" else
                     zero16;
    z_data_in_s <= "000000000000000" & alu_z_s;
    c_data_in_s <= "000000000000000" & alu_c_s;
    bank_data_in_s <= acc_data_out_s when bank_data_in_sel_s = "00" else
                      ctlu_ext_imm_s when bank_data_in_sel_s = "01" else
                      ram_data_out_s when bank_data_in_sel_s = "10" else
                      zero16;
    alu_a_s <= bank_data_out_a_s when alu_a_sel_s = '0' else
               ctlu_ext_imm_s when alu_a_sel_s = '1' else
               zero16;
    ctlu_z_s <= z_data_out_s(0);
    ctlu_c_s <= c_data_out_s(0);
end architecture;

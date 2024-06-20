library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctlu is
    port(
        state: in unsigned(1 downto 0);
        pc, instr: in unsigned(15 downto 0);
        z, c: in std_logic;
        pc_wr_en, instr_wr_en, acc_wr_en, bank_wr_en: out std_logic;
        pc_data_in, ext_imm: out unsigned(15 downto 0);
        acc_data_in_sel: out unsigned(1 downto 0);
        bank_data_in_sel, alu_a_sel: out std_logic;
        alu_op: out unsigned(2 downto 0);
        bank_addr_r_a, bank_addr_r_b, bank_addr_w: out unsigned(2 downto 0)
    );
end entity;

architecture a_ctlu of ctlu is
    signal ext_imm12, ext_imm8: unsigned(15 downto 0);
    signal reg: unsigned(2 downto 0);
    signal funct8: unsigned(7 downto 0);
    signal funct1: std_logic;
    signal opcode: unsigned(3 downto 0);
begin
    ext_imm12 <= "1111" & instr(15 downto 4) when instr(15) = '1' else
                 "0000" & instr(15 downto 4);
    ext_imm8 <= "11111111" & instr(15 downto 8) when instr(15) = '1' else
                "00000000" & instr(15 downto 8);
    reg <= instr(7 downto 5);
    funct8 <= instr(15 downto 8);
    funct1 <= instr(4);
    opcode <= instr(3 downto 0);

    pc_wr_en <= '1' when state = "10" else
                '0';
    instr_wr_en <= '1' when state = "01" else
                   '0';
    acc_wr_en <= '1' when state = "10" and (
                         (opcode(2 downto 0) = "000" and funct8 /= "00000010")
                         or opcode(2 downto 0) = "010"
                         or (opcode = "0011" and funct1 = '0')
                         or (opcode = "1001" and funct1 = '0')
                     ) else
                 '0';
    bank_wr_en <= '1' when state = "10" and (
                          (opcode = "0011" and funct1 = '1')
                          or (opcode = "1001" and funct1 = '1')
                      ) else
                  '0';
    pc_data_in <= ext_imm12 when opcode = "1100" else
                  pc + "0000000000000001";
    ext_imm <= ext_imm8 when opcode = "1001" else
               ext_imm12;
    acc_data_in_sel <= "10" when opcode = "1001" and funct1 = '0' else
                       "01" when opcode = "0011" and funct1 = '0' else
                       "00";
    alu_op <= "101" when opcode(2 downto 0) = "010" else
              "100" when opcode = "0000" and funct8 = "00000010"
                                         and funct1 = '1' else
              "011" when opcode = "0000" and funct8 = "00000010"
                                         and funct1 = '0' else
              "010" when opcode = "0000" and funct8 = "00000001"
                                         and funct1 = '1' else
              "001" when opcode = "0000" and funct8 = "00000001"
                                         and funct1 = '0' else
              "000";
    bank_data_in_sel <= '1' when opcode = "1001" and funct1 = '1' else
                        '0';
    alu_a_sel <= '1' when opcode = "1000" or opcode = "1010" else
                 '0';
    bank_addr_r_a <= reg;
    bank_addr_r_b <= "000";
    bank_addr_w <= reg;
end architecture;

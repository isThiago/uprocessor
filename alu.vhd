library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port(
        a, b: in unsigned(15 downto 0);
        op: in unsigned(2 downto 0);
        res: out unsigned(15 downto 0);
        z, c: out std_logic
    );
end entity;

architecture a_alu of alu is
    constant zero16: unsigned(15 downto 0) := "0000000000000000";
    signal add17: unsigned(16 downto 0);
    signal mul32: unsigned(31 downto 0);
    signal ctz: unsigned(15 downto 0);
    signal res_s: unsigned(15 downto 0);
begin
    add17 <= ("0" & a) + ("0" & b);
    mul32 <= a * b;
    ctz <= "0000000000010000" when a              = "0000000000000000" else
           "0000000000001111" when a(14 downto 0) = "000000000000000" else
           "0000000000001110" when a(13 downto 0) = "00000000000000" else
           "0000000000001101" when a(12 downto 0) = "0000000000000" else
           "0000000000001100" when a(11 downto 0) = "000000000000" else
           "0000000000001011" when a(10 downto 0) = "00000000000" else
           "0000000000001010" when a(9  downto 0) = "0000000000" else
           "0000000000001001" when a(8  downto 0) = "000000000" else
           "0000000000001000" when a(7  downto 0) = "00000000" else
           "0000000000000111" when a(6  downto 0) = "0000000" else
           "0000000000000110" when a(5  downto 0) = "000000" else
           "0000000000000101" when a(4  downto 0) = "00000" else
           "0000000000000100" when a(3  downto 0) = "0000" else
           "0000000000000011" when a(2  downto 0) = "000" else
           "0000000000000010" when a(1  downto 0) = "00" else
           "0000000000000001" when a(0)           = '0' else
           zero16;
    res_s <= a + b when op = "000" else -- add A, Rn
             b - a when op = "001" or op = "011" else -- sub A, Rn; cmp A, Rn
             a - b when op = "010" or op = "100" else -- sub Rn, A; cmp Rn, A
             mul32(15 downto 0) when op = "101" else -- mul A, Rn
             ctz when op = "110" else -- ctz A, Rn
             zero16;
    z <= '1' when res_s = zero16 else
         '0';
    c <= '1' when (op = "000" and add17(16) = '1')
             or ((op = "001" or op = "011") and b < a)
             or ((op = "010" or op = "100") and a < b)
             or (op = "101" and mul32(31 downto 16) > zero16) else
         '0';
    res <= res_s when op /= "011" and op /= "100" else
           zero16;
end architecture;

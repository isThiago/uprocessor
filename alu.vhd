library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port(
        a, b: in unsigned(15 downto 0);
        op: in unsigned(1 downto 0);
        res: out unsigned(15 downto 0);
        eq, lt: out std_logic
    );
end entity;

architecture a_alu of alu is
    signal mul32: unsigned(31 downto 0);
begin
    mul32 <= a * b;
    res <= a + b when op = "00" else
           a - b when op = "01" else
           mul32(15 downto 0) when op = "10" else
           a xor b when op = "11" else
           "0000000000000000";
    eq <= '1' when a = b else
          '0';
    lt <= '1' when a < b else
          '0';
end architecture;

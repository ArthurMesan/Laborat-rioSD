library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_alu is
end tb_alu;

architecture arch of tb_alu is

component alu is
generic (
        W       :       integer := 4
    );
    port (
        CONTROL : in    std_logic_vector(3 downto 0);
        SRC1    : in    std_logic_vector(W - 1 downto 0);
        SRC2    : in    std_logic_vector(W - 1 downto 0);
        RESULT  : out   std_logic_vector(W - 1 downto 0);
        ZERO    : out   std_logic
    );
end component;

signal CONTROL, SRC1, SRC2, RESULT: std_logic_vector(3 downto 0);
signal ZERO: std_logic;

begin
instancia_alu: alu port map(CONTROL => CONTROL, SRC1 => SRC1, SRC2 => SRC2, RESULT => RESULT, ZERO=>ZERO);
  
  CONTROL <= "0000" after 20 ns, "0000" after 40 ns, "0001" after 60 ns, "0010" after 80 ns, "0110" after 100 ns, "0111" after 120 ns, "1100" after 140 ns;
  SRC1 <= "0000" after 10 ns, "0001" after 30 ns, "0010" after 50 ns, "0001" after 70 ns, "0101" after 90 ns, "0110" after 110 ns, "0001" after 130 ns;
  SRC2 <= "0000" after 10 ns, "1000" after 30 ns, "0100" after 50 ns, "0101" after 70 ns, "0001" after 90 ns, "0010" after 110 ns, "1001" after 130 ns;
end arch;
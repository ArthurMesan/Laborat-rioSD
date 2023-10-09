LIBRARY IEEE;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_funcao is
end tb_funcao;

architecture arch of tb_funcao is

component funcao is
	port ( x : in std_logic_vector(3 downto 0);
			 r : in std_logic_vector(3 downto 0);
			 f : out std_logic_vector(7 downto 0)
		);
end component;

signal x, r : std_logic_vector(3 downto 0);
signal f : std_logic_vector(7 downto 0);

begin
instancia_funcao : funcao port map(x => x, r => r, f => f);
	x <= "0000", "0001" after 5 ns;
	r <= "0010";
end arch;
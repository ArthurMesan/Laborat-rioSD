LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity funcao is
	port ( x : in std_logic_vector(3 downto 0);
			 r : in std_logic_vector(3 downto 0);
			 f : out std_logic_vector(11 downto 0)
		);
end funcao;

architecture arch of funcao is
signal not_x : std_logic_vector(3 downto 0);
begin
		not_x <= not x;
		f <= std_logic_vector(unsigned(x) * unsigned(not_x) * unsigned(r));
	
end arch;

--f(x)= r*x*not(x), sendo r=2, para qualquer valor de x e  assuma no máximo 4 bits de representação. Escreva um arquivo testbench para testar a sua
-- descrição vhdl sintetizada. Simule o sistema e apresente o que você desenvolveu ao professor da disciplina
LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity funcao is
	port ( x : in std_logic_vector(3 downto 0);
			 r : in std_logic_vector(3 downto 0);
			 f : out std_logic_vector(7 downto 0)
		);
end funcao;

architecture arch of funcao is
		signal not_x : unsigned(3 downto 0);
		signal t_x : unsigned(3 downto 0);
		signal t_r : unsigned(3 downto 0);

begin
		not_x <= to_unsigned(not x);
		t_x <= to_unsigned(x);
		t_r <= to_unsigned(r);
		process(x)
			begin
			f <= std_logic_vector(t_x * t_r * not_x);
			--f <= (x * (not x));
		end process;
end arch;

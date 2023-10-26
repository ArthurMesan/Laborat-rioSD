LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_maquina is
end tb_maquina;

architecture arch of tb_maquina is

component maquina is
	port ( INPUT : in std_logic_vector(3 downto 0);
			  finaliza : in std_logic; --verifica nenhuma entrada sera mais setada
           OUTPUT : out std_logic_vector(3 downto 0);
			  clock : in std_logic;
			  reset : in std_logic;
			  i : in std_logic; --verifica se é para somar ou subtrair 1 soma 0 subtrai
			  estado : out std_logic_vector(3 downto 0)
        );
end component;

signal INPUT, OUTPUT, estado : std_logic_vector(3 downto 0);
signal finaliza, reset, i : std_logic;
signal clock : std_logic := '0';

begin
instancia_maquina : maquina port map(INPUT => INPUT, OUTPUT => OUTPUT, finaliza => finaliza, clock => clock, reset => reset, i => i, estado => estado);
	clock <= NOT clock after 5 ns;
	INPUT <= "0000", "0001" after 5 ns, "0010" after 10 ns;
	finaliza <= '0' after 5 ns, '1' after 15 ns;
	reset <= '0';
	i <= '1';
end arch;
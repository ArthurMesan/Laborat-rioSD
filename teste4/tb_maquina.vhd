LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_maquina is
end tb_maquina;

architecture arch of tb_maquina is

component maquina is
	port ( INPUT : in std_logic_vector(3 downto 0);
			  clock : in std_logic;
			  reset : in std_logic;
			  i : in std_logic; --verifica se é para somar ou subtrair 1 soma 0 subtrai
			  x : in std_logic; -- no estado B é usado para trocar de estado, no caso para o C.
			  f : in std_logic;	--verifica nenhuma entrada sera mais setada
			  estado : out std_logic_vector(3 downto 0);
			  OUTPUT : out std_logic_vector(3 downto 0);
			  val_ld : out std_logic;
			  sum_ld : out std_logic; 
			  out_ld : out std_logic
			  
        );
end component;

signal INPUT, OUTPUT, estado : std_logic_vector(3 downto 0);
signal f, reset, i, x, val_ld, sum_ld, out_ld: std_logic;
signal clock : std_logic := '0';

begin
instancia_maquina : maquina port map(INPUT => INPUT, clock => clock, reset => reset, 
												 i => i, x => x, f => f, 
												 estado => estado, OUTPUT => OUTPUT, val_ld => val_ld,
												 sum_ld => sum_ld, out_ld => out_ld);
	clock <= NOT clock after 5 ns;
	INPUT <= "0000", "0010" after 25 ns;
	x <= '0', '1' after 15 ns, '0' after 25 ns;
	f <= '0', '1' after 30 ns, '0' after 50 ns;
	reset <= '1', '0' after 4 ns, '0' after 55 ns;
	i <= '0','1' after 25 ns, '0' after 35 ns;
end arch;
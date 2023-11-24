LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity tb_Vaga is
end tb_Vaga;

architecture RTL OF tb_Vaga is

component Vaga is
	port(
     sensor : in std_logic;
	  clock  : in std_logic;
	  reset  : in std_logic;
	  tempo  : out std_logic_vector(3 downto 0);
	  valor  : out std_logic_vector(3 downto 0)
  );
end component;
signal sensor : std_logic;
signal clock : std_logic := '0';
signal reset : std_logic;
signal tempo, valor : std_logic_vector(3 downto 0);


begin
instancia_vaga : Vaga port map(sensor => sensor, clock => clock, reset => reset, tempo => tempo, valor => valor);

		sensor <= '0', '1' after 5 ns, '0' after 1500 ns;
		reset <= '0';
		clock <= not clock after 5 ns;
end RTL;
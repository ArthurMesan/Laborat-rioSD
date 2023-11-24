LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity tb_temporiza_vaga is
end tb_temporiza_vaga;

architecture RTL OF tb_temporiza_vaga is

component temporiza_vaga is
	 port (sensor : in std_logic;
			clock  : in std_logic;
			minutos: out std_logic_vector(3 downto 0);
			valor  : out std_logic_vector(3 downto 0));
end component;

signal sensor : std_logic;
signal clock : std_logic := '0';
signal minutos, valor: std_logic_vector(3 downto 0);

begin
instancia_temporiza_vaga : temporiza_vaga port map(sensor => sensor, clock => clock, minutos => minutos, valor => valor);

		sensor <= '0', '1' after 50 ns, '0' after 2000 ns;
		clock <= not clock after 5 ns;

end RTL;
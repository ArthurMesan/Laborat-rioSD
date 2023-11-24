LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity tb_datapath_vaga is
end tb_datapath_vaga;

architecture RTL OF tb_datapath_vaga is

component datapath_vaga is
	port ( sensor  : in std_logic;
			  ld_vaga : in std_logic;
			  cl_vaga : in std_logic;
			  clock   : in std_logic;
			  tempo   : out std_logic_vector(3 downto 0);
			  valor   : out std_logic_vector(3 downto 0)
        );
end component;
signal sensor, ld_vaga, cl_vaga : std_logic;
signal clock : std_logic := '0';
signal tempo, valor : std_logic_vector(3 downto 0);


begin
instancia_datapath : datapath_vaga port map(sensor => sensor, ld_vaga => ld_vaga, cl_vaga => cl_vaga, tempo => tempo, valor => valor, clock => clock);

		sensor <= '0', '1' after 5 ns, '0' after 1950 ns;
		ld_vaga <= '1';
		cl_vaga <= '0';
		clock <= not clock after 5 ns;
end RTL;
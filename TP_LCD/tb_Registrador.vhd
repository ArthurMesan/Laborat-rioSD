LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity tb_Registrador is
end tb_Registrador;

architecture RTL OF tb_Registrador is

component Registrador is
	port ( entrada : in std_logic_vector(3 downto 0);
           saida   : out std_logic_vector(3 downto 0);
			  clock   : in std_logic;
			  reset   : in std_logic;
			  ld      : in std_logic
        );
end component;
signal reset, ld : std_logic;
signal clock : std_logic := '0';
signal entrada, saida : std_logic_vector(3 downto 0);


begin
instancia_Registrador : Registrador port map(entrada => entrada, saida => saida, ld => ld, reset => reset, clock => clock);

		entrada <= "0100";
		ld <= '0', '1' after 100 ns, '0' after 150 ns;
		reset <= '0';
		clock <= not clock after 5 ns;
end RTL;
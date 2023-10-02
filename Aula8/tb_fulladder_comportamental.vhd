library ieee;
use ieee.std_logic_1164.all;

entity tb_fulladder_comportamental is
end tb_fulladder_comportamental;

architecture arch of tb_fulladder_comportamental is

component fulladder_comportamental is
	port ( Cin : in std_logic;
           x   : in std_logic;
           y   : in std_logic;
           s   : out std_logic;
           Cout : out std_logic
        );
end component;

signal Cin: std_logic;
signal x, y, s, Cout : std_logic;

begin
instancia_fulladder_comportamental: fulladder_comportamental port map(Cin => Cin, x => x, y => y, s => s, Cout => Cout);

process
	begin
--coisas
		D <= '1' after 5 ns, '0' after 5 ns, '1' after 5 ns;
		FOR I IN 1 TO 12 LOOP
		WAIT FOR 5 NS;
		CLOCK <= NOT CLOCK;
		END LOOP;
		WAIT;	
end process;
end arch;
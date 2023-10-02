library ieee;
use ieee.std_logic_1164.all;

entity tb_FlipFlopD is
end tb_FlipFlopD;

architecture arch of tb_FlipFlopD is

component FlipFlopD_data is
	port( clock: in std_logic;
		  D: in std_logic;
	      Q: out std_logic
	    );
end component;

signal clock: std_logic := '0' ;
signal D, Q : std_logic;

begin
instancia_FlipFlopD_data: FlipFlopD_data port map(clock => clock, D => D, Q => Q);

process
	begin
	
		D <= '1' after 5 ns, '0' after 5 ns, '1' after 5 ns;
		FOR I IN 1 TO 12 LOOP
		WAIT FOR 5 NS;
		CLOCK <= NOT CLOCK;
		END LOOP;
		WAIT;	
end process;
end arch;
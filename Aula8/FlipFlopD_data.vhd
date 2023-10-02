LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity FlipFlopD is
	port( clock: in std_logic;
		  D: in std_logic;
	      Q: out std_logic
	    );
end FlipFlopD;

architecture arch of FlipFlopD is
begin
	
	Q <= D when rising_edge(clock);
		
end arch;
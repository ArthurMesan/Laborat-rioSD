library ieee;
use ieee.std_logic_1164.all;

entity teste_7seg is 
	port (i : in  std_logic_vector (3 downto 0);
			o : out std_logic_vector (6 downto 0));
end teste_7seg;

architecture teste_arch of teste_7seg is 
begin
	with i select 
		o <= "1000000" when "0000",
			  "1111001" when "0001",
			  "1111111" when "0000";
end teste_arch;
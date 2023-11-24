-- Quartus Prime VHDL Template
-- Unsigned Adder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unsigned_adder is
	port 
	(
		a	   : in std_logic_vector(3 downto 0);
		b	   : in std_logic_vector(3 downto 0);
		result : out std_logic_vector(3 downto 0)
	);
end entity;

architecture rtl of unsigned_adder is
begin

	result <= std_logic_vector(unsigned(a) + unsigned(b));

end rtl;
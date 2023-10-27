-- Quartus Prime VHDL Template
-- Unsigned Adder/Subtractor

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unsigned_adder_subtractor is

	generic
	(
		DATA_WIDTH : natural := 4
	);

	port 
	(
		a		: in std_logic_vector ((DATA_WIDTH-1) downto 0);
		b		: in std_logic_vector ((DATA_WIDTH-1) downto 0);
		add_sub : in std_logic;
		result	: out std_logic_vector ((DATA_WIDTH-1) downto 0)
	);

end entity;

architecture rtl of unsigned_adder_subtractor is
begin
	process(a,b,add_sub)
	variable x : unsigned(3 downto 0);
	begin
		-- add if "add_sub" is 1, else subtract
		if (add_sub = '1') then
			x := unsigned(a) + unsigned(b);
			result <= std_logic_vector(x); 
		else
			x := unsigned(a) - unsigned(b);
			result <= std_logic_vector(x); 
		end if;
	end process;

end rtl;

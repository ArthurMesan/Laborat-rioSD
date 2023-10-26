LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity registrador is
    port ( entrada : in std_logic_vector(3 downto 0);
           saida : out std_logic_vector(3 downto 0);
			  clock : in std_logic;
			  reset : in std_logic;
			  lg : in std_logic
        );
end registrador;

architecture arch of regitrador is

begin

registrador : process (clock, reset)
begin
	-- Reset whenever the reset signal goes low, regardless of the clock
	if (reset = '0') then
		saida <= '0';
	-- If not resetting, update the register output on the clock's rising edge
	elsif (rising_edge(clock)) and lg then
		saida <= entrada;
	end if;
end process;
end arch;

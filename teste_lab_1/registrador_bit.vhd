LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity registrador_bit is
    port ( entrada : in std_logic;
           saida   : out std_logic;
			  clock   : in std_logic;
			  reset   : in std_logic;
			  ld      : in std_logic
        );
end registrador_bit;

architecture arch of registrador_bit is

begin

registrador : process (clock, reset, ld)
begin
	if (reset = '1') then
		saida <= '0';
	elsif rising_edge(clock) and (ld = '1') then
		saida <= entrada;
	end if;
end process;
end arch;
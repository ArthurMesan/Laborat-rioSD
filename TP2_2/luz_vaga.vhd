library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity luz_vaga is
	port 
	(
		ligar		: in std_logic;
		saida	: out std_logic
	);
end entity;

architecture arch of luz_vaga is

begin
    process (ligar)
    begin
        if ligar = '1' then
            saida <= '1';
        else
            saida <= '0';
        end if;
    end process;
end arch;
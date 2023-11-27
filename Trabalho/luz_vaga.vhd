library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity luz_vaga is
	port 
	(
		sensor		   : in std_logic;
		led_verde	   : out std_logic;
		led_vermelho	: out std_logic
	);
end entity;

architecture arch of luz_vaga is

begin
    process (sensor)
    begin
        if (sensor = '1') then
            led_verde <= '1';
				led_vermelho <= '0';
        else
            led_verde <= '0';
				led_vermelho <= '1';
        end if;
    end process;
end arch;
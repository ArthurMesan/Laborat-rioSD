library ieee;
use ieee.std_logic_1164.all;

entity sensor_estacionamento is 
	port (sensor : in std_logic;
			clock  : in std_logic;
			tempo : out std_logic_vect);
end sensor_estacionamento;

architecture arch of sensor_estacionamento is 

begin
	
	
		when rising_edge then 
			soma <= soma + 1;  
			led_vermelho <= '0';
		when soma = 1000
			soma <= 0;
			segundos= segundos+1;
		when segundos=60 then
			segundos <= 0;
			minutos <= minutos+1;
		when minutos=60 then
			minutos <= 0;
			hora <= minutos+1;
		when hora=24 then 
			hora <=0;
		end if;
	
end arch;

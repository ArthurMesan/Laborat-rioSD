library ieee;
use ieee.std_logic_1164.all;

entity Temporizador is 
	port (sensor : in std_logic;
			clock  : in std_logic;
			hora: out integer;
			minutos: out integer;
			segundos: out integer);
end Temporizador;

architecture arch of temporizador is 

begin
	
	process (minutos, hora, segundos, soma)
	begin 
		If sensor='1'  then 
		if rising_edge(clock) then  
			 	
				soma <= soma + 1;
			if	soma = 1000 then			
				soma <= 0;
				segundos <= segundos+1;
			end if;	
			if segundos=60 then
				segundos <= 0;
				minutos <= minutos+1;
			end if;		
			if minutos=60 then 
				minutos <= 0;
				hora <= minutos+1;
			end if;	
			if hora=24  then 
				hora <=0;
         end if;		
		end if;
		end if;
		
		end process;
	
end arch;
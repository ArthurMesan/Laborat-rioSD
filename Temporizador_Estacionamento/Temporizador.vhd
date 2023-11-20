library ieee;
use ieee.std_logic_1164.all;

entity Temporizador is 
	port (sensor : in std_logic;
			clock  : in std_logic;
			hora: out integer;
			minutos: out integer;
			segundos: out integer);
end Temporizador;

architecture arch of Temporizador is 

begin
	
	process (sensor, clock)
	variable soma, var_segundos, var_minutos, var_horas: integer:=0; 
	begin 
		If sensor='1'  then 
		if rising_edge(clock) then  
			 	
				soma := soma + 1;
			if	soma = 1 then			
				soma :=0;
				var_segundos := var_segundos+1;
			end if;	
			if var_segundos=60 then
				var_segundos := 0;
				var_minutos := var_minutos+1;
			end if;		
			if var_minutos=60 then 
				var_minutos := 0;
				var_horas := var_horas+1;
			end if;	
			if var_horas=24  then 
				var_horas := 0;
         end if;		
		end if;
		else 
		var_segundos:= 0;
		var_minutos:= 0;
		var_horas:= 0;
		
		end if;
		segundos <= var_segundos;
		minutos <= var_minutos;
		hora <= var_horas;
		
		end process;
	
end arch;
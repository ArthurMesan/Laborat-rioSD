library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity temporiza_vaga is 
	port (sensor : in std_logic;
			clock  : in std_logic;
			minutos: out std_logic_vector(3 downto 0);
			valor  : out std_logic_vector(3 downto 0));
end temporiza_vaga;

architecture arch of temporiza_vaga is 
--signal var_minutos , var_segundos: integer := 0;
--variable soma, var_segundos, var_minutos, var_horas: integer:=0;
begin
	
	process (sensor, clock)
	variable soma, var_segundos, var_minutos, var_horas: integer:=0;
	variable valor_1 : std_logic_vector(3 downto 0);
	begin 
	  If sensor='1'  then 
		 if rising_edge(clock) then  
			 	
			
			var_segundos := var_segundos + 1;	
			if var_segundos=60 then
				var_segundos := 0;
				var_minutos := var_minutos+1;
			else
				var_minutos := var_minutos;
			end if;		
		end if;
	  else 
		var_segundos:= 0;
		--var_minutos:= 0;
		
	  end if;
		minutos <= std_logic_vector(to_unsigned(var_minutos, 4));
		valor_1 := std_logic_vector(to_unsigned(var_minutos/2, 4));
		valor <= valor_1;
		
	end process;
end arch;
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_Temporizador is
end tb_Temporizador;

architecture teste of tb_Temporizador is

component Temporizador is
port (	sensor: in std_logic;
		   segundos: out integer;
			minutos: out integer;
			hora: out integer;
			clock: in std_logic);
end component;

signal sensor: std_logic;
signal minutos: integer;
signal segundos: integer;
signal hora: integer;
signal clock: std_logic:='0';
begin
instancia_tb_Temporizador :Temporizador  port map(sensor=>sensor,minutos=>minutos,segundos=>segundos,hora=>hora,clock=>clock);

sensor <= '1' after 1 ns,  '0' after 65 ns,  '1' after 70 ns, '1' after 120 ns;

process

	begin
	 
	 for i in 1 to 180000 loop
      wait for 2 ns;
      clock <= not clock;	
    end loop;
	 wait;
end process;
end teste;
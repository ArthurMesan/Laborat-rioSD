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
			soma: out integer;
			clock: out std_logic);
end component;

signal sensor: std_logic;
signal minutos: integer;
signal segundos: integer;
signal hora: integer;
signal soma: integer;
signal clock: std_logic;
begin
instancia_tb_Temporizador :Temporizador  port map(sensor=> sensor, minutos=> minutos, segundos=> segundoshora=>hora,soma=>soma,clock=>clock);
process
	begin
	 INPUT <= sensor '1' after 1 ns, sensor '0' after 65 ns, sensor '1' after 70 ns, x'1' after 120 ns;
	 for i in 1 to 50 loop
      wait for 2 ns;
      CLK <= not CLK;	
    end loop;
	 wait;
end process;
end teste;
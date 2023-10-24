LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;

entity maquina is
    port ( INPUT : in integer;
			  finaliza : in std_logic; --verifica nenhuma entrada sera mais setada
           output : out integer;
			  clock : in std_logic;
			  reset : in std_logic;
			  i : in std_logic; --verifica se é para somar ou subtrair 1 soma 0 subtrai
        );
end maquina;

architecture arch OF maquina is
		TYPE State_type IS (A, B, C, D);
		SIGNAL y : State_type;
		variable x, y, z : std_logic;
		variable soma : integer;
begin
	process (reset, clock, finaliza, i)
		begin
			if reset = '1' then
			y <= A;
			elsif (Clock'EVENT AND Clock = '1') then
				CASE y IS
					WHEN A =>
						soma <= 0;
						y <= B	
						end if;
					WHEN B =>
						if (INPUT /= "0000") then
							x <= '1'
						else then
							x <= '0'
						end if;
						if (x and (not finalizou)) = '0'  then
							y <= B;
						elsif (x and (not finalizou)) = '1' then
							y <= C;
						else finalizou = '1' then
							y <= D;
						end if;
					WHEN C =>
						if i = '1' then
						soma <= soma + integer(unsigned(INPUT));
						else
						soma <= soma - integer(unsigned(INPUT));
						end if;
						y <= B;
						
					WHEN D =>
						if soma /= 0 then
							output <= std_logic_vector(unsigned(soma));
						else
							output <= INPUT;
						end if;
						y <= A;
						--mostra na tela (modelsim)???
						--horario da operação realizada+++
						--escrita é feita no tb.
						
						
						
				END CASE;
			END IF;
				
	 
end arch ;

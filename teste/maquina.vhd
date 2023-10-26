LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity maquina is
    port ( INPUT : in std_logic_vector(3 downto 0);
			  finaliza : in std_logic; --verifica nenhuma entrada sera mais setada
           OUTPUT : out std_logic_vector(3 downto 0);
			  clock : in std_logic;
			  reset : in std_logic;
			  i : in std_logic; --verifica se é para somar ou subtrair 1 soma 0 subtrai
			  estado : out std_logic_vector(3 downto 0);
			  
        );
end maquina;

architecture arch OF maquina is
		TYPE State_type IS (A, B, C, D);
		SIGNAL y : State_type := A;
		--variable x : std_logic;
		--variable soma : integer;
		
begin
	process (reset, clock, finaliza, i)
		variable x : std_logic;
		variable soma : integer;
		begin
			if reset = '1' then
			y <= A;
			elsif (Clock'EVENT AND Clock = '1') then
				CASE y IS
					WHEN A =>
						soma := 0;
						y <= B;
						estado <= "0000";
					WHEN B =>
						estado <= "0001";
						if not(INPUT = "0000") then
							x := '1';
						else 
							x := '0';
						end if;
						if x = '1'  then
							y <= B;
						elsif (x and (not finaliza)) = '1' then
							y <= C;
						else
							y <= D;
						end if;
					WHEN C =>
						estado <= "0100";
						if i = '1' then
						soma := soma + to_integer(unsigned(INPUT));
						else
						soma := soma - to_integer(unsigned(INPUT));
						end if;
						y <= B;
						
					WHEN D =>
						estado <= "1000";
						if soma /= 0 then
							output <= std_logic_vector(to_unsigned(soma, 4));
						else
							output <= INPUT;
						end if;
						y <= A;
						
						
						
				END CASE;
			END IF;
		END PROCESS;
	 
end arch ;
LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity maquina is
    port ( input : in integer;
			  i : in std_logic;
           output : out integer;
			  clock : in std_logic;
			  reset : in std_logic
        );
end maquina;

architecture arch OF maquina is
		TYPE State_type IS (A, B, C, D, E);
		SIGNAL y : State_type;
		variable x, y, z : std_logic;
		variable soma : integer;
begin
	process (reset, clock)
		begin
			if reset = '1' then
			y <= A;
			elsif (Clock'EVENT AND Clock = '1') then
				CASE y IS
					WHEN A =>
						if (INPUT /= "0000") then
							x <= '1'
						else
							x <= '0'
						IF x = '0' THEN
							y <= A;
						ELSE
							y <= B;
						END IF;
					WHEN B =>
						if 
					WHEN C =>
						IF w = '0'
							THEN y <= A;
						ELSE y <= C;
						END IF;
					WHEN D =>
						IF w = '0'
							THEN y <= A;
						ELSE y <= C;
						END IF;
					WHEN E =>
						IF w = '0'
							THEN y <= A;
						ELSE y <= C;
						END IF;
				END CASE;
			END IF;
				
	 
end arch ;

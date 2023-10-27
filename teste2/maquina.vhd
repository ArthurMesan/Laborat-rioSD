LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity maquina is
    port ( INPUT : in std_logic_vector(3 downto 0);
			  clock : in std_logic;
			  reset : in std_logic;
			  i : in std_logic; --verifica se é para somar ou subtrair 1 soma 0 subtrai
			  x : in std_logic;
			  f : in std_logic;	--verifica nenhuma entrada sera mais setada
			  estado : out std_logic_vector(3 downto 0);
			  OUTPUT : out std_logic_vector(3 downto 0);
			  val_ld : out std_logic;
			  sum_ld : out std_logic; 
			  out_ld : out std_logic
			  
        );
end maquina;

architecture arch OF maquina is
		TYPE State_type IS (A, B, C, D);
		SIGNAL y : State_type := A;
		
begin
	process (reset, clock, f, i, x)
		begin
			if reset = '1' then
			y <= A;
			elsif (rising_edge(clock)) then
				CASE y IS
					WHEN A =>
						y <= B;
					WHEN B =>
						val_ld <= '1';
						if x = '1' then
							y <= C;
						elsif (not x) = '1' then
							y <= B;
						elsif f = '1' then
							y <= D;
						else
							y <= B;
						end if;
					WHEN C =>
						sum_ld <= '1';
						y <= B;
					WHEN D =>
						out_ld <= '1';
						y <= A;

				END CASE;
			END IF;
		END PROCESS;
	 
end arch ;
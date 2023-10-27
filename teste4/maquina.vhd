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
						val_ld <= '0';
						sum_ld <= '0'; 
						out_ld <= '0';
						y <= B;
						estado <= "0000";
					WHEN B =>
						val_ld <= '1';
						sum_ld <= '0'; 
						out_ld <= '0';
						if f = '1' then
							y <= D;
						elsif (not x) = '1' then
							y <= B;
						else
							y <= C;
						end if;
						estado <= "0001";
					WHEN C =>
						val_ld <= '0';
						sum_ld <= '1'; 
						out_ld <= '0';
						y <= B;
						estado <= "0010";
					WHEN D =>
						val_ld <= '0';
						sum_ld <= '0'; 
						out_ld <= '1';
						y <= A;
						estado <= "0100";
				END CASE;
			END IF;
		END PROCESS;
	 
end arch ;
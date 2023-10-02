library ieee;
use ieee.std_logic_1164.all;

entity pseudo_mux is
    port (
        RESET   : in    std_logic; -- reset input
        CLOCK   : in    std_logic; -- clock input
        S       : in    std_logic; -- control input
        A,B,C,D : in    std_logic; -- data inputs
        Q       : out   std_logic  -- data output
    );
end pseudo_mux;

architecture arch of pseudo_mux is

--	CONSTANT W : STD_LOGIC_VECTOR(2 DOWNTO 0) := "001";
--	CONSTANT X : STD_LOGIC_VECTOR(2 DOWNTO 0) := "010";
--	CONSTANT Y : STD_LOGIC_VECTOR(2 DOWNTO 0) := "011";
--	CONSTANT Z : STD_LOGIC_VECTOR(2 DOWNTO 0) := "100";
	TYPE State_type IS (W, X, Y, Z);
	SIGNAL atual, proximo : State_type := W;

begin
	process(S, atual, A, B, C, D) is
		begin
			case atual is
				when W =>
					Q <= A;
					if S = '1' then
						proximo <= X;
					else 
						proximo <= atual;
					end if;
				when X =>
					Q <= B;
					if S = '1' then
						proximo <= Y;
					else 
						proximo <= atual;
					end if;
				when Y =>
					Q <= C;
					if S = '1' then
						proximo <= Z;
					else 
						proximo <= atual;
					end if;
				when Z =>
					Q <= D;
					if S = '1' then
						proximo <= W;
					else 
						proximo <= atual;
				end if;
				when others => 
					proximo <= W;
				
			end case;
	end process;
	
process(CLOCK, RESET)
begin
    if RESET = '0' then
        atual <= W;
    elsif rising_edge(CLOCK) then
        atual <= proximo;
    end if;
end process;
	
end arch;

library ieee;
use ieee.std_logic_1164.all;

entity pseudo_mux is
    port (
        RESET   : in    std_logic; -- reset input
        CLOCK   : in    std_logic; -- clock input
        S       : in    std_logic; -- control input
        A,B,C,D : in    std_logic; -- data inputs
        Q       : out   std_logic  -- data output
		  --qa,qb,qc,qd : out std_logic
    );
end pseudo_mux;

architecture arch of pseudo_mux is

	SIGNAL atual, proximo : STD_LOGIC_VECTOR(2 DOWNTO 0);
	CONSTANT W : STD_LOGIC_VECTOR(2 DOWNTO 0) := "001";
	CONSTANT X : STD_LOGIC_VECTOR(2 DOWNTO 0) := "010";
	CONSTANT Y : STD_LOGIC_VECTOR(2 DOWNTO 0) := "011";
	CONSTANT Z : STD_LOGIC_VECTOR(2 DOWNTO 0) := "100";

begin
	process(S, atual) is
		begin
--			qa <= '0';
--			qb <= '0';
--			qc <= '0';
--			qd <= '0';
			--Q <= '0';
			case atual is
				when "001" =>
					if S = '1' then
						proximo <= "010";
						Q <= A;
					else 
						proximo <= atual;
					end if;
				when "010" =>
					if S = '1' then
						proximo <= "011";
						Q <= B;
					else 
						proximo <= atual;
					end if;
				when "011" =>
					if S = '1' then
						proximo <= "100";
						Q <= C;
					else 
						proximo <= atual;
					end if;
				when "100" =>
					if S = '1' then
						proximo <= "001";
						Q <= D;
					else 
						proximo <= atual;
				end if;
				when others => 
					proximo <= "001";
				
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display is
	port 
	(
		vetor		   : in std_logic_vector(3 downto 0);
		display      : out std_logic_vector(6 downto 0)
	);
end entity;

architecture arch of display is

begin
	process (vetor)
		begin
			case vetor is
				when "0000" =>
					display <= "1000000";
				when "0001" =>
					display <= "1111001";
				when "0010" =>
					display <= "0100100";
				when "0011" =>
					display <= "0110000";
				when "0100" =>
					display <= "0011001";
				when "0101" =>
					display <= "0010010";
				when "0110" =>
					display <= "0000010";
				when "0111" =>
					display <= "1011000";
				when "1000" =>
					display <= "0000000";
				when "1001" =>
					display <= "0011000";
				when others =>
					display <= "1111111";
			end case;
    end process;
end arch;
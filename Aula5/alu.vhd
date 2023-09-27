library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    generic (
        W       :       integer := 4
    );
    port (
        CONTROL : in    std_logic_vector(3 downto 0);
        SRC1    : in    std_logic_vector(W - 1 downto 0);
        SRC2    : in    std_logic_vector(W - 1 downto 0);
        RESULT  : out   std_logic_vector(W - 1 downto 0);
        ZERO    : out   std_logic
    );
end alu;

architecture arch of alu is
begin
    process(CONTROL, SRC1, SRC2)
	 variable teste : std_logic_vector(W - 1 downto 0);
	 begin
		if CONTROL = "0000" then
			teste := SRC1 and SRC2;
		elsif CONTROL = "0001" then
			teste := SRC1 or SRC2;
		elsif CONTROL = "0010" then
			teste := std_logic_vector(unsigned(SRC1) + unsigned(SRC2));
		elsif CONTROL = "0110" then
			teste := std_logic_vector(unsigned(SRC1) - unsigned(SRC2));
		elsif CONTROL = "0111" then
			if unsigned(SRC1) < unsigned(SRC2) then
				teste := "0001";
			else
				teste := "0000";
			end if;
		elsif CONTROL = "1100" then
			teste := NOT(SRC1 or SRC2);
		end if;
		
		if teste = "0000" then
			ZERO <= '1';
		else
			ZERO <= '0';
		end if;
		
		RESULT <= teste;
	 end process;
end arch;

-- Define the architecture for this entity.
-- Consider the following operations to calculate the value or RESULT:
--      CONTROL             RESULT
--      0000                SRC1 and SRC2 
--      0001                SRC1 or SRC2
--      0010                SRC1 + SRC2
--      0110                SRC1 - SRC2
--      0111                SRC1 < SRC2 ? 1 : 0
--      1100                NOT( SRC1 or SRC2 )

-- Consider the following behavior for the ZERO output:
--  ZERO <= RESULT == 0 ? 1 : 0

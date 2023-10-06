LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity fulladder is
    port ( Cin : in std_logic;
           x   : in std_logic;
           y   : in std_logic;
           s   : out std_logic;
           Cout : out std_logic
        );
end fulladder;
architecture RTL OF fulladder is
begin
	 process(Cin, x, y)
	 begin
--    s <= x XOR y XOR Cin;
--    Cout <= (x AND y) OR (Cin AND x) OR (Cin AND y);

		if (Cin = '1') then 
			if (x='1' and y='1')then
				s<= '1';
				cout <= '1';
			elsif ((x='0' and y='1') or (x='1' and y='0'))then
				s<= '0';
				cout <= '1';
			else 
				s<= '1';
				cout <= '0';
			end if;
			
		else 
			if (x='1' and y='1') then
				s<= '0';
				cout <= '1';
			elsif ((x='0' and y='1') or (x='1' and y='0')) then
				s<= '1';
				cout <= '0';
			else 
				s<= '0';
				cout <= '0';
			end if;
		end if;	
	 end process;
end RTL ;
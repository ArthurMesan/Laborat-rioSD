library ieee;
use ieee.std_logic_1164.all;

entity tb_fulladder_comportamental is
end tb_fulladder_comportamental;

architecture arch of tb_fulladder_comportamental is

component somador is
	port ( A : in std_logic_vector (3 downto 0);
           B   : in std_logic_vector (3 downto 0);
           S   : out std_logic_vector (3 downto 0);
			  cin : in  std_logic;
			  cout: out std_logic
        );
end component;

signal Cin: std_logic;
signal A,B,S : std_logic_vector (3 downto 0);
signal cout: std_logic;


begin
instancia_fulladder_comportamental: somador port map(Cin => Cin, A => A, B => B, S => S, Cout => Cout);


		A <= x"2", x"4" after 5 ns, x"7" after 10 ns, x"B" after 15 ns, x"E" after 25 ns;
		B <= x"1", x"3" after 5 ns, x"6" after 10 ns, x"8" after 15 ns, x"A"after 25 ns;
		Cin <= '0', '1' after 10 ns, '0' after 20 ns, '0'after 25 ns;
--		CLOCK <= NOT CLOCK after 2 ns;

end arch;
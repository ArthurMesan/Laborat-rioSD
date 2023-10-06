LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity somador is
    port ( A : in std_logic_vector (3 downto 0);
           B   : in std_logic_vector (3 downto 0);
           S   : out std_logic_vector (3 downto 0);
			  cin : in  std_logic;
			  cout: out std_logic
        );
end somador;
           

architecture RTL OF somador is
component fulladder is
	port ( Cin : in std_logic;
           x   : in std_logic;
           y   : in std_logic;
           s   : out std_logic;
			  Cout : out std_logic
        );
end component;
	
signal carry1, carry2, carry3: std_logic;

begin
instancia_fulladder0: fulladder port map(Cin => cin, x => A(0), y => B(0), s => s(0), Cout => carry1);
instancia_fulladder1: fulladder port map(Cin => carry1, x => A(1), y => B(1), s => s(1), Cout => carry2);
instancia_fulladder2: fulladder port map(Cin => carry2, x => A(2), y => B(2), s => s(2), Cout => carry3);
instancia_fulladder3: fulladder port map(Cin => carry3, x => A(3), y => B(3), s => s(3), Cout => cout);

	 end RTL ;
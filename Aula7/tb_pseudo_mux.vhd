library ieee;
use ieee.std_logic_1164.all;

entity tb_pseudo_mux is
end tb_pseudo_mux;

architecture arch of tb_pseudo_mux is

component pseudo_mux is
	port (
        RESET   : in    std_logic; -- reset input
        CLOCK   : in    std_logic; -- clock input
        S       : in    std_logic; -- control input
        A,B,C,D : in    std_logic; -- data inputs
        Q       : out   std_logic  -- data output
		  --qa,qb,qc,qd : out std_logic
    );
end component;

signal CLOCK: std_logic := '0' ;
signal RESET : std_logic := '1';
signal S,A,B,C,D,Q : std_logic;
--signal qa,qb,qc,qd : std_logic := '0';

begin
instancia_pseudo_mux: pseudo_mux port map(CLOCK => CLOCK, RESET => RESET, S => S, A => A, B => B, C => C, D => D, Q => Q);

process
	begin
		A <= '1';
		B <= '0';
		C <= '1';
		D <= '0';
		S <= '1' after 5 ns, '0' after 10 ns, '0' after 15 ns, '0' after 20 ns,'1' after 25 ns, '0' after 30 ns,'1' after 35 ns, '0' after 40 ns, '1' after 45 ns;
		FOR I IN 1 TO 12 LOOP
		WAIT FOR 5 NS;
		CLOCK <= NOT CLOCK;
		END LOOP;
		WAIT;	
end process;
end arch;
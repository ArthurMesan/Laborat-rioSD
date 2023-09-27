library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_mean_4_clocks is
end tb_mean_4_clocks;

architecture arch of tb_mean_4_clocks is

component mean_4_clocks is
generic (
        W       :       integer := 4
    );
    port (
        CLK     : in    std_logic;
        RESET   : in    std_logic;
        INPUT   : in    std_logic_vector(W - 1 downto 0);
        OUTPUT  : out   std_logic_vector(W - 1 downto 0)
    );
end component;

signal INPUT, OUTPUT: std_logic_vector(3 downto 0);
signal CLK, RESET: std_logic := '0';

begin
instancia_mean_4_clocks: mean_4_clocks port map(CLK => CLK, RESET => RESET, INPUT => INPUT, OUTPUT => OUTPUT);
process
	begin
	 INPUT <= x"4" after 5 ns, x"4" after 10 ns, x"4" after 15 ns, x"8" after 20 ns;
	 for i in 1 to 20 loop
      wait for 5 ns;
      CLK <= not CLK;
    end loop;
	 wait;
end process;
  
end arch;
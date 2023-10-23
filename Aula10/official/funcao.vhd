LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity funcao is
    port ( x : in std_logic_vector(3 downto 0);
           f : out std_logic_vector(7 downto 0)
        );
end funcao;

architecture arch OF funcao is
signal temp: std_logic_vector(3 downto 0);
signal not_x : std_logic_vector(3 downto 0);
begin
	 temp <= x(2 downto 0) & '0';
	 not_x <= not x;
	 f <= temp * not_x;
end arch ;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

entity tb_comparador is
end tb_comparador;

architecture Behavioral of tb_comparador is

component comparador is
port (
        A, B : in std_logic_vector(3 downto 0);
        Maior, Menor, iguais : out std_logic
    );
end component;

signal A, B: std_logic_vector(3 downto 0);
signal Maior, Menor, iguais: std_logic;
begin
instancia_comparador: comparador port map(A=>A,B=>B,Maior=>Maior, Menor=>Menor, iguais=>iguais);
A <= x"0", x"1" after 20 ns, x"2" after 40 ns, x"4" after 60 ns;
B <= x"0", x"0" after 10 ns, x"3" after 30 ns, x"1" after 50 ns;
end Behavioral;
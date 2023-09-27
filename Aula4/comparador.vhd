library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

entity comparador is
    port (
        A, B : in std_logic_vector(3 downto 0);
        Maior, Menor, iguais : out std_logic
    );
end entity comparador;

architecture Behavioral of comparador is
begin
    process (A, B)
    begin
        if A > B then
            Maior <= '1';
            Menor <= '0';
            iguais <= '0';
        elsif A < B then
            Maior <= '0';
            Menor <= '1';
            iguais <= '0';
        else
            Maior <= '0';
            Menor <= '0';
            iguais <= '1';
        end if;
    end process;
end Behavioral;

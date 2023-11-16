library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity temporiza_vaga is
    port ( 
        periodo : in STD_LOGIC;
		  clock   : in STD_LOGIC;
        tempo   : out STD_LOGIC_VECTOR(3 downto 0);
		  valor   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end temporiza_vaga;

architecture arch of temporiza_vaga is
    signal count : UNSIGNED(3 downto 0) := (others => '0');
    signal tempo_total : UNSIGNED(15 downto 0) := (others => '0');
    signal last_periodo : STD_LOGIC := '0';
begin
    process(periodo)
    begin
        if rising_edge(periodo) then
            if periodo = '1' and last_periodo = '0' then
                count <= (others => '0');
            elsif periodo = '1' and last_periodo = '1' then
                count <= count + 1;
            end if;

            last_periodo <= periodo;

            tempo_total <= tempo_total + count;
        end if;
    end process;

    tempo <= std_logic_vector(tempo_total);
end arch;

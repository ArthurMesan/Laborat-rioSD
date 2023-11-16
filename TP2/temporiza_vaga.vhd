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

architecture Behavioral of temporiza_vaga is
    constant CLOCK_FREQUENCY : integer := 50000000; -- Frequência de clock em Hz (50MHz)

    signal count_total : integer range 0 to CLOCK_FREQUENCY - 1 := 0;
    signal count_x_active : integer range 0 to CLOCK_FREQUENCY - 1 := 0;
    signal x_prev : STD_LOGIC := '0';

begin
    process(clock, periodo)
    begin
        if rising_edge(clock) then
            if periodo = '1' then
                count_x_active <= count_x_active + 1;
            end if;

            if periodo = '1' and x_prev = '0' then
                -- Borda de subida de x
                count_total <= 0;
            else
                count_total <= count_total + 1;
            end if;

            x_prev <= periodo;
        end if;
    end process;

    process(count_x_active, count_total)
    variable total_minutes : integer;
    begin
        if count_x_active = CLOCK_FREQUENCY - 1 then
            -- Evitar divisão por zero
            total_minutes := 0;
        else
            total_minutes := (count_x_active * 60) / (CLOCK_FREQUENCY - 1);
        end if;

        tempo <= std_logic_vector(to_unsigned(total_minutes, 4));
		  valor <= std_logic_vector(to_unsigned(total_minutes/2, 4));
    end process;
end Behavioral;
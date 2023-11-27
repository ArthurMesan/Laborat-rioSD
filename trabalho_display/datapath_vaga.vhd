LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath_vaga is
    port ( sensor  : in std_logic;
			  ld_vaga : in std_logic;
			  cl_vaga : in std_logic;
			  clock   : in std_logic;
			  tempo   : out std_logic_vector(3 downto 0);
			  valor   : out std_logic_vector(3 downto 0)
        );
end datapath_vaga;

architecture arch OF datapath_vaga is

component Registrador is
    port ( entrada : in std_logic_vector(3 downto 0);
           saida   : out std_logic_vector(3 downto 0);
			  clock   : in std_logic;
			  reset   : in std_logic;
			  ld      : in std_logic
        );
end component;

component temporiza_vaga is
    port (sensor : in std_logic;
			clock  : in std_logic;
			minutos: out std_logic_vector(3 downto 0);
			valor  : out std_logic_vector(3 downto 0));
end component;

--signal sensor, ld_vaga, cl_vaga : std_logic;
signal fio_tempo, fio_valor : std_logic_vector(3 downto 0);



begin
--Contador
instancia_temp : temporiza_vaga port map(sensor => sensor, clock => clock, minutos => fio_tempo, valor => fio_valor);
--Registradores
instancia_reg_temp : Registrador port map(entrada => fio_tempo, saida => tempo, clock => clock, reset => cl_vaga, ld => ld_vaga);
instancia_reg_val : Registrador port map(entrada => fio_valor, saida => valor, clock => clock, reset => cl_vaga, ld => ld_vaga);


end arch;
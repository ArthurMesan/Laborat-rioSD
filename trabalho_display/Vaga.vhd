LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Vaga is
 port(
     sensor : in std_logic;
	  clock  : in std_logic;
	  reset  : in std_logic;
	  tempo  : out std_logic_vector(3 downto 0);
	  valor  : out std_logic_vector(3 downto 0)
  );
end Vaga;

architecture arch of Vaga is

component FSM_vaga is
     port(
		sensor : in std_logic;
		clock  : in std_logic;
		reset  : in std_logic;
		cl_vaga : out std_logic;
		ld_vaga : out std_logic
		);
end component;

component datapath_vaga is
    port ( sensor  : in std_logic;
			  ld_vaga : in std_logic;
			  cl_vaga : in std_logic;
			  clock   : in std_logic;
			  tempo   : out std_logic_vector(3 downto 0);
			  valor   : out std_logic_vector(3 downto 0)
        );
end component;

signal fio_sensor, fio_ld_vaga, fio_cl_vaga, fio_reset : std_logic;
signal fio_clock : std_logic;
signal fio_tempo, fio_valor : std_logic_vector(3 downto 0);

begin

instancia_FSM : FSM_Vaga port map(sensor => sensor, clock => clock, reset => reset, ld_vaga => fio_ld_vaga, cl_vaga => fio_cl_vaga);
instancia_datapath : datapath_vaga port map(sensor => sensor, ld_vaga => fio_ld_vaga, cl_vaga => fio_cl_vaga, clock => clock, tempo => tempo, valor => valor);

	
end architecture arch;
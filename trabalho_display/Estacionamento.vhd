LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Estacionamento is
 port(
     start  : in std_logic;
	  reset  : in std_logic;
	  ligado1: in std_logic;
	  ligado2: in std_logic;
	  ligado3: in std_logic;
	  ligado4: in std_logic;
	  s0     : in std_logic;
	  s1     : in std_logic;
	  --clock
	  clock : in std_logic;
	  --sensores
	  tempo_total : out std_logic_vector(6 downto 0);
	  valor_pagar : out std_logic_vector(6 downto 0);
	  total_ganhos: out std_logic_vector(6 downto 0);
	  luz_verde_1 : out std_logic;
	  luz_verde_2 : out std_logic;
	  luz_verde_3 : out std_logic;
	  luz_verde_4 : out std_logic;
	  luz_vermelha_1 : out std_logic;
	  luz_vermelha_2 : out std_logic;
	  luz_vermelha_3 : out std_logic;
	  luz_vermelha_4 : out std_logic
	  
  );
end Estacionamento;

architecture arch of Estacionamento is

component FSM is
port(
     start  : in std_logic;
	  reset  : in std_logic;
	  ligado1: in std_logic;
	  ligado2: in std_logic;
	  ligado3: in std_logic;
	  ligado4: in std_logic;
	  sensor_ar_1   : in std_logic;
	  sensor_ar_2   : in std_logic;
	  sensor_ar_3   : in std_logic;
	  sensor_ar_4   : in std_logic;
	  --load dos registradores
			  ld_sen_1 : out std_logic;
			  ld_temp_1: out std_logic;
			  ld_val_1 : out std_logic;
			  ld_sen_2 : out std_logic;
			  ld_temp_2: out std_logic;
			  ld_val_2 : out std_logic;
			  ld_sen_3 : out std_logic;
			  ld_temp_3: out std_logic;
			  ld_val_3 : out std_logic;
			  ld_sen_4 : out std_logic;
			  ld_temp_4: out std_logic;
			  ld_val_4 : out std_logic;
			  ld_ar_1  : out std_logic;
			  ld_ar_2  : out std_logic;
			  ld_ar_3  : out std_logic;
			  ld_ar_4  : out std_logic;
			  cl_ar_1  : out std_logic;
			  cl_ar_2  : out std_logic;
			  cl_ar_3  : out std_logic;
			  cl_ar_4  : out std_logic;
			  cl_sen_1 : out std_logic;
			  cl_temp_1: out std_logic;
			  cl_val_1 : out std_logic;
			  cl_sen_2 : out std_logic;
			  cl_temp_2: out std_logic;
			  cl_val_2 : out std_logic;
			  cl_sen_3 : out std_logic;
			  cl_temp_3: out std_logic;
			  cl_val_3 : out std_logic;
			  cl_sen_4 : out std_logic;
			  cl_temp_4: out std_logic;
			  cl_val_4 : out std_logic;
			  ld_sum   : out std_logic;
			  cl_sum   : out std_logic;
			  cl_tempo : out std_logic;
	  --clock
	  clock : in std_logic
	  
  );
end component;

component datapath is
    port ( sensor_1   : in std_logic;
			  sensor_2   : in std_logic;
			  sensor_3   : in std_logic;
			  sensor_4   : in std_logic;
			  sensor_11   : in std_logic;
			  sensor_22   : in std_logic;
			  sensor_33   : in std_logic;
			  sensor_44   : in std_logic;
			  clock    : in std_logic;
			  ld_sen_1 : in std_logic;
			  ld_temp_1: in std_logic;
			  ld_val_1 : in std_logic;
			  ld_sen_2 : in std_logic;
			  ld_temp_2: in std_logic;
			  ld_val_2 : in std_logic;
			  ld_sen_3 : in std_logic;
			  ld_temp_3: in std_logic;
			  ld_val_3 : in std_logic;
			  ld_sen_4 : in std_logic;
			  ld_temp_4: in std_logic;
			  ld_val_4 : in std_logic;
			  ld_ar_1  : in std_logic;
			  ld_ar_2  : in std_logic;
			  ld_ar_3  : in std_logic;
			  ld_ar_4  : in std_logic;
			  cl_ar_1  : in std_logic;
			  cl_ar_2  : in std_logic;
			  cl_ar_3  : in std_logic;
			  cl_ar_4  : in std_logic;
			  cl_sen_1 : in std_logic;
			  cl_temp_1: in std_logic;
			  cl_val_1 : in std_logic;
			  cl_sen_2 : in std_logic;
			  cl_temp_2: in std_logic;
			  cl_val_2 : in std_logic;
			  cl_sen_3 : in std_logic;
			  cl_temp_3: in std_logic;
			  cl_val_3 : in std_logic;
			  cl_sen_4 : in std_logic;
			  cl_temp_4: in std_logic;
			  cl_val_4 : in std_logic;
			  ld_sum   : in std_logic;
			  cl_sum   : in std_logic;
			  cl_tempo : in std_logic;
			  s0       : in std_logic;
			  s1       : in std_logic;
			  sensor_antigo_1: out std_logic;
			  sensor_antigo_2: out std_logic;
			  sensor_antigo_3: out std_logic;
			  sensor_antigo_4: out std_logic;
			  tempo    : out std_logic_vector(6 downto 0);
			  valor    : out std_logic_vector(6 downto 0);
			  total    : out std_logic_vector(6 downto 0);
			  luz_verde_1 : out std_logic;
			  luz_verde_2 : out std_logic;
			  luz_verde_3 : out std_logic;
			  luz_verde_4 : out std_logic;
			  luz_vermelha_1 : out std_logic;
			  luz_vermelha_2 : out std_logic;
			  luz_vermelha_3 : out std_logic;
			  luz_vermelha_4 : out std_logic
        );
end component;
--valor_teste, bit_anterior
signal ld_sen_1, ld_sen_2, ld_sen_3, ld_sen_4, cl_sen_1, cl_sen_2, cl_sen_3, cl_sen_4 : std_logic;
signal ld_val_1, ld_val_2, ld_val_3, ld_val_4, cl_val_1, cl_val_2, cl_val_3, cl_val_4 : std_logic;
signal ld_temp_1, ld_temp_2, ld_temp_3, ld_temp_4, cl_temp_1, cl_temp_2, cl_temp_3, cl_temp_4 : std_logic;
signal ld_ar_1, ld_ar_2, ld_ar_3, ld_ar_4, cl_ar_1, cl_ar_2, cl_ar_3, cl_ar_4 : std_logic;
signal ld_sum, cl_sum, ld_tempo, cl_tempo : std_logic;
signal sensor_ar_1,sensor_ar_2,sensor_ar_3,sensor_ar_4 : std_logic;
--signal ligado_1, ligado_2, ligado_3, ligado_4 : std_logic;


begin
--instancia FSM
instancia_estacionamento : FSM port map(start => start, reset => reset, ligado1 => ligado1, ligado2 => ligado2, ligado3 => ligado3,
ligado4 => ligado4, sensor_ar_1 => sensor_ar_1,sensor_ar_2 => sensor_ar_2,sensor_ar_3 => sensor_ar_3,sensor_ar_4 => sensor_ar_4,
ld_sen_1 => ld_sen_1, ld_sen_2 => ld_sen_2, ld_sen_3 => ld_sen_3, ld_sen_4 => ld_sen_4, ld_val_1 => ld_val_1,ld_val_2 => ld_val_2,ld_val_3 => ld_val_3,
ld_val_4 => ld_val_4, ld_temp_1 => ld_temp_1,ld_temp_2 => ld_temp_2,ld_temp_3 => ld_temp_3,ld_temp_4 => ld_temp_4, ld_ar_1 => ld_ar_1,ld_ar_2 => ld_ar_2,
ld_ar_3 => ld_ar_3,ld_ar_4 => ld_ar_4, cl_tempo => cl_tempo, ld_sum => ld_sum, cl_sum => cl_sum,
cl_sen_1 => cl_sen_1, cl_sen_2 => cl_sen_2, cl_sen_3 => cl_sen_3, cl_sen_4 => cl_sen_4, cl_val_1 => cl_val_1,cl_val_2 => cl_val_2, cl_val_3 => cl_val_3,
cl_val_4 => cl_val_4, cl_temp_1 => cl_temp_1, cl_temp_2 => cl_temp_2, cl_temp_3 => cl_temp_3, cl_temp_4 => cl_temp_4, cl_ar_1 => cl_ar_1, cl_ar_2 => cl_ar_2,
cl_ar_3 => cl_ar_3, cl_ar_4 => cl_ar_4, clock => clock);

--instancia_datapath
instancia_datapath : datapath port map(sensor_1 => ligado1, sensor_2 => ligado2, sensor_3 => ligado3, sensor_4 => ligado4, sensor_11 => ligado1,
sensor_22 => ligado2, sensor_33 => ligado3, sensor_44 => ligado4, ld_sen_1 => ld_sen_1, ld_sen_2 => ld_sen_2, ld_sen_3 => ld_sen_3, ld_sen_4 => ld_sen_4, ld_val_1 => ld_val_1,ld_val_2 => ld_val_2,ld_val_3 => ld_val_3,
ld_val_4 => ld_val_4, ld_temp_1 => ld_temp_1,ld_temp_2 => ld_temp_2,ld_temp_3 => ld_temp_3,ld_temp_4 => ld_temp_4, ld_ar_1 => ld_ar_1,ld_ar_2 => ld_ar_2,
ld_ar_3 => ld_ar_3,ld_ar_4 => ld_ar_4, clock => clock, ld_sum => ld_sum, cl_sum =>cl_sum, cl_tempo => cl_tempo,
cl_sen_1 => cl_sen_1, cl_sen_2 => cl_sen_2, cl_sen_3 => cl_sen_3, cl_sen_4 => cl_sen_4, cl_val_1 => cl_val_1,cl_val_2 => cl_val_2, cl_val_3 => cl_val_3,
cl_val_4 => cl_val_4, cl_temp_1 => cl_temp_1, cl_temp_2 => cl_temp_2, cl_temp_3 => cl_temp_3, cl_temp_4 => cl_temp_4, cl_ar_1 => cl_ar_1, cl_ar_2 => cl_ar_2,
cl_ar_3 => cl_ar_3, cl_ar_4 => cl_ar_4, s0 => s0, s1 => s1, sensor_antigo_1 => sensor_ar_1, sensor_antigo_2 => sensor_ar_2, sensor_antigo_3 => sensor_ar_3,
sensor_antigo_4 => sensor_ar_4, tempo => tempo_total, valor => valor_pagar, total => total_ganhos, luz_verde_1 => luz_verde_1,
luz_verde_2 => luz_verde_2, luz_verde_3 => luz_verde_3, luz_verde_4 => luz_verde_4, luz_vermelha_1 => luz_vermelha_1, luz_vermelha_2 => luz_vermelha_2,
luz_vermelha_3 => luz_vermelha_3, luz_vermelha_4 => luz_vermelha_4);
  
end architecture arch;
LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity tb_FSM is
end tb_FSM;

architecture RTL OF tb_FSM is

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
	  clock : in std_logic;
	  --sensores
	  ligado_1 : out std_logic;
	  ligado_2 : out std_logic;
	  ligado_3 : out std_logic;
	  ligado_4 : out std_logic
	  
  );
end component;

signal start, reset : std_logic;
signal ligado1, ligado2, ligado3, ligado4 : std_logic;
signal clock : std_logic := '0';
signal sensor_ar_1, sensor_ar_2, sensor_ar_3, sensor_ar_4 : std_logic;
signal ld_temp_1, ld_val_1, ld_sen_1, ld_temp_2, ld_val_2, ld_sen_2, ld_temp_3, ld_val_3, ld_sen_3, ld_temp_4, ld_val_4, ld_sen_4 : std_logic;
signal ld_sum, cl_sum, cl_tempo : std_logic;
signal ld_ar_1, ld_ar_2, ld_ar_3, ld_ar_4, cl_ar_1, cl_ar_2, cl_ar_3, cl_ar_4 : std_logic;
signal cl_temp_1, cl_val_1, cl_sen_1, cl_temp_2, cl_val_2, cl_sen_2, cl_temp_3, cl_val_3, cl_sen_3, cl_temp_4, cl_val_4, cl_sen_4 : std_logic;

begin
instancia_FSM : FSM port map(start => start, reset => reset, ligado1 => ligado1, ligado2 => ligado2, ligado3 => ligado3,
ligado4 => ligado4, clock => clock, sensor_ar_1 => sensor_ar_1,
sensor_ar_2 => sensor_ar_2, sensor_ar_3 => sensor_ar_3, sensor_ar_4 => sensor_ar_4, ld_sen_1 => ld_sen_1, ld_sen_2 => ld_sen_2, ld_sen_3 => ld_sen_3, ld_sen_4 => ld_sen_4, ld_val_1 => ld_val_1,ld_val_2 => ld_val_2,ld_val_3 => ld_val_3,
ld_val_4 => ld_val_4, ld_temp_1 => ld_temp_1,ld_temp_2 => ld_temp_2,ld_temp_3 => ld_temp_3,ld_temp_4 => ld_temp_4, ld_ar_1 => ld_ar_1,ld_ar_2 => ld_ar_2,
ld_ar_3 => ld_ar_3,ld_ar_4 => ld_ar_4, cl_tempo => cl_tempo,
cl_sen_1 => cl_sen_1, cl_sen_2 => cl_sen_2, cl_sen_3 => cl_sen_3, cl_sen_4 => cl_sen_4, cl_val_1 => cl_val_1,cl_val_2 => cl_val_2, cl_val_3 => cl_val_3,
cl_val_4 => cl_val_4, cl_temp_1 => cl_temp_1, cl_temp_2 => cl_temp_2, cl_temp_3 => cl_temp_3, cl_temp_4 => cl_temp_4, cl_ar_1 => cl_ar_1, cl_ar_2 => cl_ar_2,
cl_ar_3 => cl_ar_3, cl_ar_4 => cl_ar_4);

		start <= '1', '0' after 500 ns;
		reset <= '0';
		sensor_ar_1 <= '0','1' after 100 ns;
		sensor_ar_2 <= '0';
		sensor_ar_3 <= '0';
		sensor_ar_4 <= '0';
		ligado1 <= '0', '1' after 5 ns, '0' after 100 ns;
		ligado2 <= '0';
		ligado3 <= '0';
		ligado4 <= '0';
		clock <= not clock after 5 ns;

end RTL;
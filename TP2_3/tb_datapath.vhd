LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity tb_datapath is
end tb_datapath;

architecture RTL OF tb_datapath is

component datapath is
	port (  sensor_1   : in std_logic;
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
			  tempo    : out std_logic_vector(3 downto 0);
			  valor    : out std_logic_vector(3 downto 0);
			  total    : out std_logic_vector(3 downto 0)
        );
end component;


signal sensor_1, sensor_2, sensor_3, sensor_4 : std_logic;
signal clock : std_logic := '0';
signal sensor_11, sensor_22, sensor_33, sensor_44 : std_logic;
signal ld_temp_1, ld_val_1, ld_sen_1, ld_temp_2, ld_val_2, ld_sen_2, ld_temp_3, ld_val_3, ld_sen_3, ld_temp_4, ld_val_4, ld_sen_4 : std_logic;
signal ld_sum, cl_sum, cl_tempo : std_logic;
signal ld_ar_1, ld_ar_2, ld_ar_3, ld_ar_4, cl_ar_1, cl_ar_2, cl_ar_3, cl_ar_4 : std_logic;
signal cl_temp_1, cl_val_1, cl_sen_1, cl_temp_2, cl_val_2, cl_sen_2, cl_temp_3, cl_val_3, cl_sen_3, cl_temp_4, cl_val_4, cl_sen_4 : std_logic;
signal s0, s1 : std_logic;
signal sensor_antigo_1, sensor_antigo_2, sensor_antigo_3, sensor_antigo_4 : std_logic;
signal tempo, valor, total : std_logic_vector(3 downto 0);

begin
instancia_datapath : datapath port map(sensor_1 => sensor_1, sensor_2 => sensor_2, sensor_3 => sensor_3,
sensor_4 => sensor_4, clock => clock, sensor_11 => sensor_11,
sensor_22 => sensor_22, sensor_33 => sensor_33, sensor_44 => sensor_44, ld_sen_1 => ld_sen_1, ld_sen_2 => ld_sen_2, ld_sen_3 => ld_sen_3, ld_sen_4 => ld_sen_4, ld_val_1 => ld_val_1,ld_val_2 => ld_val_2,ld_val_3 => ld_val_3,
ld_val_4 => ld_val_4, ld_temp_1 => ld_temp_1,ld_temp_2 => ld_temp_2,ld_temp_3 => ld_temp_3,ld_temp_4 => ld_temp_4, ld_ar_1 => ld_ar_1,ld_ar_2 => ld_ar_2,
ld_ar_3 => ld_ar_3,ld_ar_4 => ld_ar_4, cl_tempo => cl_tempo, s0 => s0, s1 => s1, ld_sum => ld_sum, cl_sum => cl_sum,
cl_sen_1 => cl_sen_1, cl_sen_2 => cl_sen_2, cl_sen_3 => cl_sen_3, cl_sen_4 => cl_sen_4, cl_val_1 => cl_val_1,cl_val_2 => cl_val_2, cl_val_3 => cl_val_3,
cl_val_4 => cl_val_4, cl_temp_1 => cl_temp_1, cl_temp_2 => cl_temp_2, cl_temp_3 => cl_temp_3, cl_temp_4 => cl_temp_4, cl_ar_1 => cl_ar_1, cl_ar_2 => cl_ar_2,
cl_ar_3 => cl_ar_3, cl_ar_4 => cl_ar_4, sensor_antigo_1 => sensor_antigo_1, sensor_antigo_2 => sensor_antigo_2, sensor_antigo_3 => sensor_antigo_3,
sensor_antigo_4 => sensor_antigo_4, tempo => tempo, valor => valor, total => total);

		sensor_1 <= '0', '1' after 10 ns, '0' after 1950 ns;
		sensor_2 <= '0';
		sensor_3 <= '0';
		sensor_4 <= '0';
		sensor_11 <= '0', '1' after 10 ns, '0' after 1950 ns;
		sensor_22 <= '0';
		sensor_33 <= '0';
		sensor_44 <= '0';
		ld_sen_1 <= '1';
		ld_ar_1 <= '1';
		ld_temp_1 <= '1';
		ld_val_1 <= '1';
		ld_sen_2 <= '1';
		ld_ar_2 <= '1';
		ld_temp_2 <= '1';
		ld_val_2 <= '1';
		ld_sen_3 <= '1';
		ld_ar_3 <= '1';
		ld_temp_3 <= '1';
		ld_val_3 <= '1';
		ld_sen_4 <= '1';
		ld_ar_4 <= '1';
		ld_temp_4 <= '1';
		ld_val_4 <= '1';
		ld_sum <= '1';
		
		cl_sen_1 <= '0';
	   cl_ar_1 <= '0';
		cl_temp_1 <= '0';
		cl_val_1 <= '0';
		cl_sen_2 <= '0';
		cl_ar_2 <= '0';
		cl_temp_2 <= '0';
		cl_val_2 <= '0';
		cl_sen_3 <= '0';
		cl_ar_3 <= '0';
		cl_temp_3 <= '0';
		cl_val_3 <= '0';
		cl_sen_4 <= '0';
		cl_ar_4 <= '0';
		cl_temp_4 <= '0';
		cl_val_4 <= '0';
		cl_sum <= '0';
		cl_tempo <= '0';
		
		s0 <= '0';
		s1 <= '0';
		
		
		clock <= not clock after 5 ns;

end RTL;
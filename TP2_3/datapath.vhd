LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
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
			  tempo    : out std_logic_vector(3 downto 0);
			  valor    : out std_logic_vector(3 downto 0);
			  total    : out std_logic_vector(3 downto 0);
			  valor_teste : out std_logic_vector(3 downto 0)
        );
end datapath;

architecture arch OF datapath is

component registrador_bit is
    port ( entrada : in std_logic;
           saida   : out std_logic;
			  clock   : in std_logic;
			  reset   : in std_logic;
			  ld      : in std_logic
        );
end component;

component mux_4to1 is
	port(
 
     A,B,C,D : in STD_LOGIC_VECTOR(3 DOWNTO 0);
     S0,S1: in STD_LOGIC;
     Z: out STD_LOGIC_VECTOR(3 DOWNTO 0)
		  );
end component;

component Registrador is
	port ( entrada : in std_logic_vector(3 downto 0);
           saida   : out std_logic_vector(3 downto 0);
			  clock   : in std_logic;
			  reset   : in std_logic;
			  ld      : in std_logic
        );
end component;

component Vaga is
		port(
     sensor : in std_logic;
	  clock  : in std_logic;
	  reset  : in std_logic;
	  tempo  : out std_logic_vector(3 downto 0);
	  valor  : out std_logic_vector(3 downto 0)
     );
end component;

component unsigned_adder is
			port 
	(
		a	   : in std_logic_vector(3 downto 0);
		b	   : in std_logic_vector(3 downto 0);
		result : out std_logic_vector(3 downto 0)
	);
end component;



--signal
signal fio_mux_total, fio_sum, fio_reg_sum : std_logic_vector(3 downto 0);
signal fio_tempo, fio_valor : std_logic_vector(3 downto 0);

--Conexoes entre componentes----------------------------------------------------------
signal fio_temp_1 , fio_val_1, fio_temp_11, fio_val_11 : std_logic_vector(3 downto 0);
signal fio_temp_2 , fio_val_2, fio_temp_22, fio_val_22 : std_logic_vector(3 downto 0);
signal fio_temp_3 , fio_val_3, fio_temp_33, fio_val_33 : std_logic_vector(3 downto 0);
signal fio_temp_4 , fio_val_4, fio_temp_44, fio_val_44 : std_logic_vector(3 downto 0);
signal fio_bit_11, fio_bit_22, fio_bit_33, fio_bit_44 : std_logic;
--------------------------------------------------------------------------------------



begin
--Contador-----------------------------------------------------------------------------------------------------------------------fio_val_1_..
instancia_vaga_1 : Vaga port map(sensor => fio_bit_11, clock => clock, reset => cl_tempo, tempo => fio_temp_1, valor => fio_val_1);
instancia_vaga_2 : Vaga port map(sensor => fio_bit_22, clock => clock, reset => cl_tempo, tempo => fio_temp_2, valor => fio_val_2);
instancia_vaga_3 : Vaga port map(sensor => fio_bit_33, clock => clock, reset => cl_tempo, tempo => fio_temp_3, valor => fio_val_3);
instancia_vaga_4 : Vaga port map(sensor => fio_bit_44, clock => clock, reset => cl_tempo, tempo => fio_temp_4, valor => fio_val_4);
------------------------------------------------------------------------------------------------------------------------------------------

--Registradores binarios------------------------------------------------------------------------------------------------------------------
instancia_reg_bit_1 : registrador_bit port map(entrada => sensor_1, saida => fio_bit_11, clock => clock, reset => cl_sen_1, ld => ld_sen_1);
instancia_reg_bit_2 : registrador_bit port map(entrada => sensor_2, saida => fio_bit_22, clock => clock, reset => cl_sen_2, ld => ld_sen_2);
instancia_reg_bit_3 : registrador_bit port map(entrada => sensor_3, saida => fio_bit_33, clock => clock, reset => cl_sen_3, ld => ld_sen_3);
instancia_reg_bit_4 : registrador_bit port map(entrada => sensor_4, saida => fio_bit_44, clock => clock, reset => cl_sen_4, ld => ld_sen_4);

instancia_reg_ar_1 : registrador_bit port map(entrada => sensor_11, saida => sensor_antigo_1, clock => clock, reset => cl_ar_1, ld => ld_ar_1);
instancia_reg_ar_2 : registrador_bit port map(entrada => sensor_22, saida => sensor_antigo_2, clock => clock, reset => cl_ar_2, ld => ld_ar_2);
instancia_reg_ar_3 : registrador_bit port map(entrada => sensor_33, saida => sensor_antigo_3, clock => clock, reset => cl_ar_3, ld => ld_ar_3);
instancia_reg_ar_4 : registrador_bit port map(entrada => sensor_44, saida => sensor_antigo_4, clock => clock, reset => cl_ar_4, ld => ld_ar_4);
------------------------------------------------------------------------------------------------------------------------------------------

--Registradores 4 bits-------------------------------------------------------------------------------------------------------------------
instancia_reg_temp_1  : Registrador port map(entrada => fio_temp_1, saida => fio_temp_11, clock => clock, reset => cl_temp_1, ld => ld_temp_1);
instancia_reg_temp_2  : Registrador port map(entrada => fio_temp_2, saida => fio_temp_22, clock => clock, reset => cl_temp_2, ld => ld_temp_2);
instancia_reg_temp_3  : Registrador port map(entrada => fio_temp_3, saida => fio_temp_33, clock => clock, reset => cl_temp_3, ld => ld_temp_3);
instancia_reg_temp_4  : Registrador port map(entrada => fio_temp_4, saida => fio_temp_44, clock => clock, reset => cl_temp_4, ld => ld_temp_4);
instancia_reg_valor_1 : Registrador port map(entrada => fio_val_1, saida => fio_val_11, clock => clock, reset => cl_val_1, ld => ld_val_1);
instancia_reg_valor_2 : Registrador port map(entrada => fio_val_2, saida => fio_val_22, clock => clock, reset => cl_val_2, ld => ld_val_2);
instancia_reg_valor_3 : Registrador port map(entrada => fio_val_3, saida => fio_val_33, clock => clock, reset => cl_val_3, ld => ld_val_3);
instancia_reg_valor_4 : Registrador port map(entrada => fio_val_4, saida => fio_val_44, clock => clock, reset => cl_val_4, ld => ld_val_4);
-----------------------------------------------------------------------------------------------------------------------------------------
valor_teste <= fio_val_1;
--Somador--------------------------------------------------------------------------------------------------------------------------------
instancia_reg_soma    : Registrador port map(entrada => fio_sum, saida => fio_reg_sum, clock => clock, reset => cl_sum, ld => ld_sum); 

instancia_somador : unsigned_adder port map(a => fio_mux_total,b => fio_reg_sum , result => fio_sum);
total <= fio_reg_sum;
-----------------------------------------------------------------------------------------------------------------------------------------


--mutiplexadores-------------------------------------------------------------------------------------------------------------------------
instancia_mux_temp : mux_4to1 port map(A => fio_temp_11, B => fio_temp_22, C => fio_temp_33, D => fio_temp_44, s0 => s0, s1 => s1, Z => tempo);
instancia_mux_val : mux_4to1 port map(A => fio_val_11, B => fio_val_22, C => fio_val_33, D => fio_val_44, s0 => s0, s1 => s1, Z => valor);
instancia_mux_total : mux_4to1 port map(A => fio_val_11, B => fio_val_22, C => fio_val_33, D => fio_val_44, s0 => s0, s1 => s1, Z => fio_mux_total);
-----------------------------------------------------------------------------------------------------------------------------------------

end arch;
LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
    port ( --input vindo do acender da luz +
			  --input do motorista ao sair do estacionamento
			  input_1       : in std_logic;
			  input_2       : in std_logic;
			  input_3       : in std_logic;
			  input_4       : in std_logic;
			  s0            : in std_logic;
			  s1            : in std_logic;
			  --output gerados
           tempo_total : out std_logic_vector(3 downto 0);
			  valor_pagar : out std_logic_vector(3 downto 0);
			  total_ganhos: out std_logic_vector(3 downto 0);
			  --clock
			  clock 		  : in std_logic;
			  --load dos registradores
			  ld_1_t      : in std_logic;
			  ld_1_v      : in std_logic;
			  ld_2_t      : in std_logic;
			  ld_2_v      : in std_logic;
			  ld_3_t      : in std_logic;
			  ld_3_v      : in std_logic;
			  ld_4_t      : in std_logic;
			  ld_4_v      : in std_logic;
			  ld_valor    : in std_logic;
			  ld_total    : in std_logic;
			  --Reset dos registradores
			  --reset       : in std_logic;
			  cl_1_t      : in std_logic;
			  cl_1_v      : in std_logic;
			  cl_2_t      : in std_logic;
			  cl_2_v      : in std_logic;
			  cl_3_t      : in std_logic;
			  cl_3_v      : in std_logic;
			  cl_4_t      : in std_logic;
			  cl_4_v      : in std_logic;
			  cl_valor    : in std_logic;
			  cl_total    : in std_logic
        );
end datapath;

architecture arch OF datapath is

component registrador_bit is
    port ( entrada : in std_logic_vector(3 downto 0);
           saida   : out std_logic_vector(3 downto 0);
			  clock   : in std_logic;
			  reset   : in std_logic;
			  ld      : in std_logic
        );
end component;

component temporiza_vaga is
    port ( 
        periodo : in STD_LOGIC;
		  clock   : in STD_LOGIC;
        tempo   : out STD_LOGIC_VECTOR(3 downto 0);
		  valor   : out STD_LOGIC_VECTOR(3 downto 0)
			);
end component;

component luz_vaga is
    port (
		  ligar		: in std_logic;
		  saida	: out std_logic
			);
end component;

component mux_4to1 is
    port(
     A,B,C,D : in STD_LOGIC_VECTOR(3 DOWNTO 0);
     S0,S1: in STD_LOGIC;
     Z: out STD_LOGIC_VECTOR(3 DOWNTO 0)
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

signal fio1, fio2, fio3, fio4 : std_logic;
signal fio_t1 , fio_v1, fio_t2 , fio_v2, fio_t3 , fio_v3, fio_t4 , fio_v4 : std_logic_vector(3 downto 0);
signal fio_rt1 , fio_rv1, fio_rt2 , fio_rv2, fio_rt3 , fio_rv3, fio_rt4 , fio_rv4 : std_logic_vector(3 downto 0);
signal fio_r_valor, fio_sum : std_logic_vector(3 downto 0);
signal tempo_t, valor_pago , valor_total: std_logic_vector(3 downto 0);

begin

--instancia retorna luz
instancia_luz_vaga_1 : luz_vaga port map(ligar => input_1, saida => fio1);
instancia_luz_vaga_2 : luz_vaga port map(ligar => input_2, saida => fio2);
instancia_luz_vaga_3 : luz_vaga port map(ligar => input_3, saida => fio3);
instancia_luz_vaga_4 : luz_vaga port map(ligar => input_4, saida => fio4);

--instancia temporizador
instancia_temp_1 : temporiza_vaga port map(periodo => fio1, clock => clock, tempo => fio_t1, valor => fio_v1);
instancia_temp_2 : temporiza_vaga port map(periodo => fio2, clock => clock, tempo => fio_t2, valor => fio_v2);
instancia_temp_3 : temporiza_vaga port map(periodo => fio3, clock => clock, tempo => fio_t3, valor => fio_v3);
instancia_temp_4 : temporiza_vaga port map(periodo => fio4, clock => clock, tempo => fio_t4, valor => fio_v4);

--instancia registradores
instancia_registrador_T_1 : registrador_bit port map(entrada => fio_t1, saida => fio_rt1, clock => clock, reset => cl_1_t, ld => ld_1_t);
instancia_registrador_T_2 : registrador_bit port map(entrada => fio_t2, saida => fio_rt2, clock => clock, reset => cl_2_t, ld => ld_2_t);
instancia_registrador_T_3 : registrador_bit port map(entrada => fio_t3, saida => fio_rt3, clock => clock, reset => cl_3_t, ld => ld_3_t);
instancia_registrador_T_4 : registrador_bit port map(entrada => fio_t4, saida => fio_rt4, clock => clock, reset => cl_4_t, ld => ld_4_t);

instancia_registrador_V_1 : registrador_bit port map(entrada => fio_v1, saida => fio_rv1, clock => clock, reset => cl_1_v, ld => ld_1_v);
instancia_registrador_V_2 : registrador_bit port map(entrada => fio_v2, saida => fio_rv2, clock => clock, reset => cl_2_v, ld => ld_2_v);
instancia_registrador_V_3 : registrador_bit port map(entrada => fio_v3, saida => fio_rv3, clock => clock, reset => cl_3_v, ld => ld_3_v);
instancia_registrador_V_4 : registrador_bit port map(entrada => fio_v4, saida => fio_rv4, clock => clock, reset => cl_4_v, ld => ld_4_v);

instancia_registrador_valor : registrador_bit port map(entrada => valor_pago, saida => fio_r_valor, clock => clock, reset => cl_valor, ld => ld_valor);
instancia_registrador_total : registrador_bit port map(entrada => fio_sum, saida => total_ganhos, clock => clock, reset => cl_total, ld => ld_total);

--instancia mux
instancia_mux_tempo_t : mux_4to1 port map(A => fio_rt1, B => fio_rt2, C => fio_rt3, D => fio_rt4, S0 => s0, S1 => s1);
instancia_mux_tempo_v : mux_4to1 port map(A => fio_rv1, B => fio_rv2, C => fio_rv3, D => fio_rv4, S0 => s0, S1 => s1);

--instancia somador
instancia_somador : unsigned_adder port map(a => fio_r_valor, b => fio_sum, result => fio_sum);


end arch;
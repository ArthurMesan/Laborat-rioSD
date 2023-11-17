library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity tb_estacionamento is
end tb_estacionamento;
 
architecture arch of tb_estacionamento is

component Estacionamento is
	  port(
			  start  : in std_logic;
			  reset  : in std_logic;
			  ligado1: in std_logic;
			  ligado2: in std_logic;
			  ligado3: in std_logic;
			  ligado4: in std_logic;
			  --load dos registradores
			  ld_1_t      : out std_logic;
			  ld_1_v      : out std_logic;
			  ld_2_t      : out std_logic;
			  ld_2_v      : out std_logic;
			  ld_3_t      : out std_logic;
			  ld_3_v      : out std_logic;
			  ld_4_t      : out std_logic;
			  ld_4_v      : out std_logic;
			  ld_valor    : out std_logic;
			  ld_total    : out std_logic;
					  --Reset dos registradores
					  --reset       : in std_logic;
			  cl_1_t      : out std_logic;
			  cl_1_v      : out std_logic;
			  cl_2_t      : out std_logic;
			  cl_2_v      : out std_logic;
			  cl_3_t      : out std_logic;
			  cl_3_v      : out std_logic;
			  cl_4_t      : out std_logic;
			  cl_4_v      : out std_logic;
			  cl_valor    : out std_logic;
			  cl_total    : out std_logic;
			  --clock
			  clock : out std_logic;
			  --sensores
			  ligado_1 : out std_logic;
			  ligado_2 : out std_logic;
			  ligado_3 : out std_logic;
			  ligado_4 : out std_logic
	  
     );
end component;

component datapath is
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
		  
end component;
signal start, reset, ligado1, ligado2, ligado3, ligado4, ld_1_t, ld_1_v, ld_2_t, ld_2_v, ld_3_t, ld_3_v, ld_4_t, ld_4_v : std_logic;
signal cl_1_t, cl_1_v, cl_2_t, cl_2_v, cl_3_t, cl_3_v, cl_4_t, cl_4_v, ld_valor, cl_valor, ld_total, cl_total : std_logic;
signal ligado_1, ligado_2, ligado_3, ligado_4 : std_logic;
signal clock : std_logic := '0';
signal s0, s1 : std_logic;
signal tempo_total, valor_pagar, total_ganhos: std_logic_vector(3 downto 0);


begin
--instancia estacionamento
instancia_estacionamento : Estacionamento port map(start => start, reset => reset, ligado1 => ligado1, ligado2 => ligado2, ligado3 => ligado3,
ligado4 => ligado4, ld_1_t => ld_1_t, ld_1_v => ld_1_v, ld_2_t => ld_2_t, ld_2_v => ld_2_v, ld_3_t => ld_3_t, ld_3_v => ld_3_v, ld_4_t => ld_4_t,
ld_4_v => ld_4_v, cl_1_t => cl_1_t, cl_1_v => cl_1_v, cl_2_t => cl_2_t, cl_2_v => cl_2_v, cl_3_t => cl_3_t,
cl_3_v => cl_3_v, cl_4_t => cl_4_t, cl_4_v => cl_4_v, ld_valor => ld_valor, cl_valor => cl_valor, ld_total => ld_total, cl_total => cl_total,
clock => clock, ligado_1 => ligado_1, ligado_2 => ligado_2, ligado_3 => ligado_3, ligado_4 => ligado_4);
 
--instancia_datapath : datapath port map();
--instancia_datapath : datapath port map(input_1 => ligado_1, input_2 => ligado_2, input_3 => ligado_3, input_4 => ligado_4, s0 => s0, s1 =>s1,
--tempo_total => tempo_total, valor_pagar => valor_pagar, total_ganhos => total_ganhos, clock => clock, ld_1_t => ld_1_t, ld_1_v => ld_1_v, ld_2_t => ld_2_t,
--ld_2_v => ld_2_v, ld_3_t => ld_3_t, ld_3_v => ld_3_v, ld_4_t => ld_4_t, ld_4_v => ld_4_v, cl_1_t => cl_1_t, cl_1_v => cl_1_v, cl_2_t => cl_2_t,
--cl_2_v => cl_2_v, cl_3_t => cl_3_t, cl_3_v => cl_3_v, cl_4_t => cl_4_t, cl_4_v => cl_1_v, ld_valor => ld_valor, ld_total => ld_total, cl_valor => cl_valor,
--cl_total => cl_total); 

	start  <= '1', '0' after 20 ns;
	reset  <= '0';
	ligado1 <= '1', '0' after 15 ns;
	ligado2 <= '0';
	ligado3 <= '0';
	ligado4 <= '0';
	clock <= not clock after 20 ns;

	
end arch;
LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity tb_Estacionamento is
end tb_Estacionamento;

architecture RTL OF tb_Estacionamento is

component Estacionamento is
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
	  tempo_total : out std_logic_vector(3 downto 0);
	  valor_pagar : out std_logic_vector(3 downto 0);
	  total_ganhos: out std_logic_vector(3 downto 0);
	  valor_teste : out std_logic_vector(3 downto 0)
	  
  );
end component;

signal start, reset : std_logic;
signal ligado1, ligado2, ligado3, ligado4 : std_logic;
signal s0, s1 : std_logic; 
signal clock : std_logic := '0';
signal tempo_total, valor_pagar, total_ganhos, valor_teste : std_logic_vector(3 downto 0);

begin
instancia_Estacionamento : Estacionamento port map(start => start, reset => reset, ligado1 => ligado1, ligado2 => ligado2, ligado3 => ligado3,
ligado4 => ligado4, s0 => s0, s1 => s1, tempo_total => tempo_total, valor_pagar => valor_pagar, total_ganhos => total_ganhos, clock => clock,
valor_teste => valor_teste);

		start <= '1', '0' after 1000 ns;
		reset <= '0';
		s0 <= '0';
		s1 <= '0';
		ligado1 <= '0', '1' after 5 ns, '0' after 1000 ns;
		ligado2 <= '0';
		ligado3 <= '0';
		ligado4 <= '0';
		clock <= not clock after 5 ns;

end RTL;
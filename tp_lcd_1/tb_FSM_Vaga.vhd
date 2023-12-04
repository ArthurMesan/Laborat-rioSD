LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity tb_FSM_Vaga is
end tb_FSM_Vaga;

architecture RTL OF tb_FSM_Vaga is

component FSM_Vaga is
	port(
		sensor : in std_logic;
		clock  : in std_logic;
		reset  : in std_logic;
		cl_vaga : out std_logic;
		ld_vaga : out std_logic
  );
end component;
signal sensor : std_logic;
SIGNAL cl_vaga, ld_vaga : std_logic;
signal clock : std_logic := '0';
signal reset : std_logic;
--signal tempo, valor : std_logic_vector(3 downto 0);


begin
instancia_fsm_vaga : FSM_Vaga port map(sensor => sensor, clock => clock, reset => reset, cl_vaga => cl_vaga, ld_vaga => ld_vaga);

		sensor <= '0', '1' after 5 ns, '0' after 700 ns;
		reset <= '0';
		clock <= not clock after 5 ns;
end RTL;
LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity datapath is
    port ( INPUT : in std_logic_vector(3 downto 0);
           OUTPUT : out std_logic_vector(3 downto 0);
			  clock : in std_logic;
			  reset : in std_logic;
			  i : in std_logic;
			  val_ld : in std_logic;
			  sum_ld : in std_logic;
			  out_ld : in std_logic;
        );
end datapath;

architecture arch OF datapath is

component registrador is
    port ( entrada : in std_logic_vector(3 downto 0);
           saida : out std_logic_vector(3 downto 0);
			  clock : in std_logic;
			  reset : in std_logic;
			  lg : in std_logic
        );
end component;

component unsigned_adder_subtractor is

	generic
	(
		DATA_WIDTH : natural := 4
	);

	port 
	(
		a		: in unsigned ((DATA_WIDTH-1) downto 0);
		b		: in unsigned ((DATA_WIDTH-1) downto 0);
		add_sub : in std_logic;
		result	: out unsigned ((DATA_WIDTH-1) downto 0)
	);

end component;

signal val_, res_, soma_ : std_logic_vector(3 downto 0);
signal clock : std_logic;

begin

instancia_unsigned_adder_subtractor : unsigned_adder_subtractor port map(a => soma_, b => val_, add_sub => i, result => res_);
instancia_registrador_val : registrador port map(entrada => INPUT, saida => val_, clock => clock, reset => reset, lg => val_ld);
instancia_registrador_res_out : registrador port map(entrada => soma_, saida => OUTPUT, clock => clock, reset => reset, lg => out_ld);
instancia_registrador_soma : registrador port map(entrada => res_, saida => soma_, clock => clock, reset => reset, lg => sum_ld);


end arch;


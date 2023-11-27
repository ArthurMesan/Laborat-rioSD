LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FSM_vaga is
 port(
		sensor : in std_logic;
		clock  : in std_logic;
		reset  : in std_logic;
		cl_vaga : out std_logic;
		ld_vaga : out std_logic
  );
end FSM_vaga;

architecture arch of FSM_vaga is
  type estado_t is (inicial, tempo, finaliza);
  signal PE,EA : estado_t;
begin

  sincrono: process(clock, reset, PE)
  begin
    if (reset = '1') then
      EA <= inicial;
    elsif (rising_edge(clock)) then
      EA <= PE;
    end if;
  end process sincrono;

  combinatorio: process(EA, sensor)
  begin
    case(EA) is
      when inicial =>
			ld_vaga <= '0';
			cl_vaga <= '0';
			if sensor = '1' then
				PE <= tempo;
			else
				PE <= inicial;
			end if;
      when tempo =>
			ld_vaga <= '1';
			cl_vaga <= '0';
			if sensor = '1' then
				PE <= tempo;
			else
				PE <= finaliza;
			end if;
		when finaliza=>
			ld_vaga <= '0';
			cl_vaga <= '0';
			PE <= inicial;
      when others =>
         PE <= inicial;
    end case;
  end process combinatorio;

end architecture arch;
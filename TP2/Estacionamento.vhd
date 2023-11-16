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
	  ligado1 : out std_logic;
	  ligado2 : out std_logic;
	  ligado3 : out std_logic;
	  ligado4 : out std_logic;
	  
  );
end Estacionamento;

architecture arch of Estacionamento is
  type estado_t is (inicial, inicial_1, temp_1, temp_2, temp_3, temp_4, zera_1, zera_2, zera_3, zera_4, mostra_valor, soma valores);
  signal PE,EA : estado_t;
begin

  sincrono: process(clock, reset_n, PE)
  begin
    if (reset_n='0') then
      EA <= inicial;
    elsif (rising_edge(clock)) then
      EA <= PE;
    end if;
  end process sincrono;

  combinatorio: process(EA, entrada)
  begin
    saida <= '0';
    case(EA) is
      when inicial =>
        if start = '1' then
          PE <= inicial_1;
        else
          PE <= inicial;
        end if;
      when inicial_1 =>
			  cl_1_t  <= '1';
			  cl_1_v  <= '1';
			  cl_2_t  <= '1';
			  cl_2_v  <= '1';
			  cl_3_t  <= '1';
			  cl_3_v  <= '1';
			  cl_4_t  <= '1';
			  cl_4_v  <= '1';
			  cl_valor <= '1';
			  cl_total <= '1';
			  ld_1_t  <= '0';
			  ld_1_v  <= '0';
			  ld_2_t  <= '0';
			  ld_2_v  <= '0';
			  ld_3_t  <= '0';
			  ld_3_v  <= '0';
			  ld_4_t  <= '0';
			  ld_4_v  <= '0';
			  ld_valor <= '0';
			  ld_total <= '0';
        if ligado1 = '1' then
          PE <= zera_1
        elsif ligado2 = '1' then
          PE <= zera_2;
		  elsif ligado3 = '1' then
          PE <= zera_3;
		  elsif ligado4 = '1' then
          PE <= zera_4;
		  else
			 PE <= inicial_1;
        end if;
		when zera_1=>
			cl_1_t  <= '1';
			cl_1_v  <= '1';
			cl_2_t  <= '0';
			cl_2_v  <= '0';
			cl_3_t  <= '0';
			cl_3_v  <= '0';
			cl_4_t  <= '0';
			cl_4_v  <= '0';
			cl_valor <= '0';
			cl_total <= '0';
			ld_1_t  <= '0';
			ld_1_v  <= '0';
			ld_2_t  <= '0';
			ld_2_v  <= '0';
			ld_3_t  <= '0';
			ld_3_v  <= '0';
			ld_4_t  <= '0';
			ld_4_v  <= '0';
			ld_valor <= '0';
			ld_total <= '0';
			PE <= temp_1
		when temp_1 =>
			if ligado1 = '1' then
				PE <= temp_1;
			else
				PE <= mostra_valor;
			end if;
      when others =>
        saida <= '0';
        PE <= A;
    end case;
  end process combinatorio;

end architecture arch;

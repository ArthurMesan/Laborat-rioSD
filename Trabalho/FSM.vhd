LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FSM is
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
	  clock : in std_logic
	  
  );
end FSM;

architecture arch of FSM is
  type estado_t is (inicial, aguarda, inicia_vaga_1, final_vaga_1, inicia_vaga_2, final_vaga_2, inicia_vaga_3, final_vaga_3, inicia_vaga_4, final_vaga_4, soma);
  signal PE,EA : estado_t;
begin

  sincrono: process(clock, reset, PE, start)
  begin
    if (reset = '1') and (start = '0') then
      EA <= inicial;
    elsif (rising_edge(clock)) then
      EA <= PE;
    end if;
  end process sincrono;

  combinatorio: process(EA, ligado1, ligado2, ligado3, ligado4, sensor_ar_1, sensor_ar_2, sensor_ar_3, sensor_ar_4)
  begin
    case(EA) is
      when inicial =>
			  ld_sen_1 <= '0';
			  ld_temp_1 <= '0';
			  ld_val_1  <= '0';
			  ld_sen_2  <= '0';
			  ld_temp_2 <= '0';
			  ld_val_2  <= '0';
			  ld_sen_3  <= '0';
			  ld_temp_3 <= '0';
			  ld_val_3  <= '0';
			  ld_sen_4  <= '0';
			  ld_temp_4 <= '0';
			  ld_val_4  <= '0';
			  ld_ar_1   <= '0';
			  ld_ar_2   <= '0';
			  ld_ar_3   <= '0';
			  ld_ar_4   <= '0';
			  ld_sum    <= '0';
			  cl_ar_1   <= '1';
			  cl_ar_2   <= '1';
			  cl_ar_3   <= '1';
			  cl_ar_4   <= '1';
			  cl_sen_1  <= '1';
			  cl_temp_1 <= '1';
			  cl_val_1  <= '1';
			  cl_sen_2  <= '1';
			  cl_temp_2 <= '1';
			  cl_val_2 <= '1';
			  cl_sen_3 <= '1';
			  cl_temp_3<= '1';
			  cl_val_3 <= '1';
			  cl_sen_4 <= '1';
			  cl_temp_4<= '1';
			  cl_val_4 <= '1';
			  cl_sum   <= '1';
			  cl_tempo <= '1';
			  PE <= aguarda;
		   
      when aguarda =>
			  ld_sen_1  <= '0';
			  ld_temp_1 <= '0';
			  ld_val_1  <= '0';
			  ld_sen_2  <= '0';
			  ld_temp_2 <= '0';
			  ld_val_2  <= '0';
			  ld_sen_3  <= '0';
			  ld_temp_3 <= '0';
			  ld_val_3  <= '0';
			  ld_sen_4  <= '0';
			  ld_temp_4 <= '0';
			  ld_val_4  <= '0';
			  ld_ar_1   <= '0';
			  ld_ar_2   <= '0';
			  ld_ar_3   <= '0';
			  ld_ar_4   <= '0';
			  ld_sum    <= '0';
			  cl_ar_1   <= '0';
			  cl_ar_2   <= '0';
			  cl_ar_3   <= '0';
			  cl_ar_4   <= '0';
			  cl_sen_1  <= '0';
			  cl_temp_1 <= '0';
			  cl_val_1  <= '0';
			  cl_sen_2  <= '0';
			  cl_temp_2 <= '0';
			  cl_val_2  <= '0';
			  cl_sen_3  <= '0';
			  cl_temp_3 <= '0';
			  cl_val_3  <= '0';
			  cl_sen_4  <= '0';
			  cl_temp_4 <= '0';
			  cl_val_4  <= '0';
			  cl_sum    <= '0';
			  cl_tempo  <= '0';

			  if ligado1 = '1' and sensor_ar_1 = '0' then
					PE <= inicia_vaga_1;
			  elsif ligado1 = '0' and sensor_ar_1 = '1' then
					PE <= final_vaga_1;
					------------
			  elsif ligado2 = '1' and sensor_ar_2 = '0' then
					PE <= inicia_vaga_2;
			  elsif ligado2 = '0' and sensor_ar_2 = '1' then
					PE <= final_vaga_2;
					-----------
			  elsif ligado3 = '1' and sensor_ar_3 = '0' then
					PE <= inicia_vaga_3;
			  elsif ligado3 = '0' and sensor_ar_3 = '1' then
					PE <= final_vaga_3;
					-----------
			  elsif ligado4 = '1' and sensor_ar_4 = '0' then
					PE <= inicia_vaga_4;
			  elsif ligado4 = '0' and sensor_ar_4 = '1' then
					PE <= final_vaga_4;
			  else
					PE <= aguarda;
			  end if;
		when inicia_vaga_1=>
			  ld_sen_1  <= '1';
			  ld_temp_1 <= '0';
			  ld_val_1  <= '0';
			  ld_sen_2  <= '0';
			  ld_temp_2 <= '0';
			  ld_val_2  <= '0';
			  ld_sen_3  <= '0';
			  ld_temp_3 <= '0';
			  ld_val_3  <= '0';
			  ld_sen_4  <= '0';
			  ld_temp_4 <= '0';
			  ld_val_4  <= '0';
			  ld_ar_1   <= '1';
			  ld_ar_2   <= '0';
			  ld_ar_3   <= '0';
			  ld_ar_4   <= '0';
			  cl_ar_1   <= '0';
			  cl_ar_2   <= '0';
			  cl_ar_3   <= '0';
			  cl_ar_4   <= '0';
			  cl_sen_1  <= '0';
			  cl_temp_1 <= '0';
			  cl_val_1  <= '0';
			  cl_sen_2  <= '0';
			  cl_temp_2 <= '0';
			  cl_val_2  <= '0';
			  cl_sen_3  <= '0';
			  cl_temp_3 <= '0';
			  cl_val_3  <= '0';
			  cl_sen_4  <= '0';
			  cl_temp_4 <= '0';
			  cl_val_4  <= '0';
			  ld_sum    <= '0';
			  cl_sum    <= '0';
			  cl_tempo  <= '1';
			  
			  PE <= aguarda;
		when final_vaga_1 =>
			  ld_sen_1  <= '1';
			  ld_temp_1 <= '1';
			  ld_val_1  <= '1';
			  ld_sen_2  <= '0';
			  ld_temp_2 <= '0';
			  ld_val_2  <= '0';
			  ld_sen_3  <= '0';
			  ld_temp_3 <= '0';
			  ld_val_3  <= '0';
			  ld_sen_4  <= '0';
			  ld_temp_4 <= '0';
			  ld_val_4  <= '0';
			  ld_ar_1   <= '1';
			  ld_ar_2   <= '0';
			  ld_ar_3   <= '0';
			  ld_ar_4   <= '0';
			  cl_ar_1   <= '0';
			  cl_ar_2   <= '0';
			  cl_ar_3   <= '0';
			  cl_ar_4   <= '0';
			  cl_sen_1  <= '0';
			  cl_temp_1 <= '0';
			  cl_val_1  <= '0';
			  cl_sen_2  <= '0';
			  cl_temp_2 <= '0';
			  cl_val_2  <= '0';
			  cl_sen_3  <= '0';
			  cl_temp_3 <= '0';
			  cl_val_3  <= '0';
			  cl_sen_4  <= '0';
			  cl_temp_4 <= '0';
			  cl_val_4  <= '0';
			  ld_sum    <= '0';
			  cl_sum    <= '0';
			  cl_tempo  <= '0';
			  
			  --PE <= aguarda;
			  PE <= soma; 
		when inicia_vaga_2=>
			  ld_sen_1  <= '0';
			  ld_temp_1 <= '0';
			  ld_val_1  <= '0';
			  ld_sen_2  <= '1';
			  ld_temp_2 <= '0';
			  ld_val_2  <= '0';
			  ld_sen_3  <= '0';
			  ld_temp_3 <= '0';
			  ld_val_3  <= '0';
			  ld_sen_4  <= '0';
			  ld_temp_4 <= '0';
			  ld_val_4  <= '0';
			  ld_ar_1   <= '0';
			  ld_ar_2   <= '1';
			  ld_ar_3   <= '0';
			  ld_ar_4   <= '0';
			  cl_ar_1   <= '0';
			  cl_ar_2   <= '0';
			  cl_ar_3   <= '0';
			  cl_ar_4   <= '0';
			  cl_sen_1  <= '0';
			  cl_temp_1 <= '0';
			  cl_val_1  <= '0';
			  cl_sen_2  <= '0';
			  cl_temp_2 <= '0';
			  cl_val_2  <= '0';
			  cl_sen_3  <= '0';
			  cl_temp_3 <= '0';
			  cl_val_3  <= '0';
			  cl_sen_4  <= '0';
			  cl_temp_4 <= '0';
			  cl_val_4  <= '0';
			  ld_sum    <= '0';
			  cl_sum    <= '0';
			  cl_tempo  <= '0';
			  
			  PE <= aguarda;
		when final_vaga_2 =>
			  ld_sen_1  <= '0';
			  ld_temp_1 <= '0';
			  ld_val_1  <= '0';
			  ld_sen_2  <= '1';
			  ld_temp_2 <= '1';
			  ld_val_2  <= '1';
			  ld_sen_3  <= '0';
			  ld_temp_3 <= '0';
			  ld_val_3  <= '0';
			  ld_sen_4  <= '0';
			  ld_temp_4 <= '0';
			  ld_val_4  <= '0';
			  ld_ar_1   <= '0';
			  ld_ar_2   <= '1';
			  ld_ar_3   <= '0';
			  ld_ar_4   <= '0';
			  cl_ar_1   <= '0';
			  cl_ar_2   <= '0';
			  cl_ar_3   <= '0';
			  cl_ar_4   <= '0';
			  cl_sen_1  <= '0';
			  cl_temp_1 <= '0';
			  cl_val_1  <= '0';
			  cl_sen_2  <= '0';
			  cl_temp_2 <= '0';
			  cl_val_2  <= '0';
			  cl_sen_3  <= '0';
			  cl_temp_3 <= '0';
			  cl_val_3  <= '0';
			  cl_sen_4  <= '0';
			  cl_temp_4 <= '0';
			  cl_val_4  <= '0';
			  ld_sum    <= '0';
			  cl_sum    <= '0';
			  cl_tempo  <= '0';
			  
			  
			  PE <= soma; 
		when inicia_vaga_3=>
			  ld_sen_1  <= '0';
			  ld_temp_1 <= '0';
			  ld_val_1  <= '0';
			  ld_sen_2  <= '0';
			  ld_temp_2 <= '0';
			  ld_val_2  <= '0';
			  ld_sen_3  <= '1';
			  ld_temp_3 <= '0';
			  ld_val_3  <= '0';
			  ld_sen_4  <= '0';
			  ld_temp_4 <= '0';
			  ld_val_4  <= '0';
			  ld_ar_1   <= '0';
			  ld_ar_2   <= '0';
			  ld_ar_3   <= '1';
			  ld_ar_4   <= '0';
			  cl_ar_1   <= '0';
			  cl_ar_2   <= '0';
			  cl_ar_3   <= '0';
			  cl_ar_4   <= '0';
			  cl_sen_1  <= '0';
			  cl_temp_1 <= '0';
			  cl_val_1  <= '0';
			  cl_sen_2  <= '0';
			  cl_temp_2 <= '0';
			  cl_val_2  <= '0';
			  cl_sen_3  <= '0';
			  cl_temp_3 <= '0';
			  cl_val_3  <= '0';
			  cl_sen_4  <= '0';
			  cl_temp_4 <= '0';
			  cl_val_4  <= '0';
			  ld_sum    <= '0';
			  cl_sum    <= '0';
			  cl_tempo  <= '0';
			  
			  PE <= aguarda;
		when final_vaga_3 =>
			  ld_sen_1  <= '0';
			  ld_temp_1 <= '0';
			  ld_val_1  <= '0';
			  ld_sen_2  <= '0';
			  ld_temp_2 <= '0';
			  ld_val_2  <= '0';
			  ld_sen_3  <= '1';
			  ld_temp_3 <= '1';
			  ld_val_3  <= '1';
			  ld_sen_4  <= '0';
			  ld_temp_4 <= '0';
			  ld_val_4  <= '0';
			  ld_ar_1   <= '0';
			  ld_ar_2   <= '0';
			  ld_ar_3   <= '1';
			  ld_ar_4   <= '0';
			  cl_ar_1   <= '0';
			  cl_ar_2   <= '0';
			  cl_ar_3   <= '0';
			  cl_ar_4   <= '0';
			  cl_sen_1  <= '0';
			  cl_temp_1 <= '0';
			  cl_val_1  <= '0';
			  cl_sen_2  <= '0';
			  cl_temp_2 <= '0';
			  cl_val_2  <= '0';
			  cl_sen_3  <= '0';
			  cl_temp_3 <= '0';
			  cl_val_3  <= '0';
			  cl_sen_4  <= '0';
			  cl_temp_4 <= '0';
			  cl_val_4  <= '0';
			  ld_sum    <= '0';
			  cl_sum    <= '0';
			  cl_tempo  <= '0';
			  
			  PE <= soma; 
		when inicia_vaga_4=>
			  ld_sen_1  <= '0';
			  ld_temp_1 <= '0';
			  ld_val_1  <= '0';
			  ld_sen_2  <= '0';
			  ld_temp_2 <= '0';
			  ld_val_2  <= '0';
			  ld_sen_3  <= '0';
			  ld_temp_3 <= '0';
			  ld_val_3  <= '0';
			  ld_sen_4  <= '1';
			  ld_temp_4 <= '0';
			  ld_val_4  <= '0';
			  ld_ar_1   <= '0';
			  ld_ar_2   <= '0';
			  ld_ar_3   <= '0';
			  ld_ar_4   <= '1';
			  cl_ar_1   <= '0';
			  cl_ar_2   <= '0';
			  cl_ar_3   <= '0';
			  cl_ar_4   <= '0';
			  cl_sen_1  <= '0';
			  cl_temp_1 <= '0';
			  cl_val_1  <= '0';
			  cl_sen_2  <= '0';
			  cl_temp_2 <= '0';
			  cl_val_2  <= '0';
			  cl_sen_3  <= '0';
			  cl_temp_3 <= '0';
			  cl_val_3  <= '0';
			  cl_sen_4  <= '0';
			  cl_temp_4 <= '0';
			  cl_val_4  <= '0';
			  ld_sum    <= '0';
			  cl_sum    <= '0';
			  cl_tempo  <= '0';
			  
			  PE <= aguarda;
		when final_vaga_4 =>
			  ld_sen_1  <= '0';
			  ld_temp_1 <= '0';
			  ld_val_1  <= '0';
			  ld_sen_2  <= '0';
			  ld_temp_2 <= '0';
			  ld_val_2  <= '0';
			  ld_sen_3  <= '0';
			  ld_temp_3 <= '0';
			  ld_val_3  <= '0';
			  ld_sen_4  <= '1';
			  ld_temp_4 <= '1';
			  ld_val_4  <= '1';
			  ld_ar_1   <= '0';
			  ld_ar_2   <= '0';
			  ld_ar_3   <= '0';
			  ld_ar_4   <= '1';
			  cl_ar_1   <= '0';
			  cl_ar_2   <= '0';
			  cl_ar_3   <= '0';
			  cl_ar_4   <= '0';
			  cl_sen_1  <= '0';
			  cl_temp_1 <= '0';
			  cl_val_1  <= '0';
			  cl_sen_2  <= '0';
			  cl_temp_2 <= '0';
			  cl_val_2  <= '0';
			  cl_sen_3  <= '0';
			  cl_temp_3 <= '0';
			  cl_val_3  <= '0';
			  cl_sen_4  <= '0';
			  cl_temp_4 <= '0';
			  cl_val_4  <= '0';
			  ld_sum    <= '0';
			  cl_sum    <= '0';
			  cl_tempo  <= '0';
			  
			  PE <= soma;
		when soma =>
			ld_sen_1  <= '0';
			  ld_temp_1 <= '0';
			  ld_val_1  <= '0';
			  ld_sen_2  <= '0';
			  ld_temp_2 <= '0';
			  ld_val_2  <= '0';
			  ld_sen_3  <= '0';
			  ld_temp_3 <= '0';
			  ld_val_3  <= '0';
			  ld_sen_4  <= '0';
			  ld_temp_4 <= '0';
			  ld_val_4  <= '0';
			  ld_ar_1   <= '0';
			  ld_ar_2   <= '0';
			  ld_ar_3   <= '0';
			  ld_ar_4   <= '0';
			  cl_ar_1   <= '0';
			  cl_ar_2   <= '0';
			  cl_ar_3   <= '0';
			  cl_ar_4   <= '0';
			  cl_sen_1  <= '0';
			  cl_temp_1 <= '0';
			  cl_val_1  <= '0';
			  cl_sen_2  <= '0';
			  cl_temp_2 <= '0';
			  cl_val_2  <= '0';
			  cl_sen_3  <= '0';
			  cl_temp_3 <= '0';
			  cl_val_3  <= '0';
			  cl_sen_4  <= '0';
			  cl_temp_4 <= '0';
			  cl_val_4  <= '0';
			  ld_sum    <= '1';
			  cl_sum    <= '0';
			  cl_tempo  <= '0';
			  
			  PE <= aguarda;
				
      when others =>
        PE <= inicial;
    end case;
  end process combinatorio;

end architecture arch;
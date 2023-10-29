library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use ieee.numeric_std.all;
 
ENTITY tb_Registradora IS
END tb_Registradora;
 
ARCHITECTURE behavior OF tb_Registradora IS 
 
-- Component Declaration for the Unit Under Test (UUT)
 
component Registradora 
    Port (
				clock       : in  STD_LOGIC;  
				rst         : in  STD_LOGIC;    
				valor       : in  STD_LOGIC_VECTOR (3 downto 0);  
				soma        : in  STD_LOGIC;  
				subtracao   : in  STD_LOGIC; 
				finalizar   : in  STD_LOGIC;
				resultado   : out STD_LOGIC_VECTOR (3 downto 0)
    );
end component;
    
signal   clock                 : STD_LOGIC;
signal   rst                   : STD_LOGIC;
signal   data_in_valor         : STD_LOGIC_VECTOR (3 downto 0);
signal   data_in_soma          : STD_LOGIC;
signal   data_in_subtracao     : STD_LOGIC;
signal   data_in_finalizar     : STD_LOGIC;
signal   data_output           : STD_LOGIC_VECTOR (3 downto 0);
constant max_value             : NATURAL := 100;
constant mim_value		       : NATURAL := 1;


signal read_data_in    : STD_LOGIC:='0';
signal flag_write      : STD_LOGIC:='0';   

   
file   inputs_data_in  : text open read_mode  is "data_in.txt";
file   outputs         : text open write_mode is "outputs.txt";


-- Clock period definitions
constant PERIOD     : time := 10 ns;
constant DUTY_CYCLE : real := 0.5;
constant OFFSET     : time := 5 ns;


BEGIN
-- Instantiate the Unit Under Test (UUT) or Design Under Test (DUT)
DUT: Registradora 
    port map(clock        =>  clock,  
             rst          =>  rst, 
             valor        =>  data_in_valor,  
             soma         =>  data_in_soma,
				 subtracao    =>  data_in_subtracao, 
				 finalizar    =>  data_in_finalizar,
             resultado    =>  data_output);
		  
------------------------------------------------------------------------------------
----------------- processo para gerar o sinal de clock 
------------------------------------------------------------------------------------		
        PROCESS    -- clock process for clock
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                clock <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                clock <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;
		  
------------------------------------------------------------------------------------
----------------- processo para gerar o estimulo de reset
------------------------------------------------------------------------------------		
	sreset: process
	begin
		rst <= '0';
		wait until rising_edge(clock);
		rst <= '1';
		for i in 1 to 2 loop
			wait until rising_edge(clock);
		end loop;
		rst <= '0'; 
	
		wait;	
	end process sreset;
	
------------------------------------------------------------------------------------
----------------- processo para leer os dados do arquivo data_in.txt
------------------------------------------------------------------------------------
read_inputs_data_in:process
	
	variable linea   : line;
	variable column1 : STD_LOGIC_VECTOR (3 downto 0);
	variable column2 : STD_LOGIC;
	variable column3 : STD_LOGIC;
	variable column4 : STD_LOGIC;
	
	begin
	
	    wait until falling_edge(clock);
		 
		 while not endfile(inputs_data_in) loop
			
			if read_data_in = '1' then
					
				  wait until falling_edge(clock);
				  wait until falling_edge(clock);
				  wait until falling_edge(clock);
				
			     readline(inputs_data_in,linea);
				  
				  read(linea,column1);
				  data_in_valor <= column1;
				  
				  read(linea,column2);
				  data_in_soma <= column2;
				  
				  read(linea,column3);
				  data_in_subtracao <= column3;
				  
				  read(linea,column4);
				  data_in_finalizar <= column4;
				  
			  end if;
			  
			  wait for PERIOD;
		end loop;
		wait;
	end process read_inputs_data_in;	
	
------------------------------------------------------------------------------------
----------------- processo para gerar os estimulos de entrada
------------------------------------------------------------------------------------
	
   tb_stimulus : PROCESS
   BEGIN
        WAIT FOR (OFFSET + 3*PERIOD);
            read_data_in <= '1';		
			for i in mim_value to max_value loop
		        wait for PERIOD;
		    end loop;
            read_data_in <= '0';		
		WAIT;
   END PROCESS tb_stimulus;	
   
------------------------------------------------------------------------------------
------ processo para gerar os estimulos de escrita do arquivo de saida
------------------------------------------------------------------------------------   
   
    escreve_outputs : PROCESS
    BEGIN
         WAIT FOR (OFFSET + 4*PERIOD);
             flag_write <= '1';
			 for i in mim_value to max_value loop
		         wait for PERIOD;
		     end loop;
             flag_write <= '0';			
		 WAIT;
    END PROCESS escreve_outputs;   
   
-- ------------------------------------------------------------------------------------
-- ------ processo para escriber os dados de saida no arquivo .txt
-- ------------------------------------------------------------------------------------   
   
	 write_outputs:process
		 variable linea  : line;
		 variable output : STD_LOGIC_VECTOR (3 downto 0);
	 begin
	    wait until rising_edge(clock);
		 while true loop
			 if (flag_write ='1')then
				
				 wait until rising_edge(clock);
				 wait until rising_edge(clock);
				 wait until rising_edge(clock);
				 
				 output := data_output;
				 write(linea,output);
				 writeline(outputs,linea);
			 end if;
			 wait for PERIOD;
		 end loop; 
	 end process write_outputs;   
END;

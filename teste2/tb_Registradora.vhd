library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use ieee.numeric_std.all;
 
entity tb_maquina is
end tb_maquina;
 
ARCHITECTURE behavior OF tb_maquina IS 
 
-- Component Declaration for the Unit Under Test (UUT)
 
component maquina is
	port (  INPUT  : in std_logic_vector(3 downto 0);
			  clock  : in std_logic;
			  reset  : in std_logic;
			  i      : in std_logic; --verifica se é para somar ou subtrair 1 soma 0 subtrai
			  x      : in std_logic; -- no estado B é usado para trocar de estado, no caso para o C.
			  f      : in std_logic;	--verifica nenhuma entrada sera mais setada
			  estado : out std_logic_vector(3 downto 0);
			  OUTPUT : out std_logic_vector(3 downto 0);
			  val_ld : out std_logic;
			  sum_ld : out std_logic; 
			  out_ld : out std_logic
        );
end component;
    
signal clock                 : std_logic;
signal reset                 : std_logic;
signal data_in_input         : std_logic_vector(3 downto 0);
signal data_in_i             : STD_LOGIC;
signal data_in_x             : STD_LOGIC;
signal data_in_f             : STD_LOGIC;
signal data_output           : std_logic_vector(3 downto 0);
constant max_value           : natural := 50;
constant mim_value		     : natural := 1;


signal read_data_in    : std_logic:='0';
signal flag_write      : std_logic:='0';   

   
file   inputs_data_in  : text open read_mode  is "data_in.txt";
file   outputs         : text open write_mode is "outputs.txt";


-- Clock period definitions
constant PERIOD     : time := 20 ns;
constant DUTY_CYCLE : real := 0.5;
constant OFFSET     : time := 5 ns;


BEGIN
-- Instantiate the Unit Under Test (UUT) or Design Under Test (DUT)
DUT: maquina
    port map(clock     =>  clock,  
             reset     =>  reset, 
             INPUT     =>  data_in_input,  
             i         =>  data_in_i,
				 x         =>  data_in_x, 
				 f         =>  data_in_f,
             OUTPUT    =>  data_output);
		  
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
		reset <= '1';
		for i in 1 to 2 loop
			wait until rising_edge(clock);
		end loop;
		reset <= '0'; 
		wait;	
	end process sreset;
	
	
------------------------------------------------------------------------------------
----------------- processo para leer os dados do arquivo data_in.txt
------------------------------------------------------------------------------------
read_inputs_data_in:process
	
	variable linea : line;
	variable column1 : STD_LOGIC_VECTOR (3 downto 0);
	variable column2 : STD_LOGIC;
	variable column3 : STD_LOGIC;
	variable column4 : STD_LOGIC;
	
	begin
	    wait until falling_edge(clock);
		 while not endfile(inputs_data_in) loop
		
		      if read_data_in = '1' then
				
			     readline(inputs_data_in,linea);
				  
				  read(linea,column1);
				  data_in_input <= column1;
				  
				  read(linea,column2);
				  data_in_i <= column2;
				  
				  read(linea,column3);
				  data_in_x <= column3;
				  
				  read(linea,column4);
				  data_in_f <= column4;
				  
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
	     wait until clock ='0';
		 while true loop
			 if (flag_write ='1')then
				 output := data_output;
				 write(linea,output);
				 writeline(outputs,linea);
			 end if;
			 wait for PERIOD;
		 end loop; 
	 end process write_outputs;   
END;

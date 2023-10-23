library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use ieee.numeric_std.all;
 
ENTITY tb_funcao IS
END tb_funcao;
 
ARCHITECTURE arch OF tb_funcao IS 
 
-- Component Declaration for the Unit Under Test (UUT)
 
component funcao 
	port( x : in std_logic_vector(3 downto 0);
         f : out std_logic_vector(7 downto 0)
		);
end component;
    
	signal clk              : std_logic;
	signal rst              : std_logic;
	signal data_in          : std_logic_vector(3 downto 0);
	signal data_output      : std_logic_vector(7 downto 0);
	constant max_value      : natural := 4;
	constant mim_value		: natural := 1;


   signal read_data_in    : std_logic:='0';
   signal flag_write      : std_logic:='0';   

   
   file   inputs_data_in  : text open read_mode  is "data_in.txt";
   file   outputs         : text open write_mode is "outputs.txt";


   -- Clock period definitions
   constant PERIOD     : time := 20 ns;
   constant DUTY_CYCLE : real := 0.5;
   constant OFFSET     : time := 5 ns;
   type v is array(3 downto 0) of std_logic_vector(7 downto 0);
   signal esperado : v := ("00000000","00011100","00110100","01001000");
BEGIN
	-- Instantiate the Unit Under Test (UUT) or Design Under Test (DUT)
DUT: funcao 
    port map(x          => data_in,
             f          => data_output);
		  
------------------------------------------------------------------------------------
----------------- processo para gerar o sinal de clock 
------------------------------------------------------------------------------------		
        PROCESS    -- clock process for clock
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                clk <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                clk <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

------------------------------------------------------------------------------------
----------------- processo para gerar o estimulo de reset
------------------------------------------------------------------------------------		
--	sreset: process
--	begin
--		rst <= '1';
--		for i in 1 to 4 loop
--			wait until rising_edge(clk);
--		end loop;
--		rst <= '0'; 
--		wait;	
--	end process sreset;
--	
	
------------------------------------------------------------------------------------
----------------- processo para leer os dados do arquivo data_in.txt
------------------------------------------------------------------------------------
read_inputs_data_in: process
		variable linea : line;
		variable input : std_logic_vector(3 downto 0);
	begin
	    wait until falling_edge(clk);
		 while not endfile(inputs_data_in) loop
		      if read_data_in = '1' then
			    readline(inputs_data_in,linea);
				 read(linea,input);
				 data_in <= input;
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
		 variable output : std_logic_vector (7 downto 0);
		 variable i : integer := 3;
	 begin
	    wait until clk ='0';
		 while true loop
			 if (flag_write ='1')then
			 
			 assert(output = esperado(i))
					report "errado"
					severity warning;
				 output := data_output;
		
				 write(linea,output);
				 writeline(outputs,linea);
			 end if;
			 if ( i > 0) then
				i := i - 1;
			end if;
			 wait for PERIOD;
		 end loop; 
	 end process write_outputs;  
	
END arch;




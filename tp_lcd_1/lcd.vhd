library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lcd is
    port
    (
        CLK                     : in  std_logic;    -- clock
		  tempo                   : in std_logic_vector(3 downto 0);
		  valor                   : in std_logic_vector(3 downto 0);
		  soma                    : in std_logic_vector(3 downto 0);
		  s0                      : in std_logic;
		  s1                      : in std_logic;
        LCD_RW                  : out std_logic;    -- Leitura ou escrita dos dados: 0 = Write, 1 = Read
        LCD_EN                  : out std_logic;    -- Enable: Ativar leitura/escrita dos dados 
        LCD_RS                  : out std_logic;    -- Tipo de dado: 0 - configuração, 1 = dados
        LCD_DATA                : out std_logic_vector(7 downto 0); -- Dados 
        LCD_ON                  : out std_logic;    -- Ligar display
        LCD_BLON                : out std_logic    -- Ligar display
		  
        --LCD_DATA_LED            : out std_logic_vector(7 downto 0) -- Dados passados para o LCD em binário
    );
end entity;

architecture rtl of lcd is
    type State_Type is (INIT, DATA, ENABLE_ON, DELAY, ENABLE_OFF, NEXT_INDEX, DELAY2); -- Declaração dos estados da FSM
    signal state, next_state : State_Type;
    signal current_char : std_logic_vector(8 downto 0); 											-- Caracter atual a ser escrito
    --signal done: std_logic := '0'; 																		-- Indicação de término da frase

    signal index : integer := 0; 																		-- Indice do caracter da frase
begin
		-- Inicia o Display
    LCD_BLON <= '1';
    LCD_ON <= '1';

    process (CLK) 																-- Atribuição de estados
    begin
        if (rising_edge(CLK)) then
            state <= next_state;
        end if;
    end process;
			

    process (CLK)
        variable count : integer := 0; 									-- Temporizador
		  variable freq : integer := 50000000; 							-- frequencia do clock da DE2 - 50MHz
		  variable aux : std_logic_vector (11 downto 0); 				-- Variavel auxiliar para escrita de dados

    begin
        if (rising_edge(CLK)) then
            case (state) is
                when INIT => 													-- Estado inicial
--                    if (done = '0') then 									-- Caso a frase ainda não terminou
--                        next_state <= DATA; 								-- Proximo estado
--                    else														-- Caso a frase terminou
--                        next_state <= INIT;     						-- Mantém o estado
--                    end if;
                      next_state <= DATA; 								-- Proximo estado

						  
                when DATA =>													-- Estado de dados
                    LCD_DATA <= current_char(7 downto 0);			-- Envio dos dados para o display
						  --LCD_DATA_LED <= current_char(7 downto 0);		-- Envio dos dados para os leds
                    LCD_RS <= current_char(8);							-- Modo: comando = 0, dados = 1
                    next_state <= ENABLE_ON;								-- Proximo estado
						  
                when ENABLE_ON =>											-- Estado de escrita
                    LCD_EN <= '1';											-- Permite a escrita no LCD
                    next_state <= DELAY;							-- proximo estados
						  
                when DELAY =>													-- Espera a escrita de dados no LCD
                    if (count <= 5000000) then 			-- 50MHz * 0.5s freq * integer(0.49)
                        count := count + 1;								-- Contador
								next_state <= DELAY;								-- Mantém estado
                    else														-- Termina a contagem
                        count := 0;											-- Reinicia o contador
                        next_state <= ENABLE_OFF;						-- Proximo estado
                    end if;
						  
                when ENABLE_OFF =>											-- Término da escrita
                    LCD_EN <= '0';											-- Desabilita a escrita
                    next_state <= NEXT_INDEX;							-- Próximo estado
						  
                when NEXT_INDEX =>											-- Atualiza o indice 
                    if index <= (5 + 32) then							-- 5 bits de confiduração + 32 bits do display (2 linhas de 16 bits)
                        index <= index + 1;
                    else
                        index <= 0;
                    end if ;
                    next_state <= DELAY2;									-- Próximo estado
						  
					  when DELAY2 =>												-- Borda do clock onde os dados atualizam
					  next_state <= INIT;										-- Retorna para o estado inicial
					  
                when others =>
                    next_state <= INIT;									-- Caso de erro, retorna para o estado inicial
						  
            end case;
        end if;
    end process;

    process (CLK, s0, s1, valor, tempo, soma)																	-- Process para atualização de caracter
	 variable aux : std_logic_vector (11 downto 0);
    begin
        if (rising_edge(CLK)) then
            case (index) is
                when 0 => 
					 -- O bit mais a esquerda = 0 corresponde a configuração
                    aux := x"038";											-- Configura cada caracter como 8 bits, dislay de 2 linhas e tamanho de caracter como 5*7 pixels
						  current_char <= aux(8 downto 0);
                    --done <= '0';
                when 1 => 
							aux := x"00C";											-- Configura o cursor como invisivel
							current_char <= aux(8 downto 0);
                when 2 => 
							aux := x"001";											-- Limpa o display
							current_char <= aux(8 downto 0);
                when 3 =>
							aux := x"006"; 										-- Configura o cursor na posição 0 da linha 0 com deslocamento para a direita
							current_char <= aux(8 downto 0);
                when 4 => 
					 		aux := x"080";											-- Apaga o display sem limpar
							current_char <= aux(8 downto 0);

					-- -- O bit mais a esquerda = 1 corresponde a dados
                when 5 => -- Vaga
					 		aux := x"156";											-- hex 56 = V
							current_char <= aux(8 downto 0);
                when 6 => 
					 		aux := x"141";											-- hex 41 = A
							current_char <= aux(8 downto 0);
                when 7 => 
					 		aux := x"147";											-- hex 71 = G
							current_char <= aux(8 downto 0);
                when 8 => 
					 		aux := x"141";											-- hex 41 = A
							current_char <= aux(8 downto 0);
					 when 9 => -- ESPAÇO
					      aux := x"120";											-- hex 20 = " " 
                     current_char <= aux(8 downto 0);
                when 10 => 
							if (s0 = '0') and (s1 = '0') then
								aux := x"131";								      -- hex 31 = 1
							elsif (s0 = '0') and (s1 = '1') then
								aux := x"132";
							elsif (s0 = '1') and (s1 = '0') then
								aux := x"133";
							else
								aux := x"134";
							end if;
                     current_char <= aux(8 downto 0);
					 when 11 => -- Dois pontos
					      aux := x"13A";											
                     current_char <= aux(8 downto 0);
					 -----------------------------------------------------------------------------------
					 when 12 => -- VALOR
					 		aux := x"156";											-- hex 56 = V
							current_char <= aux(8 downto 0);
                when 13 => 
					 		aux := x"141";											-- hex 41 = A
							current_char <= aux(8 downto 0);
                when 14 => 
					 		aux := x"14C";											-- hex 71 = G
							current_char <= aux(8 downto 0);
                when 15 => 
					 		aux := x"14F";											-- hex 41 = A
							current_char <= aux(8 downto 0);
					 when 16 => 
					 		aux := x"152";											-- hex 41 = A
							current_char <= aux(8 downto 0);
					 when 17 => -- ESPAÇO
					      aux := x"120";											-- hex 20 = " " 
                     current_char <= aux(8 downto 0);
					------------------------------------------------------------------------------------
					 when 18 =>
							if valor = "0000" then
					 		aux := x"130";
							elsif valor = "0001" then
							aux := x"131";
							elsif valor = "0010" then
							aux := x"132";
							elsif valor = "0011" then
							aux := x"133";
							elsif valor = "0100" then
							aux := x"134";
							elsif valor = "0101" then
							aux := x"135";
							elsif valor = "0110" then
							aux := x"136";
							elsif valor = "0111" then
							aux := x"137";
							elsif valor = "1000" then
							aux := x"138";
							elsif valor = "1001" then
							aux := x"139";
							else 
							aux := x"13F";
							end if;
							current_char <= aux(8 downto 0);
					 when 19 => -- ESPAÇO
					      aux := x"120";											-- hex 20 = " " 
                     current_char <= aux(8 downto 0);
					 when 20 => 
					      aux := x"0C0";											
                     current_char <= aux(8 downto 0);
					 -----------------------------------------------------------------------------------
					 when 21 => -- TEMPO
					 		aux := x"154";											-- hex 56 = V
							current_char <= aux(8 downto 0);
                when 22 => 
					 		aux := x"145";											-- hex 41 = A
							current_char <= aux(8 downto 0);
                when 23 => 
					 		aux := x"14D";											-- hex 71 = G
							current_char <= aux(8 downto 0);
                when 24 => 
					 		aux := x"150";											-- hex 41 = A
							current_char <= aux(8 downto 0);
					 when 25 => 
					 		aux := x"14F";											-- hex 41 = A
							current_char <= aux(8 downto 0);
					 when 26 => -- ESPAÇO
					      aux := x"120";											-- hex 20 = " " 
                     current_char <= aux(8 downto 0);
					------------------------------------------------------------------------------------
                when 27 => 
					 		if tempo = "0000" then
					 		aux := x"130";
							elsif tempo = "0001" then
							aux := x"131";
							elsif tempo = "0010" then
							aux := x"132";
							elsif tempo = "0011" then
							aux := x"133";
							elsif tempo = "0100" then
							aux := x"134";
							elsif tempo = "0101" then
							aux := x"135";
							elsif tempo = "0110" then
							aux := x"136";
							elsif tempo = "0111" then
							aux := x"137";
							elsif tempo = "1000" then
							aux := x"138";
							elsif tempo = "1001" then
							aux := x"139";
							else 
							aux := x"13F";
							end if;
							current_char <= aux(8 downto 0);
					------------------------------------------------------------------------------------
					 when 28 => -- ESPAÇO
					      aux := x"120";											-- hex 20 = " " 
                     current_char <= aux(8 downto 0);
					 when 29 => -- Ganhos
					 		aux := x"147";											-- hex 56 = V
							current_char <= aux(8 downto 0);
                when 30 => 
					 		aux := x"141";											-- hex 41 = A
							current_char <= aux(8 downto 0);
                when 31 => 
					 		aux := x"14E";											-- hex 71 = G
							current_char <= aux(8 downto 0);
                when 32 => 
					 		aux := x"148";											-- hex 41 = A
							current_char <= aux(8 downto 0);
					 when 33 => 
					 		aux := x"14F";											-- hex 41 = A
							current_char <= aux(8 downto 0);
					 when 34 => 
					 		aux := x"153";											-- hex 41 = A
							current_char <= aux(8 downto 0);
					-------------------------------------------------------------------
					 when 35 => -- ESPAÇO
					      aux := x"120";											-- hex 20 = " " 
                     current_char <= aux(8 downto 0);
                when 36 => 
					      if soma = "0000" then
					 		aux := x"130";
							elsif soma = "0001" then
							aux := x"131";
							elsif soma = "0010" then
							aux := x"132";
							elsif soma = "0011" then
							aux := x"133";
							elsif soma = "0100" then
							aux := x"134";
							elsif soma = "0101" then
							aux := x"135";
							elsif soma = "0110" then
							aux := x"136";
							elsif soma = "0111" then
							aux := x"137";
							elsif soma = "1000" then
							aux := x"138";
							elsif soma = "1001" then
							aux := x"139";
							else 
							aux := x"13F";
							end if;
							current_char <= aux(8 downto 0); 
							
					 when 37 => -- Finalização
					      aux := x"120";
							current_char <= aux(8 downto 0); 
                when others =>
							aux := x"120";											-- hex 20 = " "
                     current_char <= aux(8 downto 0);
            end case;
        end if;
    end process;
end rtl;
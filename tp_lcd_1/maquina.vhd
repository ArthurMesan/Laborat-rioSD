LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maquina is
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
	  --luzes
	  luz_verde_1 : out std_logic;
	  luz_verde_2 : out std_logic;
	  luz_verde_3 : out std_logic;
	  luz_verde_4 : out std_logic;
	  luz_vermelha_1 : out std_logic;
	  luz_vermelha_2 : out std_logic;
	  luz_vermelha_3 : out std_logic;
	  luz_vermelha_4 : out std_logic;
	  --saida lcd
	  LCD_RW                  : out std_logic;    
     LCD_EN                  : out std_logic;    
     LCD_RS                  : out std_logic;    
     LCD_DATA                : out std_logic_vector(7 downto 0); 
     LCD_ON                  : out std_logic;    
     LCD_BLON                : out std_logic
	  
  );
end maquina;

architecture arch of maquina is

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
	  luz_verde_1 : out std_logic;
	  luz_verde_2 : out std_logic;
	  luz_verde_3 : out std_logic;
	  luz_verde_4 : out std_logic;
	  luz_vermelha_1 : out std_logic;
	  luz_vermelha_2 : out std_logic;
	  luz_vermelha_3 : out std_logic;
	  luz_vermelha_4 : out std_logic
	  
  );
end component;

component lcd is
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
end component;

signal fio_tempo, fio_valor, fio_valor_total : std_logic_vector(3 downto 0);

begin

instancia_estacionamento : Estacionamento port map(start => start, reset => reset, ligado1 => ligado1, ligado2 => ligado2, ligado3 => ligado3, ligado4 => ligado4,
clock => clock, tempo_total => fio_tempo, valor_pagar => fio_valor, total_ganhos => fio_valor_total, luz_verde_1 => luz_verde_1,
luz_verde_2 => luz_verde_2, luz_verde_3 => luz_verde_3, luz_verde_4 => luz_verde_4, luz_vermelha_1 => luz_vermelha_1, luz_vermelha_2 => luz_vermelha_2,
luz_vermelha_3 => luz_vermelha_3, luz_vermelha_4 => luz_vermelha_4, s0 => s0, s1 => s1);


instancia_lcd : lcd port map(CLK => clock, tempo => fio_tempo, valor => fio_valor, soma => fio_valor_total, s0 => s0, s1 => s1,
LCD_RW => LCD_RW, LCD_EN => LCD_EN, LCD_RS => LCD_RS, LCD_DATA => LCD_DATA,
LCD_ON => LCD_ON, LCD_BLON => LCD_BLON);
  
end architecture arch;
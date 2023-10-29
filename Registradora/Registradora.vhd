library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Registradora is
    Port (
        clock          : in  STD_LOGIC;  
        rst            : in  STD_LOGIC;    
        valor          : in  STD_LOGIC_VECTOR (3 downto 0);  
        soma           : in  STD_LOGIC;  
        subtracao      : in  STD_LOGIC; 
		  finalizar      : in  STD_LOGIC; 
        resultado      : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Registradora;

architecture Behavioral of Registradora is
    type Estado is (INICIAL, ESPERANDO_VALOR, SOMANDO, SUBTRAINDO, MOSTRANDO_RESULTADO);
    signal estado_atual, proximo_estado: Estado := INICIAL;
    signal valor_acumulado: STD_LOGIC_VECTOR (3 downto 0) := "0000";

begin
    
	 process(estado_atual, valor, soma, subtracao)
    begin
        case estado_atual is
				when INICIAL =>
					valor_acumulado <= "0000";
					resultado <="0000";
					proximo_estado <= ESPERANDO_VALOR;
					
				when ESPERANDO_VALOR =>
               if soma = '1' then
                    proximo_estado <= SOMANDO;
               elsif subtracao = '1' then
                    proximo_estado <= SUBTRAINDO;
				   elsif finalizar = '1' then 
						  proximo_estado <= INICIAL;
					else
                    proximo_estado <= ESPERANDO_VALOR;
               end if;

				when SOMANDO =>
               valor_acumulado <= std_logic_vector(unsigned(valor) + unsigned(valor_acumulado));
					proximo_estado <= MOSTRANDO_RESULTADO;

				when SUBTRAINDO =>
               valor_acumulado <= std_logic_vector(unsigned(valor_acumulado) - unsigned(valor));
					proximo_estado <= MOSTRANDO_RESULTADO;

				when MOSTRANDO_RESULTADO =>
					resultado <= valor_acumulado;
					proximo_estado <= ESPERANDO_VALOR;

				when OTHERS =>
					proximo_estado <= ESPERANDO_VALOR;
		 end case;
    end process;

    process(clock, rst)
		  begin
				if rst = '1' then
					estado_atual <= INICIAL;
				elsif rising_edge(clock) then
					estado_atual <= proximo_estado;
				end if;
    end process;

end Behavioral;

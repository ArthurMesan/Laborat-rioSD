library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity digito is

	port(
			numero : in integer;
			saida: out std_logic_vector(6 downto 0)
		);
		
end digito;


architecture logic of digito is

	signal output : std_logic_vector(6 downto 0);
	
	begin

	process (numero)
		begin
		case numero is
			when 0 => --display 0
				output<= "0000001";
				
			when 1 => --display 1
				output<= "1001111";
			
			when 2 => --display 2
				output<= "0010010";
			
			when 3 => --display 3
				output<= "0000110";
			
			when 4 => --display 4
				output<= "1001100";
			
			when 5 => --display 5
				output<= "0100100";
			
			when 6 => --display 6
				output<= "1100000";
			
			when 7 => --display 7
				output<= "0001111";
			
			when 8 => --display 8
				output<= "0000000";
			
			when 9 => --display 9
				output<= "0001100";

			when others =>
				output<= "1111111";
		end case;
		
	end process;
	
-- Separate the output vector to make individual pin outputs.
	saida <= output;

end architecture;

--------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display is


	port(
			--digito: in std_logic_vector(5 downto 0); --quais digitos serão usados
			numero : in integer; -- numero
			a, b, c, d, e, f, g : out std_logic_vector(5 downto 0) --vector de bits para cada segmento dos 6 digitos
		);
		
end display;


architecture arch of display is

	component digito is
	
		port(
			numero : in integer;
			saida: out std_logic_vector(6 downto 0)
		);
		
	end component;
	
	signal in1, in2, in3, in4, in5, in6 : integer;
	signal s1, s2, s3, s4, s5, s6 : std_logic_vector (6 downto 0);
	signal outA, outB, outC, outD, outE, outF, outG : std_logic_vector (5 downto 0);
	
	
	begin 
		
		digito1 : digito port map (in1, s1); 
		digito2 : digito port map (in2, s2); 
		digito3 : digito port map (in3, s3); 
		digito4 : digito port map (in4, s4); 
		digito5 : digito port map (in5, s5); 
		digito6 : digito port map (in6, s6); 
		
	process (numero) 
		
		begin
		
			in1<= numero mod 10;
			in2<= (numero - in1) mod 100;
			in3<= (numero - in2) mod 1000;
			in4<= (numero - in3) mod 10000;
			in5<= (numero - in4) mod 100000;
			in6<= (numero - in5) mod 1000000;
			
			outA <= s1(0) & s2(0) & s3(0) & s4(0) & s5(0) & s6(0);
			outB <= s1(1) & s2(1) & s3(1) & s4(1) & s5(1) & s6(1);
			outC <= s1(2) & s2(2) & s3(2) & s4(2) & s5(2) & s6(2);
			outD <= s1(3) & s2(3) & s3(3) & s4(3) & s5(3) & s6(3);
			outE <= s1(4) & s2(4) & s3(4) & s4(4) & s5(4) & s6(4);
			outF <= s1(5) & s2(5) & s3(5) & s4(5) & s5(5) & s6(5);
			outG <= s1(6) & s2(6) & s3(6) & s4(6) & s5(6) & s6(6);
		
	end process;
	
	a <= outA;
	b <= outB;
	c <= outC;
	d <= outD;
	e <= outE;
	f <= outF;
	g <= outG;
	
end architecture;

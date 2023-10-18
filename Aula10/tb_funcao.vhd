LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE std.textio.all;

ENTITY tb_funcao IS
END tb_funcao;

ARCHITECTURE arch OF tb_funcao IS
  COMPONENT funcao IS
    PORT (
      x : IN std_logic_vector(3 DOWNTO 0);
      r : IN std_logic_vector(3 DOWNTO 0);
      f : OUT std_logic_vector(11 DOWNTO 0)
    );
  END COMPONENT;

  SIGNAL x, r : std_logic_vector(3 DOWNTO 0);
  SIGNAL f : std_logic_vector(11 DOWNTO 0);

  FILE input_file : TEXT OPEN READ_MODE IS "input.txt";
  FILE output_file : TEXT OPEN WRITE_MODE IS "output.txt";
  VARIABLE input_line : LINE;
  VARIABLE x_integer : INTEGER;
BEGIN
  READLINE(input_file, input_line);
  READ(input_line, x_integer);
  x <= std_logic_vector(to_unsigned(x_integer, x'length));

  r <= "0010"; 
  
  instancia_funcao : funcao PORT MAP (x => x, r => r, f => f);

  WRITE(output_file, "Resultado: " & INTEGER'IMAGE(to_integer(unsigned(f))));


END arch;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.textio.all;

entity tb_fulladder is
end tb_fulladder;

architecture RTL OF tb_fulladder is

  component fulladder is
    port (
      Cin : in std_logic;
      x   : in std_logic;
      y   : in std_logic;
      s   : out std_logic;
      Cout: out std_logic
    );
  end component;

  signal Cin, Cout: std_logic;
  signal x, y, s: std_logic;

  -- Declaração do arquivo de entrada
  file input_file: text;

begin

  process
    variable line: line;
    variable x_val, y_val, Cin_val: bit;
  begin
    -- Abre o arquivo de entrada
    file_open(input_file, "input_file.txt", read_mode);

    -- Loop para ler as entradas do arquivo
    while not endfile(input_file) loop
      -- Lê uma linha do arquivo
      readline(input_file, line);
      
      -- Lê os valores de Cin, x e y do arquivo
      read(line, Cin_val);
      read(line, x_val);
      read(line, y_val);

      -- Converte os valores lidos para std_logic
      Cin <= std_logic(Cin_val);
      x <= std_logic(x_val);
      y <= std_logic(y_val);

      -- Aplica os valores às entradas do full adder
      instancia_fulladder: fulladder port map(Cin => Cin, x => x, y => y, s => s, Cout => Cout);

      -- Adicione aqui o código para verificar as saídas do full adder conforme necessário
    end loop;

    -- Fecha o arquivo de entrada
    file_close(input_file);

    -- Aguarda o final da simulação
    wait;
  end process;

end RTL;



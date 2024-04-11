library ieee;
use ieee.std_logic_1164.all;

entity tb_adder_sub is
end entity tb_adder_sub;

architecture behavioral of tb_adder_sub is
  component adder_sub
    port (
      a        : in std_logic_vector(7 downto 0);
      b        : in std_logic_vector(7 downto 0);
      Su       : in std_logic;
      Eu       : in std_logic;
      data_out : out std_logic_vector(7 downto 0)
    );
  end component adder_sub;

  signal clk, Su, Eu : std_logic := '0';
  signal a_tb, b_tb, data_out_tb : std_logic_vector(7 downto 0);

begin
  -- Instancie l'additionneur (DUT)
  DUT_inst : adder_sub
    port map (
      a        => a_tb,
      b        => b_tb,
      Su       => Su,
      Eu       => Eu,
      data_out => data_out_tb
    );

  -- Processus de l'horloge
  clk_process : process
  begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
  end process;

  -- Processus de stimulus
  stim_proc : process
  begin
    -- Exemple : Charge des valeurs dans a_tb et b_tb
    a_tb <= "11001100";
    b_tb <= "00110011";

    -- Active Su pour l'addition
    Su <= '0';
    wait for 20 ns;

    -- Vérifie la sortie pour l'addition
    assert data_out_tb = "00000000" report "Erreur sur l'addition" severity error;

    -- Active Su pour la soustraction
    Su <= '1';
    wait for 20 ns;

    -- Vérifie la sortie pour la soustraction
    assert data_out_tb = "11001101" report "Erreur sur la soustraction" severity error;

    -- Active Eu pour mettre la sortie en haute impédance
    Eu <= '0';
    wait for 40 ns;

    Eu <= '1';

    wait for 40 ns;

    -- Vérifie que la sortie est en haute impédance
    --assert data_out_tb = (7 downto 0 => 'Z') report "Erreur sur la sortie en haute impédance" severity error;

    wait;
  end process;

end architecture behavioral;
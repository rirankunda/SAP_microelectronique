library ieee;
use ieee.std_logic_1164.all;

entity tb_accumulator is
end entity tb_accumulator;

architecture behavioral of tb_accumulator is
  component accumulator_a
    port (
      clk          : in std_logic;
      La           : in std_logic;
      Ea           : in std_logic;
      data_in      : in std_logic_vector(7 downto 0);
      data_out_bus : out std_logic_vector(7 downto 0);
      data_out_alu : out std_logic_vector(7 downto 0)
    );
  end component accumulator_a;

  signal clk, La, Ea : std_logic := '0';
  signal data_in_tb, data_out_bus_tb, data_out_alu_tb : std_logic_vector(7 downto 0);

begin
  -- Instancie l'accumulateur (DUT)
  DUT_inst : accumulator_a
    port map (
      clk          => clk,
      La           => La,
      Ea           => Ea,
      data_in      => data_in_tb,
      data_out_bus => data_out_bus_tb,
      data_out_alu => data_out_alu_tb
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
    -- Maintiens l'état de La pendant 100 ns
    La <= '1';
    wait for 20 ns;
    La <= '0';

    -- Attends 50 ns
    wait for 50 ns;

    -- Active Ea pendant 30 ns
    Ea <= '1';
    wait for 30 ns;
    Ea <= '0';

    -- Attends 100 ns
    wait for 100 ns;

    -- Exemple : Charge une valeur dans data_in_tb
    data_in_tb <= "11001100";

    -- Attends 50 ns
    wait for 50 ns;

    -- Exemple : Vérifie les sorties
    assert data_out_bus_tb = "11001100" report "Erreur sur data_out_bus" severity error;
    assert data_out_alu_tb = "11001100" report "Erreur sur data_out_alu" severity error;

    wait;
  end process;

end architecture behavioral;
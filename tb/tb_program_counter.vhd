library ieee;
use ieee.std_logic_1164.all;

entity tb_program_counter is
end entity tb_program_counter;

architecture behavioral of tb_program_counter is
  component program_counter
    port (
      clk         : in std_logic;
      clr         : in std_logic;
      Ep          : in std_logic;
      Cp          : in std_logic;
      address_out : out std_logic_vector(3 downto 0)
    );
  end component program_counter;

  signal clk, clr, Ep, Cp : std_logic := '0';
  signal address_out_tb : std_logic_vector(3 downto 0);

begin
  -- Instancie le bloc à tester (DUT)
  DUT_inst : program_counter
    port map (
      clk         => clk,
      clr         => clr,
      Ep          => Ep,
      Cp          => Cp,
      address_out => address_out_tb
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
    -- Maintiens l'état de réinitialisation pendant 100 ns
    clr <= '1';
    Ep <= '0';
    Cp <='0';
    wait for 20 ns;
    clr <= '0';
    Ep <= '1';
    Cp <='1';
    wait for 30 ns;
    clr <='1';
    wait;
  end process;

end architecture behavioral;
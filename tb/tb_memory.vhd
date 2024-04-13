library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_memory is
  generic (runner_cfg : string);
end entity tb_memory;

architecture testbench of tb_memory is

  -- Signals
  signal CE_TB         : std_logic                    := '1'; -- Initialize CE to 1
  signal address_in_TB : std_logic_vector(3 downto 0) := "0000"; -- Example address
  signal data_out_TB   : std_logic_vector(7 downto 0);
  signal sclk          : std_logic;

begin
  -- Instantiate the DUT
  DUT_inst : entity work.memory
    port map(
      CE         => CE_TB,
      address_in => address_in_TB,
      data_out   => data_out_TB
    );

  clk_process : process
  begin
    sclk <= '0';
    wait for 10 ns;
    sclk <= '1';
    wait for 10 ns;
  end process;

  CE_process : process
  begin
    CE_TB <= '1';
    wait for 50 ns;
    CE_TB <= '0';
    wait for 50 ns;
  end process;

  tb_main : process
  begin
    wait for 50 ns;
    test_runner_setup(runner, runner_cfg);
    address_in_TB <= "0000"; -- Address 0
    wait for 200 ns;
    address_in_TB <= "0001"; -- Address 1
    wait for 500 ns;
    test_runner_cleanup(runner);
  end process;

end architecture;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_tang is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_tang is
  signal clk : std_logic;
  signal rst : std_logic;

  signal sbus_out : std_logic_vector(7 downto 0);
  signal seg      : std_logic_vector(6 downto 0);

begin
  clk_process : process
  begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
  end process;

  reset : process
  begin
    rst <= '0';
    wait for 200 ns;
    rst <= '1';
    wait;
  end process;

  tang_9k_sap_1_inst : entity work.tang_9k_sap_1
    port map(
      clk   => clk,
      rst_n => rst,
      bus_o => sbus_out,
      led_o => seg
    );

  tb_main : process
  begin
    test_runner_setup(runner, runner_cfg);
    wait for 1000 ns;
    test_runner_cleanup(runner); -- Simulation ends here
  end process;
end architecture;
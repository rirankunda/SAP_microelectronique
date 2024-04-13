library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_top is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_top is
  signal sclk  : std_logic;
  signal reset : std_logic;

  signal sbus_out                   : std_logic_vector(7 downto 0);
  signal sa, sb, sc, sd, se, sf, sg : std_logic;

begin
  clk_process : process
  begin
    sclk <= '0';
    wait for 10 ns;
    sclk <= '1';
    wait for 10 ns;
  end process;

  rst : process
  begin
    reset <= '0';
    wait for 200 ns;
    reset <= '1';
    wait;
  end process;

  top_inst : entity work.top
    port map(
      clk_in  => sclk,
      clr     => reset,
      bus_out => sbus_out,
      a       => sa,
      b       => sb,
      c       => sc,
      d       => sd,
      e       => se,
      f       => sf,
      g       => sg
    );

  tb_main : process
  begin
    test_runner_setup(runner, runner_cfg);
    wait for 500 ns;
    test_runner_cleanup(runner); -- Simulation ends here
  end process;
end architecture;
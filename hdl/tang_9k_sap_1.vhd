library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tang_9k_sap_1 is
  port (
    clk     : in std_logic;
    rst_n   : in std_logic;
    bus_o  : out std_logic_vector(7 downto 0);
    led_o  : out std_logic_vector(6 downto 0)
  );
end entity;

architecture behavourial of tang_9k_sap_1 is
begin
  top_inst : entity work.top
    port map(
      clk_in   => clk,
      clr      => rst_n,
      bus_out  => bus_o,
      segments => led_o
    );
end architecture;
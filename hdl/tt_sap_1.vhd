library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tt_sap_1 is
  port (
    ui_in   : in std_logic_vector(7 downto 0);
    uo_out  : out std_logic_vector(7 downto 0);
    uio_in  : in std_logic_vector(7 downto 0);
    uio_out : out std_logic_vector(7 downto 0);
    uio_oe  : out std_logic_vector(7 downto 0);
    ena     : in std_logic;
    clk     : in std_logic;
    rst_n   : in std_logic
  );
end entity;

architecture behavourial of tt_sap_1 is
begin
  top_inst : entity work.top
    port map(
      clk_in   => clk,
      clr      => rst_n,
      bus_out  => uo_out,
      segments => uio_out(6 downto 0)
    );
    uio_oe <= (others => '1');
    uio_out(7) <= '0';
end architecture;
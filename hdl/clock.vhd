library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock is
  port (
    clk_in  : in std_logic;
    hlt     : in std_logic;
    clk_out : out std_logic
  );
end entity clock;

architecture behavioral of clock is
  signal i_reg : std_logic_vector(7 downto 0) := (others => '0');
begin
  process (clk_in, hlt)
  begin
    if hlt = '1' then
      clk_out <= '0';
    else
      clk_out <= clk_in;
    end if;
  end process;
end architecture;
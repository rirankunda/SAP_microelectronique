library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
  port (
    clk         : in std_logic;
    reset       : in std_logic;
    enable      : in std_logic;
    count       : in std_logic;
    address_out : out std_logic_vector(3 downto 0)
  );
end entity program_counter;

architecture behavioral of program_counter is
  signal pc_reg : unsigned(3 downto 0) := (others => '0');
begin
  process (clk, reset, count)
  begin
    if reset = '1' then
      pc_reg <= (others => '0');
    elsif rising_edge(clk) then
      if count = '1' then
        pc_reg <= pc_reg + 1;
      end if;
    end if;
  end process;
  address_out <= std_logic_vector(pc_reg);
end architecture;
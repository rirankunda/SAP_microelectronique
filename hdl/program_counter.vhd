library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
  port (
    clk         : in std_logic;
    clr         : in std_logic;
    Ep          : in std_logic;
    Cp          : in std_logic;
    address_out : out std_logic_vector(3 downto 0)
  );
end entity program_counter;

architecture behavioral of program_counter is
  signal pc_reg : unsigned(3 downto 0) := (others => '0');
begin
  process (clk, clr, Cp)
  begin
    if clr = '0' then
      pc_reg <= (others => '0');
    elsif rising_edge(clk) then
      if Cp = '1' then
        pc_reg <= pc_reg + 1;
      end if;
    end if;
  end process;

  process (Ep)
  begin
    if Ep = '1' then
      address_out <= std_logic_vector(pc_reg);
    else
      address_out <= (others => 'Z');
    end if;
  end process;
end architecture;
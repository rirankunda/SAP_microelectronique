library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_b is
  port (
    clk          : in std_logic;
    Lb           : in std_logic;
    data_in      : in std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0)
  );
end entity register_b;

architecture behavioral of register_b is
  signal b_reg : unsigned(7 downto 0) := (others => '0');
begin
  process (clk, Lb)
  begin
    if rising_edge(clk) then
      if Lb = '1' then
        b_reg <= unsigned(data_in);
      end if;
    end if;
  end process;

  data_out <= std_logic_vector(b_reg);

end architecture;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity accumulator_a is
  port (
    clk          : in std_logic;
    La           : in std_logic;
    Ea           : in std_logic;
    data_in      : in std_logic_vector(7 downto 0);
    data_out_bus : out std_logic_vector(7 downto 0);
    data_out_alu : out std_logic_vector(7 downto 0)
  );
end entity accumulator_a;

architecture behavioral of accumulator_a is
  signal a_reg : std_logic_vector(7 downto 0) := (others => '0');
begin
  process (clk, La)
  begin
    if rising_edge(clk) then
      if La = '0' then
        a_reg <= data_in;
      end if;
    end if;
  end process;

  data_out_alu <= a_reg;

  data_out_bus <= a_reg(7 downto 0) when Ea = '1' else (others => 'Z');

end architecture;
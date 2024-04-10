library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity out_register is
  port (
    clk          : in std_logic;
    Lo           : in std_logic;
    data_in      : in std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0)
  );
end entity out_register;

architecture behavioral of out_register is
  signal o_reg : unsigned(7 downto 0) := (others => '0');
begin
  process (clk, Lo)
  begin
    if rising_edge(clk) then
      if Lo = '0' then
        o_reg <= unsigned(data_in);
      end if;
    end if;
  end process;

  data_out <= std_logic_vector(o_reg);

end architecture;
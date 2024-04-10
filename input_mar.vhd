library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity input_mar is
  port (
    clk         : in std_logic;
    Lm          : in std_logic;
    address_in  : in std_logic_vector(3 downto 0);
    address_out : out std_logic_vector(3 downto 0)
  );
end entity input_mar;

architecture behavioral of input_mar is
  signal mar_reg : unsigned(7 downto 0) := (others => '0');
begin
  process (clk, Lm)
  begin
    if rising_edge(clk) then
      if Lm = '0' then
        mar_reg <= unsigned(address_in);
      end if;
    end if;
  end process;

  address_out <= std_logic_vector(mar_reg);

end architecture;
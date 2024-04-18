library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_register is
  port (
    clk            : in std_logic;
    clr            : in std_logic;
    Li             : in std_logic;
    Ei             : in std_logic;
    instruction_in : in std_logic_vector(7 downto 0);
    opcode_out     : out std_logic_vector(3 downto 0);
    address_out    : out std_logic_vector(3 downto 0)
  );
end entity instruction_register;

architecture behavioral of instruction_register is
  signal i_reg : std_logic_vector(7 downto 0) := (others => '0');
begin
  process (clk, clr, Li)
  begin
    if clr = '0' then
      i_reg <= (others => '0');
    elsif rising_edge(clk) then
      if Li = '0' then
        i_reg <= instruction_in;
      end if;
    end if;
  end process;

  opcode_out <= i_reg(7 downto 4);

  address_out <= i_reg(3 downto 0) when Ei = '0' else (others => 'Z');

end architecture;
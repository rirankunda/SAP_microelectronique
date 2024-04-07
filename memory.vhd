library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
  generic (
    data_width    : integer := 8;
    address_width : integer := 8;
    address_size  : integer := 4
  );
  port (
    clk        : in std_logic;
    reset      : in std_logic;
    enable     : in std_logic;
    address_in : in std_logic_vector(address_size - 1 downto 0);
    data_out   : out std_logic_vector(address_width - 1 downto 0)
  );
end entity;

architecture behavourial of memory is
  constant ram_depth : integer := 2 ** address_width;

  type memory_type is array (0 to ram_depth) of std_logic_vector(data_width downto 0);

  -- todo: fill data:
  signal rom : memory_type := (
  0  => "00000000", -- LDA
  1  => "00000000", -- ADD
  2  => "00000000", -- OUT
  3  => "00000000", -- SUB
  4  => "00000000", -- OUT
  5  => "00000000", -- HLT
  6  => "00000000",
  7  => "00000000",
  8  => "00000000",
  9  => "00000000",
  10 => "00000000", -- data
  11 => "00000000",
  12 => "00000000",
  13 => "00000000",
  14 => "00000000",
  15 => "00000000"
  );

  signal address_reg : std_logic_vector(address_size - 1 downto 0);

begin

  process (clk, reset)
  begin
    if reset = '1' then
      address_reg <= (others => '0');
    elsif rising_edge(clk) then
      if enable = '1' then
        address_reg <= address_in;
      end if;
    end if;
  end process;

  data_out <= rom(to_integer(unsigned(address_reg)));

end architecture;
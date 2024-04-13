library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
  port (
    CE         : in std_logic;
    address_in : in std_logic_vector(3 downto 0);
    data_out   : out std_logic_vector(7 downto 0)
  );
end entity;

architecture behavourial of memory is
  type memory_type is array (0 to 15) of std_logic_vector(7 downto 0);

  signal rom : memory_type := (
  0  => "00001010", -- LDA -> 10
  1  => "00011011", -- ADD -> 11
  2  => "11100000", -- OUT
  3  => "00101100", -- SUB -> 12
  4  => "11100000", -- OUT
  5  => "11110000", -- HLT
  6  => "00000000",
  7  => "00000000",
  8  => "00000000",
  9  => "00000000",
  10 => "00000101", -- 5
  11 => "00001000", -- 8
  12 => "00000100", -- 4
  13 => "00000000",
  14 => "00000000",
  15 => "00000000"
  );

begin
  process (CE, rom, address_in)
  begin
    if CE = '0' then
      data_out <= rom(to_integer(unsigned(address_in)));
    else
      data_out <= (others => 'Z');
    end if;
  end process;
end architecture;
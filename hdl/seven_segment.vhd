library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_segment is
  port (
    bcd : in std_logic_vector(3 downto 0); -- BCD input
    seg : out std_logic_vector(6 downto 0) -- 7-segment output
  );
end entity seven_segment;

architecture behavioral of seven_segment is
begin
  process (bcd)
  begin
    case bcd is
      when "0000" => seg <= "0000001"; -- 0
      when "0001" => seg <= "1001111"; -- 1
      when "0010" => seg <= "0010010"; -- 2
      when "0011" => seg <= "0000110"; -- 3
      when "0100" => seg <= "1001100"; -- 4
      when "0101" => seg <= "0100100"; -- 5
      when "0110" => seg <= "0100000"; -- 6
      when "0111" => seg <= "0001111"; -- 7
      when "1000" => seg <= "0000000"; -- 8
      when "1001" => seg <= "0000100"; -- 9
      when "1010" => seg <= "0000010"; -- A
      when "1011" => seg <= "0110000"; -- B
      when "1100" => seg <= "0100111"; -- C
      when "1101" => seg <= "0010001"; -- D
      when "1110" => seg <= "0100010"; -- E
      when "1111" => seg <= "0100110"; -- F
      when others => seg <= "1111111"; -- null
    end case;
  end process;
end architecture;
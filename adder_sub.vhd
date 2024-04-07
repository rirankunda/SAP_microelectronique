library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_sub is
    port (
        a   : in  std_logic_vector(7 downto 0);
        b   : in  std_logic_vector(7 downto 0);
        sub : in  std_logic;
        data_out : out std_logic_vector(7 downto 0)
    );
end adder_sub;

architecture behavioral of adder_sub is
begin
    process(a, b, sub)
    begin
        if sub = '1' then
            data_out <= std_logic_vector(signed(a) - signed(b));
        else
            data_out <= std_logic_vector(signed(a) + signed(b));
        end if;
    end process;
end architecture;

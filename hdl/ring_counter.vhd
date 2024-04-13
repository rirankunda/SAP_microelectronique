library ieee;
use ieee.std_logic_1164.all;

entity ring_counter is
    port(
        clk : in std_logic;
        reset : in std_logic;
        t : out std_logic_vector(5 downto 0)
    );
end ring_counter;

architecture behavioral of ring_counter is
    signal temp : std_logic_vector(5 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '0' then
            temp <= "000001"; -- initialize the counter
        elsif falling_edge(clk) then
            temp <= temp(4 downto 0) & temp(5); -- shift left
        end if;
    end process;
    t <= temp;
end behavioral;

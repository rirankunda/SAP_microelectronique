library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_tb is
end memory_tb;

architecture behavior of memory_tb is 
    signal CE         : std_logic := '0';
    signal address_in : std_logic_vector(3 downto 0) := (others => '0');
    signal data_out   : std_logic_vector(7 downto 0);

    component memory is
        port (
            CE         : in std_logic;
            address_in : in std_logic_vector(3 downto 0);
            data_out   : out std_logic_vector(7 downto 0)
        );
    end component;

begin
    uut: memory port map (
        CE         => CE,
        address_in => address_in,
        data_out   => data_out
    );

    stimulus: process
    begin
        CE <= '0';
        address_in <= "0000";
        wait for 10 ns;

        CE <= '0';
        address_in <= "0001";
        wait for 10 ns;

        CE <='1';

        wait;
    end process stimulus;
end behavior;
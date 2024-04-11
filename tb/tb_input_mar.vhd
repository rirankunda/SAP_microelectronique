library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_input_mar is
end entity tb_input_mar;

architecture testbench of tb_input_mar is
  signal clk         : std_logic := '0';
  signal Lm          : std_logic := '0';
  signal address_in  : std_logic_vector(3 downto 0) := (others => '0');
  signal address_out : std_logic_vector(3 downto 0);

  component input_mar
    port (
      clk         : in std_logic;
      Lm          : in std_logic;
      address_in  : in std_logic_vector(3 downto 0);
      address_out : out std_logic_vector(3 downto 0)
    );
  end component input_mar;

begin
  -- Instantiate the input_mar module
  uut: input_mar
    port map (
      clk         => clk,
      Lm          => Lm,
      address_in  => address_in,
      address_out => address_out
    );

  -- Clock generation process
  process
  begin
    wait for 10 ns;
    clk <= not clk;
  end process;

  -- Stimulus process
  process
  begin
    wait for 5 ns;
    Lm <= '1'; -- Set Lm to high
    wait for 10 ns;
    Lm <= '0'; -- Set Lm to low
    wait for 10 ns;
    address_in <= "1010"; -- Example input address
    wait for 10 ns;
    Lm <='1';
    wait for 50 ns;
    Lm <= '0';
    -- Add more test cases here if needed
    wait;
  end process;

end architecture testbench;
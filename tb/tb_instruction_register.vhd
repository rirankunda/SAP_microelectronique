library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_instruction_register is
end entity tb_instruction_register;

architecture testbench of tb_instruction_register is
  signal clk            : std_logic := '0';
  signal clr            : std_logic := '0';
  signal Li             : std_logic := '0';
  signal Ei             : std_logic := '0';
  signal instruction_in : std_logic_vector(7 downto 0) := (others => '0');
  signal opcode_out     : std_logic_vector(3 downto 0);
  signal address_out    : std_logic_vector(3 downto 0);

  component instruction_register
    port (
      clk            : in std_logic;
      clr            : in std_logic;
      Li             : in std_logic;
      Ei             : in std_logic;
      instruction_in : in std_logic_vector(7 downto 0);
      opcode_out     : out std_logic_vector(3 downto 0);
      address_out    : out std_logic_vector(3 downto 0)
    );
  end component instruction_register;

begin
  -- Instantiate the instruction_register module
  uut: instruction_register
    port map (
      clk            => clk,
      clr            => clr,
      Li             => Li,
      Ei             => Ei,
      instruction_in => instruction_in,
      opcode_out     => opcode_out,
      address_out    => address_out
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
    clr <= '1'; -- Set clr to high
    wait for 10 ns;
    clr <= '0'; -- Set clr to low
    wait for 10 ns;
    Li <= '1'; -- Set Li to high
    wait for 10 ns;
    Li <= '0'; -- Set Li to low
    wait for 10 ns;
    instruction_in <= "11001100"; -- Example input instruction
    wait for 10 ns;
    Ei <= '1'; -- Set Ei to high
    wait for 10 ns;
    Ei <= '0'; -- Set Ei to low
    -- Add more test cases here if needed
    wait;
  end process;

end architecture testbench;
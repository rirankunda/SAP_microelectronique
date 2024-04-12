library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller_sequencer is
  port
  (
    clk       : in std_logic;
    clr       : in std_logic;
    opcode_in : in std_logic_vector(3 downto 0);
    Cp        : out std_logic;
    Ep        : out std_logic;
    Lm        : out std_logic;
    CE        : out std_logic;
    Li        : out std_logic;
    Ei        : out std_logic;
    La        : out std_logic;
    Ea        : out std_logic;
    Su        : out std_logic;
    Eu        : out std_logic;
    Lb        : out std_logic;
    Lo        : out std_logic;
    hlt       : out std_logic
  );
end entity controller_sequencer;

architecture behavioral of controller_sequencer is
  constant SIG_CP : integer := 11;
  constant SIG_EP : integer := 10;
  constant SIG_LM : integer := 9;
  constant SIG_CE : integer := 8;
  constant SIG_LI : integer := 7;
  constant SIG_EI : integer := 6;
  constant SIG_LA : integer := 5;
  constant SIG_EA : integer := 4;
  constant SIG_SU : integer := 3;
  constant SIG_EU : integer := 2;
  constant SIG_LB : integer := 1;
  constant SIG_LO : integer := 0;

  constant OP_LDA : std_logic_vector(3 downto 0) := "0000";
  constant OP_ADD : std_logic_vector(3 downto 0) := "0001";
  constant OP_SUB : std_logic_vector(3 downto 0) := "0010";
  constant OP_OUT : std_logic_vector(3 downto 0) := "1110";
  constant OP_HLT : std_logic_vector(3 downto 0) := "1111";

  signal stage : integer range 0 to 5 := 0;

  signal control_signal : std_logic_vector(11 downto 0) := (others => '0');
  signal hlt_signal     : std_logic                     := '1';

begin
  process (clk, clr)
  begin
    if rising_edge(clk) then
      -- go to idle mode
      if clr = '1' then
        stage <= 0;
      else
        if stage = 5 then
          stage <= 0;
        else
          stage <= stage + 1;
        end if;
      end if;
    end if;
  end process;

  process (stage, opcode_in)
  begin
    -- default high signals
    control_signal(SIG_LO) <= '1';
    control_signal(SIG_LB) <= '1';
    control_signal(SIG_LA) <= '1';
    control_signal(SIG_LI) <= '1';
    control_signal(SIG_CE) <= '1';
    control_signal(SIG_LM) <= '1';
    control_signal(SIG_EI) <= '1';

    case stage is
      when 0 =>
        -- enable program counter (Ep), load into MAR (Lm)
        control_signal(SIG_EP) <= '1';
        control_signal(SIG_LM) <= '0';
      when 1 =>
        -- increment program counter (Cp)
        control_signal(SIG_CP) <= '1';
      when 2 =>
        -- enable memory (CE), load into instruction register (Li)
        control_signal(SIG_CE) <= '0';
        control_signal(SIG_LI) <= '0';
      when 3 =>
        if opcode_in = OP_OUT then
          -- enable accumulator (Ea), load into output register (Lo)
          control_signal(SIG_EA) <= '1';
          control_signal(SIG_LO) <= '0';
        elsif opcode_in = OP_HLT then
          -- halt (hlt)
          hlt_signal <= '0';
        else
          -- load into MAR (Lm), enable instruction register (Ei)
          control_signal(SIG_LM) <= '0';
          control_signal(SIG_EI) <= '0';
        end if;
      when 4 =>
        if opcode_in = OP_LDA then
          -- enable memory (CE), load into accumulator (La)
          control_signal(SIG_CE) <= '1';
          control_signal(SIG_LA) <= '0';
        elsif opcode_in = OP_ADD then
          -- enable memory (CE), load into register b (Lb)
          control_signal(SIG_CE) <= '0';
          control_signal(SIG_LB) <= '0';
        elsif opcode_in = OP_SUB then
          -- enable memory (CE), load into register b (Lb)
          control_signal(SIG_CE) <= '0';
          control_signal(SIG_LB) <= '0';
        end if;
      when 5 =>
        if opcode_in = OP_ADD then
          -- enable adder-sub, enable memory (CE), load into register b (Lb)
          control_signal(SIG_EU) <= '1';
          control_signal(SIG_CE) <= '0';
          control_signal(SIG_LB) <= '0';
        elsif opcode_in = OP_SUB then
          -- enable adder-sub, enable substraction (Su), enable memory (CE), load into register b (Lb)
          control_signal(SIG_EU) <= '1';
          control_signal(SIG_SU) <= '1';
          control_signal(SIG_CE) <= '0';
          control_signal(SIG_LB) <= '0';
        end if;
    end case;
  end process;

  Cp <= control_signal(11);
  Ep <= control_signal(10);
  Lm <= control_signal(9);
  CE <= control_signal(8);
  Li <= control_signal(7);
  Ei <= control_signal(6);
  La <= control_signal(5);
  Ea <= control_signal(4);
  Su <= control_signal(3);
  Eu <= control_signal(2);
  Lb <= control_signal(1);
  Lo <= control_signal(0);

  hlt <= hlt_signal;

end architecture;
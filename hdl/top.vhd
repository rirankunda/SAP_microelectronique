library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
  port (
    clk_in              : in std_logic;
    clr                 : in std_logic;
    bus_out             : out std_logic_vector(7 downto 0);
    a, b, c, d, e, f, g : out std_logic
  );
end entity;

architecture behavourial of top is
  -- clock
  signal clk : std_logic;

  -- bus
  signal bus_signal : std_logic_vector(7 downto 0);

  -- controller sequencer
  signal Cp, Ep, Lm, CE, Li, Ei, La, Ea, Su, Eu, Lb, Lo : std_logic;
  signal hlt                                            : std_logic := '1';

  -- Input & Memory Address Register
  signal mar_out : std_logic_vector(3 downto 0);

  -- accumulator A & register B
  signal acc_a_out : std_logic_vector(7 downto 0);
  signal reg_b_out : std_logic_vector(7 downto 0);

  -- instruction register
  signal ir_out : std_logic_vector(3 downto 0);

  -- output register
  signal out_out : std_logic_vector(7 downto 0);

begin

  clock_inst : entity work.clock
    port map(
      clk_in  => clk_in,
      hlt     => hlt,
      clk_out => clk
    );

  accumulator_a_inst : entity work.accumulator_a
    port map(
      clk          => clk,
      La           => La,
      Ea           => Ea,
      data_in      => bus_signal,
      data_out_bus => bus_signal,
      data_out_alu => acc_a_out
    );

  adder_sub_inst : entity work.adder_sub
    port map(
      a        => acc_a_out,
      b        => reg_b_out,
      sub      => Su,
      data_out => bus_signal
    );

  controller_sequencer_inst : entity work.controller_sequencer
    port map(
      clk       => clk_in,
      clr       => clr,
      opcode_in => ir_out,
      Cp        => Cp,
      Ep        => Ep,
      Lm        => Lm,
      CE        => CE,
      Li        => Li,
      Ei        => Ei,
      La        => La,
      Ea        => Ea,
      Su        => Su,
      Eu        => Eu,
      Lb        => Lb,
      Lo        => Lo,
      hlt       => hlt
    );

  input_mar_inst : entity work.input_mar
    port map(
      clk         => clk,
      Lm          => Lm,
      address_in  => bus_signal(3 downto 0),
      address_out => mar_out
    );

  instruction_register_inst : entity work.instruction_register
    port map(
      clk            => clk,
      clr            => clr,
      Li             => Li,
      Ei             => Ei,
      instruction_in => bus_signal,
      opcode_out     => ir_out,
      address_out    => bus_signal(3 downto 0)
    );

  memory_inst : entity work.memory
    port map(
      CE         => CE,
      address_in => mar_out,
      data_out   => bus_signal
    );

  out_register_inst : entity work.out_register
    port map(
      clk      => clk,
      Lo       => Lo,
      data_in  => bus_signal,
      data_out => out_out
    );

  program_counter_inst : entity work.program_counter
    port map(
      clk         => clk,
      clr         => clr,
      Ep          => Ep,
      Cp          => Cp,
      address_out => bus_signal(3 downto 0)
    );

  register_b_inst : entity work.register_b
    port map(
      clk      => clk,
      Lb       => Lb,
      data_in  => bus_signal,
      data_out => reg_b_out
    );

  seven_segment_inst : entity work.seven_segment
    port map(
      bcd => out_out(3 downto 0),
      seg => a & b & c & d & e & f & g
    );

  bus_out <= bus_signal;

end architecture;
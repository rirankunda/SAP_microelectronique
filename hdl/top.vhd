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
  signal mar_in  : std_logic_vector(3 downto 0);
  signal mar_out : std_logic_vector(3 downto 0);

  -- accumulator A
  signal acc_a_in      : std_logic_vector(7 downto 0);
  signal acc_a_alu_out : std_logic_vector(7 downto 0);
  signal acc_a_bus_out : std_logic_vector(7 downto 0);

  -- register B
  signal reg_b_in  : std_logic_vector(7 downto 0);
  signal reg_b_out : std_logic_vector(7 downto 0);

  -- instruction register
  signal ir_in         : std_logic_vector(7 downto 0);
  signal ir_opcode_out : std_logic_vector(3 downto 0);
  signal ir_addr_out   : std_logic_vector(3 downto 0);

  -- output register
  signal or_in  : std_logic_vector(7 downto 0);
  signal or_out : std_logic_vector(7 downto 0);

  -- program counter
  signal pc_out : std_logic_vector(3 downto 0);

  -- memory
  signal mem_out : std_logic_vector(7 downto 0);

  -- adder substractor
  signal adder_out : std_logic_vector(7 downto 0);
begin

  process (bus_signal, CE, Ep, Ei, Ea, Eu, Lm, Li, La, Lb, Lo, pc_out, ir_addr_out, acc_a_bus_out, adder_out)
  begin
    if Ep = '1' then
      bus_signal(3 downto 0) <= pc_out;
    elsif Ei = '0' then
      bus_signal(3 downto 0) <= ir_addr_out;
    elsif Ea = '1' then
      bus_signal <= acc_a_bus_out;
    elsif Eu = '1' then
      bus_signal <= adder_out;
    elsif CE = '0' then
      bus_signal <= mem_out;
    end if;

    if Lm = '0' then
      mar_in <= bus_signal(3 downto 0);
    elsif Li = '0' then
      ir_in <= bus_signal;
    elsif La = '0' then
      acc_a_in <= bus_signal;
    elsif Lb = '0' then
      reg_b_in <= bus_signal;
    elsif Lo = '0' then
      or_in <= bus_signal;
    end if;

  end process;

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
      data_in      => acc_a_in,
      data_out_bus => acc_a_bus_out,
      data_out_alu => acc_a_alu_out
    );

  adder_sub_inst : entity work.adder_sub
    port map(
      a        => acc_a_alu_out,
      b        => reg_b_out,
      Su       => Su,
      Eu       => Eu,
      data_out => adder_out
    );

  controller_sequencer_inst : entity work.controller_sequencer
    port map(
      clk       => clk_in,
      clr       => clr,
      opcode_in => ir_opcode_out,
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
      address_in  => mar_in,
      address_out => mar_out
    );

  instruction_register_inst : entity work.instruction_register
    port map(
      clk            => clk,
      clr            => clr,
      Li             => Li,
      Ei             => Ei,
      instruction_in => ir_in,
      opcode_out     => ir_opcode_out,
      address_out    => ir_addr_out
    );

  memory_inst : entity work.memory
    port map(
      CE         => CE,
      address_in => mar_out,
      data_out   => mem_out
    );

  out_register_inst : entity work.out_register
    port map(
      clk      => clk,
      Lo       => Lo,
      data_in  => or_in,
      data_out => or_out
    );

  program_counter_inst : entity work.program_counter
    port map(
      clk         => clk,
      clr         => clr,
      Ep          => Ep,
      Cp          => Cp,
      address_out => pc_out
    );

  register_b_inst : entity work.register_b
    port map(
      clk      => clk,
      Lb       => Lb,
      data_in  => reg_b_in,
      data_out => reg_b_out
    );

  seven_segment_inst : entity work.seven_segment
    port map(
      bcd    => or_out(3 downto 0),
      seg(0) => a,
      seg(1) => b,
      seg(2) => c,
      seg(3) => d,
      seg(4) => e,
      seg(5) => f,
      seg(6) => g
    );

  bus_out <= bus_signal;

end architecture;
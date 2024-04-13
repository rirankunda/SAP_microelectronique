library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller_sequencer is
  port (
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
  signal T                        : std_logic_vector(6 downto 1);
  signal LDA, ADD, SUB, OUTP, HALT : std_logic;
begin
  ring_counter_inst : entity work.ring_counter
    port map(
      clk   => clk,
      reset => clr,
      t     => T
    );

  instruction_decoder_inst : entity work.instruction_decoder
    port map(
      op_code => opcode_in,
      LDA     => LDA,
      ADD     => ADD,
      SUB     => SUB,
      OUTP    => OUTP,
      HLT     => HALT
    );

  Cp  <= T(2);
  Ep  <= T(1);
  Lm  <= not ((T(4) and LDA) or (T(4) and ADD) or (T(4) and SUB) or T(1));
  CE  <= not ((T(5) and LDA) or (T(5) and ADD) or (T(5) and SUB) or T(3));
  Li  <= not T(3);
  Ei  <= not ((T(4) and LDA) or (T(4) and ADD) or (T(4) and SUB));
  La  <= not ((T(5) and LDA) or (T(6) and ADD) or (T(6) and SUB));
  Ea  <= T(4) and OUTP;
  Su  <= T(6) and SUB;
  Eu  <= (T(6) and ADD) or (T(6) and SUB);
  Lb  <= not ((T(5) and ADD) or (T(5) and SUB));
  Lo  <= T(4) nand OUTP;
  hlt <= HALT;

end architecture;